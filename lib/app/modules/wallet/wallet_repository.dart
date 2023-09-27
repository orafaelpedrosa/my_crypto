import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/enums/operation_historic_enum.dart';
import 'package:mycrypto/app/core/models/coin_search_model.dart';
import 'package:mycrypto/app/core/services/firestore_repository.dart';
import 'package:mycrypto/app/core/services/http_service.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/markets_params_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/price_simple_model.dart';
import 'package:mycrypto/app/modules/wallet/models/fiat_coin_widget.dart';
import 'package:mycrypto/app/modules/wallet/models/market_chart_model.dart';
import 'package:mycrypto/app/modules/wallet/models/transaction_model.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';

class WalletRepository extends Disposable {
  final httpService = HttpService();
  late FirebaseFirestore db;
  UserStore userStore = Modular.get();
  FiatCoinModel fiatCoin = FiatCoinModel();

  startFirestore() async {
    db = FirestoreRepository.get();
  }

  //obtem a lista de todas as moedas que estão no mercado
  Future<List<CoinSearchModel>> getSearchCoin(String value) async {
    List<CoinSearchModel> cryptos = List.empty(growable: true);
    try {
      final Response _response = await httpService.get(
        '/search',
        queryParameters: {
          'query': value,
        },
      );
      await _response.data['coins'].forEach(
        (coin) {
          cryptos.add(
            CoinSearchModel.fromJson(coin),
          );
        },
      );
      return cryptos;
    } catch (e) {
      log(e.toString());
      throw e;
    }
  }

  //adiciona uma moeda na carteira
  Future<void> addCryptocurrency(MyCryptoModel crypto) async {
    startFirestore();
    await db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('wallet')
        .doc(crypto.id)
        .set(crypto.toMap());
  }

  //remove uma moeda que está na carteira
  Future<void> removeCryptocurrency(MyCryptoModel crypto) async {
    startFirestore();
    await db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('wallet')
        .doc(crypto.id)
        .delete();
  }

  //obtem todas as moedas que estão na carteira
  Future<List<MyCryptoModel>> getAllWalletCoins() async {
    startFirestore();
    final List<MyCryptoModel> _walletCoinList = List.empty(growable: true);
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('wallet')
        .get();
    querySnapshot.docs.forEach((doc) {
      _walletCoinList.add(MyCryptoModel.fromMap(
        doc.data(),
      ));
    });
    return _walletCoinList;
  }

  //atualiza o objeto moeda na carteira
  Future<void> updateCryptocurrency(MyCryptoModel crypto) async {
    startFirestore();
    db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('wallet')
        .doc(crypto.id)
        .update(crypto.toMap());
  }

  //obtem uma moeda que está na carteira pelo id
  Future<MyCryptoModel> getCryptocurrencyByID(String id) async {
    final DocumentSnapshot<Map<String, dynamic>> doc = await db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('wallet')
        .doc(id)
        .get();
    if (doc.exists) {
      return MyCryptoModel.fromMap(doc.data()!);
    } else {
      throw Exception('Não foi possível encontrar a moeda');
    }
  }

  //obtem a lista de ids das moedas que estão na carteira
  Future<List<String>> getListOfWalletIDs() async {
    startFirestore();
    List<String> ids = List.empty(growable: true);
    final QuerySnapshot<Map<String, dynamic>> _querySnapshot = await db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('wallet')
        .get();
    _querySnapshot.docs.forEach((doc) {
      ids.add(doc.id);
    });
    return ids;
  }

  //obtem o preço atual de moedas que estão na carteira
  Future<List<PriceSimpleModel>> getSimplePriceList(List<String> ids) async {
    List<PriceSimpleModel> _coinSimplePriceList = List.empty(growable: true);
    final Response _response = await httpService.get(
      '/simple/price/',
      queryParameters: {
        'vs_currencies': 'usd',
        'ids': ids.join(','),
      },
    );

    final _listCoinsDecode = jsonDecode(jsonEncode(_response.data));

    _listCoinsDecode.forEach((key, value) {
      _coinSimplePriceList.add(PriceSimpleModel.fromMap(value));
      _coinSimplePriceList.last.id = key;
    });
    return _coinSimplePriceList;
  }

