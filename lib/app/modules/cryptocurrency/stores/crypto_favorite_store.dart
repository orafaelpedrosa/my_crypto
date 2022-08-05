import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/databases/db_repository.dart';

class CryptoFavorite
    extends NotifierStore<Exception, List<CryptocurrencySimpleModel>> {
  CryptoFavorite() : super([]);

  List<CryptocurrencySimpleModel> _list =
      List<CryptocurrencySimpleModel>.empty(growable: true);
  final LoginStore loginStore = Modular.get();
  late FirebaseFirestore db;

  _startFirestore() {
    db = DBRepository.get();
  }

  Future<void> saveAll(List<CryptocurrencySimpleModel> cryptos) async {
    cryptos.forEach((crypto) async {
      if (_list.any((current) => current.id == crypto.id)) {
        _list.add(crypto);
        await db
            .collection('users')
            .doc(loginStore.userCurrent!.uid)
            .collection('favorites')
            .doc(crypto.id)
            .set({
          'id': crypto.id,
          'name': crypto.name,
          'symbol': crypto.symbol,
          'price': crypto.currentPrice,
          'image': crypto.image,
          'isFavorite': true,
        });
      }
    });
    update(_list);
  }

  Future<void> removeFavorite(CryptocurrencySimpleModel crypto) async {
    _list.removeWhere((current) => current.id == crypto.id);
    await db
        .collection('users')
        .doc(loginStore.userCurrent!.uid)
        .collection('favorites')
        .doc(crypto.id)
        .delete();
  }

  Future<void> addFavorite(CryptocurrencySimpleModel crypto) async {
    if (_list.any((current) => current.id == crypto.id)) {
      return;
    }
    _list.add(crypto);
    await db
        .collection('users')
        .doc(loginStore.userCurrent!.uid)
        .collection('favorites')
        .doc(crypto.id)
        .set({
      'id': crypto.id,
      'name': crypto.name,
      'symbol': crypto.symbol,
      'price': crypto.currentPrice,
      'image': crypto.image,
      'isFavorite': true,
    });
    update(_list);
  }

  _readFavorites() async {
    if (loginStore.userCurrent != null && state.isEmpty) {
      final snapshot = await db
          .collection('users')
          .doc(loginStore.userCurrent!.uid)
          .collection('favorites')
          .get();
      snapshot.docs.forEach((doc) {
        _list.add(CryptocurrencySimpleModel.fromJson(doc.data()));
      });
      update(_list);
    }
  }
}
