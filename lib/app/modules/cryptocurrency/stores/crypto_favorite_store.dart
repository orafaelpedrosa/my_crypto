import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/databases/firestore_repository.dart';

class CryptoFavoriteStore
    extends NotifierStore<Exception, List<CryptocurrencySimpleModel>> {
  CryptoFavoriteStore() : super([]);

  List<CryptocurrencySimpleModel> _list =
      List<CryptocurrencySimpleModel>.empty(growable: true);
  final LoginStore loginStore = Modular.get();
  late FirebaseFirestore db;
  User? user;

  _startFavorites() async {
    loginStore.authCheck();
    _startFirestore();
  }

  _startFirestore() async {
    db = FirestoreRepository.get();
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
        }).then((value) {
          update(_list);
          log('saveAll: ${crypto.name}');
        }).catchError((error) {
          log(error);
          throw error;
        });
      }
    });
  }

  Future<void> removeFavorite(CryptocurrencySimpleModel crypto) async {
    await db
        .collection('users')
        .doc(loginStore.userCurrent!.uid)
        .collection('favorites')
        .doc(crypto.id)
        .delete()
        .then((value) {
      _list.removeWhere((current) => current.id == crypto.id);
      update(_list);
      log('removed');
    }).catchError((error) {
      log(error);
      throw error;
    });
  }

  Future<void> addFavorite(CryptocurrencySimpleModel crypto) async {
    _startFavorites();
    if (_list.any((current) => current.id == crypto.id)) {
      return;
    }
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
    }).then((value) {
      _list.add(crypto);
      update(_list);
      log('add');
    }).catchError((error) {
      log(error);
      throw error;
    });
  }

  readFavorites() async {
    if (loginStore.userCurrent != null && state.isNotEmpty) {
      final snapshot = await db
          .collection('users')
          .doc(loginStore.userCurrent!.uid)
          .collection('favorites')
          .get()
          .then((value) {
        update(_list);
        log('get favorites');
      }).catchError((error) {
        log(error);
        throw error;
      });
      snapshot.docs.forEach((doc) {
        _list.add(CryptocurrencySimpleModel.fromJson(doc.data()));
      });
      update(_list);
      _list.forEach((crypto) {
        log('${crypto.name}');
      });
    } else {
      log('User ${loginStore.userCurrent}');
    }
  }
}