  // obtem o preço atual de uma moeda
  Future<PriceSimpleModel> getSimplePriceID(String id) async {
    try {
      final Response _response = await httpService.get(
        '/simple/price/',
        queryParameters: {
          'vs_currencies': 'usd',
          'ids': id,
        },
      );
      final coinDecode = _response.data;
      final PriceSimpleModel _coinSimplePrice =
          PriceSimpleModel.fromMap(coinDecode[id]);
      _coinSimplePrice.id = id;
      return _coinSimplePrice;
    } catch (e) {
      log(e.toString());
      throw e;
    }
  }

  Future<void> updatePrice() async {
    startFirestore();
    late String profit;
    late String profitPercentage;

    //obtem a lista de ids das moedas que estão na carteira
    final List<String> ids = await getListOfWalletIDs();

    //obtem o preço atual de todas as moedas que estão na carteira
    final List<PriceSimpleModel> currentPriceList =
        await getSimplePriceList(ids);

    //obtem todas as moedas da carteira
    List<MyCryptoModel> myCryptosList = await getAllWalletCoins();

    if (myCryptosList.isNotEmpty) {
      myCryptosList.forEach(
        (myCrypto) {
          currentPriceList.forEach(
            (currentPrice) async {
              if (myCrypto.id == currentPrice.id) {
                myCrypto.currentPrice = currentPrice.usd;
                profit = ((myCrypto.currentPrice! * myCrypto.amount!) -
                        (myCrypto.averagePrice! * myCrypto.amount!))
                    .toStringAsFixed(2);
                myCrypto.profit = double.parse(profit);
                profitPercentage = ((myCrypto.profit! /
                            (myCrypto.averagePrice! * myCrypto.amount!)) *
                        100)
                    .toStringAsFixed(2);
                myCrypto.profitPercentage = double.parse(profitPercentage);
                myCrypto.totalValue = myCrypto.currentPrice! * myCrypto.amount!;
                await updateCryptocurrency(myCrypto);
              }
            },
          );
        },
      );
    } else {
      log('Não há moedas na carteira');
    }
  }

  Future<void> addCrypto(MyCryptoModel newCrypto) async {
    startFirestore();
    final List<MyCryptoModel> myCryptos = await getAllWalletCoins();
    TransactionHistoryModel historic = TransactionHistoryModel();
    MyCryptoModel myCrypto = MyCryptoModel();

    bool found = myCryptos.any((element) => element.id == newCrypto.id);
    if (found) {
      //obtem a moeda que está na carteira
      myCrypto = await getCryptocurrencyByID(newCrypto.id!);

      //media ponderada em relaçao ao valor atual e ao valor anterior sem arredondamento
      final double newAveragePrice =
          ((myCrypto.averagePrice!.toDouble() * myCrypto.amount!.toDouble()) +
                  (newCrypto.averagePrice!.toDouble() *
                      newCrypto.amount!.toDouble())) /
              (myCrypto.amount!.toDouble() + newCrypto.amount!.toDouble());
      final double newAmount = myCrypto.amount!.toDouble() + newCrypto.amount!;
      myCrypto.averagePrice = newAveragePrice;
      myCrypto.amount = newAmount;

      await updateCryptocurrency(myCrypto);
    } else {
      await addCryptocurrency(newCrypto);
    }

    historic.id = newCrypto.id;
    historic.name = newCrypto.name;
    historic.value = newCrypto.amount;
    historic.purchasePrice = newCrypto.currentPrice;
    //DATE TIME ONTEM
    historic.date = DateTime.now();
    historic.operation = OperationHistoricEnum.add;

    await addTransactionHistoryHistoric(historic);
  }

