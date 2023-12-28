import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/enums/operation_historic_enum.dart';
import 'package:mycrypto/app/core/models/coin_search_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/markets_params_model.dart';
import 'package:mycrypto/app/modules/wallet/models/market_chart_model.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';
import 'package:mycrypto/app/modules/wallet/models/transaction_model.dart';
import 'package:mycrypto/app/modules/wallet/wallet_repository.dart';

// ignore: must_be_immutable
class WalletStore extends Store<List<MyCryptoModel>> {
  WalletStore() : super([]);

  final WalletRepository _repository = WalletRepository();

  List<CoinSearchModel> listSearch = List.empty(growable: true);
  List<CryptocurrencySimpleModel> coinsList = List.empty(growable: true);
  MyCryptoModel cryptoModel = MyCryptoModel();
  DateTime date = DateTime.now();
  late StreamSubscription subscription;
  String fiat = 'USD';
  CryptoData cryptoData = CryptoData();

  Future<void> updateState() async {
    update(state, force: true);
  }

  Future<void> addCryptocurrency(MyCryptoModel crypto) async {
    setLoading(true);
    await _repository.addCrypto(crypto).then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }

  Future<void> removeCryptocurrency(MyCryptoModel crypto) async {
    setLoading(true);
    await _repository.removeCryptocurrency(crypto).then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }

  Future<void> updateCryptocurrency(MyCryptoModel crypto) async {
    setLoading(true);
    await _repository.updateCryptocurrency(crypto).then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }

  Future<void> updatePrice() async {
    setLoading(true);
    await _repository.updatePrice().then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
    });
  }

  Future<void> getAllWalletCoins() async {
    setLoading(true);
    await _repository.getAllWalletCoins().then((value) {
      update(value);
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
    });
  }

  Future<void> totalValue() async {
    setLoading(true);
    await _repository.updateTotalWallet().then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
    });
    setLoading(false);
  }

  Future<void> getSearchCoin(String text) async {
    setLoading(true);
    listSearch = await _repository.getSearchCoin(text).then((value) {
      setLoading(false);
      return value;
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }

  Future<void> getSimplePriceID(String id) async {
    setLoading(true);
    await _repository.getSimplePriceID(id).then((value) {
      cryptoModel.currentPrice = value.usd;
      update(state, force: true);
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }

  Future<void> getListCryptocurrenciesData(
      MarketsParamsModel paramsModel) async {
    setLoading(true);
    paramsModel.ids = await _repository.getListOfWalletIDs();
    await _repository.getListCryptocurrenciesData(paramsModel).then((value) {
      coinsList = value;
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }

  // Future<double> getPriceDolarInBRL() async {
  //   setLoading(true);
  //   double priceDolar = 1;
  //   await _repository.getPriceDolarInBRL().then((value) {
  //     cryptoModel.currentPrice =
  //         (cryptoModel.currentPrice! * double.parse(value.ask!));
  //     setLoading(false);
  //   }).catchError((e) {
  //     setLoading(false);
  //     setError(e);
  //     throw e;
  //   });
  //   return priceDolar;
  // }

  Future<void> getAll(String id) async {
    setLoading(true);
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .collection('wallet')
            .get();
    final List<MyCryptoModel> list = querySnapshot.docs
        .map((doc) => MyCryptoModel.fromMap(doc.data()))
        .toList();
    update(list);
    setLoading(false);
  }

  Future<void> listenWallet(String userID) async {
    setLoading(true);
    subscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('wallet')
        .snapshots()
        .listen(
      (obj) {
        subscription.pause();
        if (obj.docs.isNotEmpty) {
          final List<MyCryptoModel> list =
              obj.docs.map((doc) => MyCryptoModel.fromMap(doc.data())).toList();
          update(list, force: true);
        } else {
          update(List.empty(growable: true), force: true);
        }
        subscription.resume();
        setLoading(false);
      },
      onError: (e) {
        setLoading(false);
        setError(e);
      },
      onDone: () {
        setLoading(false);
      },
      cancelOnError: true,
    );
  }

  Future<void> addTransactionHistory(TransactionHistoryModel historic) async {
    setLoading(true);
    await _repository.addTransactionHistoryHistoric(historic).then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }

  Future<void> updateTransactionHistory(
      MyCryptoModel coin, OperationHistoricEnum operatiion) async {
    setLoading(true);
    await _repository.updateAddOrRemoveCrypto(coin, operatiion).then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }

  Future<void> getMarketChart(String id) async {
    setLoading(true);
    await _repository.getMarketChart(id).then((value) {
      cryptoData = value;
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }
}
