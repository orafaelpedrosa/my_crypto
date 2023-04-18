import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/models/coin_search_model.dart';
import 'package:mycrypto/app/core/services/firestore_repository.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/price_simple_model.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';

class WalletRepository extends Disposable {
  final Dio _dio = Dio();
  late FirebaseFirestore db;
  UserStore userStore = Modular.get();
  final String _urlBase = dotenv.get('URL_BASE');

  startFirestore() async {
    db = FirestoreRepository.get();
  }

  Future<List<CoinSearchModel>> getSearchCoin(String value) async {
    List<CoinSearchModel> cryptos = List.empty(growable: true);
    try {
      final Response _response = await _dio.get(
        '$_urlBase/search',
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
      log(cryptos.length.toString());
      return cryptos;
    } catch (e) {
      log(e.toString());
      throw e;
    }
  }

  Future<void> addCryptocurrency(MyCryptoModel crypto) async {
    startFirestore();
    await db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('wallet')
        .doc(crypto.id)
        .set(crypto.toMap());
  }

  Future<void> removeCryptocurrency(MyCryptoModel crypto) async {
    await db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('wallet')
        .doc(crypto.id)
        .delete();
  }

  Future<List<MyCryptoModel>> getAll() async {
    startFirestore();
    final List<MyCryptoModel> cryptos = List.empty(growable: true);
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('wallet')
        .get();
    querySnapshot.docs.forEach((doc) {
      cryptos.add(MyCryptoModel.fromMap(
        doc.data(),
      ));
    });
    return cryptos;
  }

  Future<void> updateCryptocurrency(MyCryptoModel crypto) async {
    db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('wallet')
        .doc(crypto.id)
        .update(crypto.toMap());
  }

  Future<MyCryptoModel> getCryptocurrencyByID(String id) async {
    final DocumentSnapshot<Map<String, dynamic>> doc = await db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('wallet')
        .doc(id)
        .get();
    return MyCryptoModel.fromMap(doc.data()!);
  }

  Future<List<String>> getListOfWalletIDs() async {
    startFirestore();
    final List<String> ids = List.empty(growable: true);

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

  Future<List<PriceSimpleModel>> getSimplePriceList(List<String> ids) async {
    final List<PriceSimpleModel> _coinSimplePriceList =
        List.empty(growable: true);
    final Response _response = await _dio.get(
      '$_urlBase/simple/price/',
      queryParameters: {
        'vs_currencies':
            '${userStore.state.userPreference.vsCurrency!.toLowerCase()}',
        'ids': ids.join(','),
      },
    );

    final _listCoinsDecode = jsonDecode(jsonEncode(_response.data));

    _listCoinsDecode.forEach((key, value) {
      _coinSimplePriceList.add(PriceSimpleModel.fromJson(value));
      _coinSimplePriceList.last.id = key;
    });
    return _coinSimplePriceList;
  }

  Future<PriceSimpleModel> getSimplePriceID(String id) async {
    try {
      final Response _response = await _dio.get(
        '$_urlBase/simple/price/',
        queryParameters: {
          'vs_currencies':
              '${userStore.state.userPreference.vsCurrency?.toLowerCase()}',
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
    final List<String> ids = await getListOfWalletIDs();
    final List<PriceSimpleModel> _currentPriceList =
        await getSimplePriceList(ids);
    final List<MyCryptoModel> _myCryptosList = await getAll();

    if (_myCryptosList.isNotEmpty) {
      _myCryptosList.forEach((myCrypto) async {
        final PriceSimpleModel crypto = _currentPriceList.firstWhere(
          (crypto) => crypto.id == myCrypto.id,
        );
        myCrypto.currentPrice = crypto.usd;
        myCrypto.profit = myCrypto.currentPrice! * myCrypto.amount! -
            myCrypto.averagePrice! * myCrypto.amount!;
        myCrypto.profitPercentage = myCrypto.profit! / myCrypto.averagePrice!;
        myCrypto.totalValue = myCrypto.currentPrice! * myCrypto.amount!;
        await updateCryptocurrency(myCrypto);
      });
    }
  }

  Future<String> updateTotalWallet() async {
    final List<MyCryptoModel> myCryptos = await getAll();
    double totalWallet = 0;

    if (myCryptos.isNotEmpty) {
      myCryptos.forEach((myCrypto) {
        totalWallet += myCrypto.totalValue!;
      });
      return totalWallet.toString();
    }
    return '0';
  }

  @override
  void dispose() {}
}