  Future<void> updateAddOrRemoveCrypto(
      MyCryptoModel updatedCrypto, OperationHistoricEnum operation) async {
    startFirestore();
    final List<MyCryptoModel> myCryptos = await getAllWalletCoins();
    TransactionHistoryModel historic = TransactionHistoryModel();
    MyCryptoModel myCrypto = MyCryptoModel();

    bool found = myCryptos.any((element) => element.id == updatedCrypto.id);
    if (found) {
      // Obtém a moeda que está na carteira
      myCrypto = await getCryptocurrencyByID(updatedCrypto.id!);

      if (operation == OperationHistoricEnum.add) {
        // Adiciona a quantidade de criptomoeda à carteira
        // Média ponderada em relação ao valor atual e ao valor anterior sem arredondamento
        final double newAveragePrice = ((myCrypto.averagePrice!.toDouble() *
                    myCrypto.amount!.toDouble()) +
                (updatedCrypto.averagePrice!.toDouble() *
                    updatedCrypto.amount!.toDouble())) /
            (myCrypto.amount!.toDouble() + updatedCrypto.amount!.toDouble());
        final double newAmount =
            myCrypto.amount!.toDouble() + updatedCrypto.amount!;
        myCrypto.averagePrice = newAveragePrice;
        myCrypto.amount = newAmount;

        await updateCryptocurrency(myCrypto);
      } else if (operation == OperationHistoricEnum.remove) {
        // Remove a quantidade de criptomoeda da carteira
        if (updatedCrypto.amount! >= myCrypto.amount!) {
          // Remove completamente a criptomoeda da carteira
          await removeCryptocurrency(myCrypto);
        } else {
          // Atualiza a quantidade e o preço médio da criptomoeda na carteira
          final double newAmount =
              myCrypto.amount!.toDouble() - updatedCrypto.amount!;
          myCrypto.amount = newAmount;

          await updateCryptocurrency(myCrypto);
        }
      }
    } else {
      if (operation == OperationHistoricEnum.add && updatedCrypto.amount! > 0) {
        // Adiciona uma nova criptomoeda à carteira
        await addCryptocurrency(updatedCrypto);
      }
    }

    historic.id = updatedCrypto.id;
    historic.name = updatedCrypto.name;
    historic.value = updatedCrypto.amount;
    historic.purchasePrice = updatedCrypto.currentPrice;
    historic.date = DateTime.now();
    historic.operation = operation;
    await addTransactionHistoryHistoric(historic);
  }

  Future<String> updateTotalWallet() async {
    final List<MyCryptoModel> myCryptos = await getAllWalletCoins();
    double totalWallet = 0;

    if (myCryptos.isNotEmpty) {
      myCryptos.forEach((myCrypto) {
        totalWallet += myCrypto.totalValue!;
      });
      return totalWallet.toString();
    }
    return '0';
  }

  Future<List<CryptocurrencySimpleModel>> getListCryptocurrenciesData(
      MarketsParamsModel paramsModel) async {
    try {
      final Response _response = await httpService.get(
        '/coins/markets',
        queryParameters: paramsModel.toJson(),
      );

      final List<CryptocurrencySimpleModel> _cryptocurrencies =
          List.empty(growable: true);
      _response.data.forEach(
        (coin) {
          _cryptocurrencies.add(CryptocurrencySimpleModel.fromJson(coin));
        },
      );
      return _cryptocurrencies;
    } catch (e) {
      log('Error getList: $e');
      rethrow;
    }
  }

  // Future<FiatCoinModel> getPriceDolarInBRL() async {
  //   final Response _response = await httpService.get(
  //     'https://economia.awesomeapi.com.br/json/last/USD-BRL',
  //   );

  //   return FiatCoinModel.fromMap(_response.data['USDBRL']);
  // }

  Future<void> addTransactionHistoryHistoric(
      TransactionHistoryModel historic) async {
    startFirestore();
    await db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('transactions')
        .add(
          historic.toMap(),
        );
  }

  Future<CryptoData> getMarketChart(String id) async {
    try {
      final Response _response = await httpService.get(
        '/coins/$id/market_chart',
        queryParameters: {
          'vs_currency': 'usd',
          'days': '7',
        },
      );
      final CryptoData cryptoData = CryptoData.fromJson(_response.data);
      return cryptoData;
    } catch (e) {
      log('Error getMarketChart: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
