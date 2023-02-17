import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/services/firestore_repository.dart';
import 'package:mycrypto/app/core/user_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';

class WalletRepository extends Disposable {
  final Dio _dio = Dio();
  late FirebaseFirestore db;
  UserStore userStore = Modular.get();

  startFirestore() async {
    db = FirestoreRepository.get();
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
    await db
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
    final QuerySnapshot<Map<String, dynamic>> _querySnapshot = await db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('wallet')
        .get();

    return _querySnapshot.docs.map((doc) => doc.id).toList();
  }

  Future<List<CryptocurrencySimpleModel>> getCryptoData(
      List<String> ids) async {
    final Response _response = await _dio.get(
      'https://api.coingecko.com/api/v3/coins/markets',
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
    final List<String> idsList = await getListOfWalletIDs();
    final List<CryptocurrencySimpleModel> cryptos =
        await getCryptoData(idsList);

    final List<MyCryptoModel> myCryptos = await getAll();

    myCryptos.forEach((myCrypto) async {
      final CryptocurrencySimpleModel crypto = cryptos.firstWhere(
        (crypto) => crypto.id == myCrypto.id,
      );
      myCrypto.currentPrice = crypto.currentPrice;
      myCrypto.profit = myCrypto.currentPrice! * myCrypto.amount! -
          myCrypto.averagePrice! * myCrypto.amount!;
      myCrypto.profitPercentage = myCrypto.profit! / myCrypto.averagePrice!;
      myCrypto.lastUpdate = DateTime.now().toString();
      await updateCryptocurrency(myCrypto);
    });

    // for (var i = 0; i < idsList.length; i++) {
    //   final MyCryptoModel crypto = await getCryptocurrencyByID(idsList[i]);
    //   crypto.currentPrice = cryptos[i].currentPrice;
    //   crypto.profit = crypto.currentPrice! * crypto.amount! -
    //       crypto.averagePrice! * crypto.amount!;
    //   crypto.profitPercentage = crypto.profit! / crypto.averagePrice!;
    //   crypto.lastUpdate = DateTime.now().toString();
    //   await updateCryptocurrency(crypto);
    // }
  }

  @override
  void dispose() {
    _dio.close();
    db.terminate();
  }
}
