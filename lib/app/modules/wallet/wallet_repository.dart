import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/models/coin_search_model.dart';
import 'package:mycrypto/app/core/services/firestore_repository.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';

class WalletRepository extends Disposable {
  final Dio _dio = Dio();
  late FirebaseFirestore db;
  UserStore userStore = Modular.get();
  final String _urlBase = dotenv.get('URL_BASE');

  startFirestore() async {
    db = FirestoreRepository.get();
  }

  Future<SearchModel> getSearchCoin(String value) async {
    try {
      final Response _response = await _dio.get(
        '$_urlBase/search',
        queryParameters: {
          'query': value,
        },
      );
      return SearchModel.fromJson(_response.data);
    } catch (e) {
      log(e.toString());
      throw e;
    }
  }

  Future<void> addCryptocurrency(MyCryptoModel crypto) async {
    startFirestore();
    log('WalletRepository: addCryptocurrency: ${crypto.id}');
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

  Future<List<CryptocurrencySimpleModel>> getCurrentPrice() async {
    final List<String> ids = await getListOfWalletIDs();
    final Response _response = await _dio.get(
      '$_urlBase/coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
        'ids': ids.join(','),
      },
    );
    final List<CryptocurrencySimpleModel> cryptos = List.empty(growable: true);
    _response.data.forEach(
      (crypto) {
        cryptos.add(CryptocurrencySimpleModel.fromJson(crypto));
      },
    );
    return cryptos;
  }

  Future<void> updatePrice() async {
    final List<CryptocurrencySimpleModel> cryptos = await getCurrentPrice();
    final List<MyCryptoModel> myCryptos = await getAll();

    if (myCryptos.isNotEmpty) {
      myCryptos.forEach((myCrypto) async {
        final CryptocurrencySimpleModel crypto = cryptos.firstWhere(
          (crypto) => crypto.id == myCrypto.id,
        );
        myCrypto.currentPrice = crypto.currentPrice;
        myCrypto.profit = myCrypto.currentPrice! * myCrypto.amount! -
            myCrypto.averagePrice! * myCrypto.amount!;
        myCrypto.profitPercentage = myCrypto.profit! / myCrypto.averagePrice!;
        myCrypto.totalValue = myCrypto.currentPrice! * myCrypto.amount!;
        await updateCryptocurrency(myCrypto);
      });
    }
  }

  // Future<void> updateTotalWallet() async {
  //   final List<MyCryptoModel> myCryptos = await getAll();
  //   double totalWallet = 0;

  //   if (myCryptos.isNotEmpty) {
  //     myCryptos.forEach((myCrypto) {
  //       totalWallet += myCrypto.totalValue!;
  //     });
  //   }
  //   log('Total wallet: $totalWallet');
  // }

  @override
  void dispose() {
    _dio.close();
    db.terminate();
  }
}
