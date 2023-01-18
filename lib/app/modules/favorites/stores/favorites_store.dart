import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/authentication/user_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/core/services/firestore_repository.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/markets_params_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/repositories/cryptocurrency_repository.dart';

// ignore: must_be_immutable
class FavoritesStore
    extends NotifierStore<Exception, List<CryptocurrencySimpleModel>> {
  FavoritesStore() : super([]);

  List<CryptocurrencySimpleModel> _list =
      List<CryptocurrencySimpleModel>.empty(growable: true);
  List<String> _listIDs = List<String>.empty(growable: true);
  MarketsParamsModel marketsParams = MarketsParamsModel();

  final LoginStore loginStore = Modular.get();
  final CryptocurrencyRepository _repository =
      Modular.get<CryptocurrencyRepository>();
  late FirebaseFirestore db;
  UserStore userStore = Modular.get();

  _startFavorites() async {
    userStore.getUser();
    _startFirestore();
  }

  _startFirestore() async {
    db = FirestoreRepository.get();
  }

  Future<void> _saveAll(List<CryptocurrencySimpleModel> cryptos) async {
    cryptos.forEach((crypto) async {
      if (_list.any((current) => current.id == crypto.id)) {
        _list.add(crypto);
        await db
            .collection('users')
            .doc(userStore.user!.uid)
            .collection('favorites')
            .doc(crypto.id)
            .set({
          'id': crypto.id,
        }).then((value) {
          update(_list);
          updateState();
          log('saveAll: ${crypto.name}');
        }).catchError((error) {
          log(error);
          throw error;
        });
      }
    });
  }

  Future<void> _removeFavorite(CryptocurrencySimpleModel crypto) async {
    await db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('favorites')
        .doc(crypto.id)
        .delete()
        .then((value) {
      _list.removeWhere((current) => current.id == crypto.id);
      update(_list);
      updateState();
      log('remove favorite: ${crypto.id}');
    }).catchError((error) {
      log(error);
      throw error;
    });
  }

  Future<void> _addFavorite(CryptocurrencySimpleModel crypto) async {
    if (_list.any((current) => current.id == crypto.id)) {
      return;
    }
    await db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('favorites')
        .doc(crypto.id)
        .set({
      'id': crypto.id,
    }).then((value) {
      _list.add(crypto);
      update(_list);
      updateState();
      log('add favorite: ${crypto.id}');
    }).catchError((error) {
      log(error);
      throw error;
    });
  }

  Future<void> _getFavorites() async {
    if (userStore.user != null) {
      final snapshot = await db
          .collection('users')
          .doc(userStore.user!.uid)
          .collection('favorites')
          .get();
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.forEach((doc) {
          _list.add(CryptocurrencySimpleModel.fromJson(doc.data()));
          _listIDs.add(doc.data()['id']);
        });
        update(_list);
        updateState();
      }
    } else {
      log('User null _getFavorites');
    }
  }

  bool isFavorite(CryptocurrencySimpleModel crypto) {
    return (_list.any((current) => current.id == crypto.id));
  }

  Future<void> toggleFavorite(CryptocurrencySimpleModel crypto) async {
    (_list.any((current) => current.id == crypto.id))
        ? await _removeFavorite(crypto)
        : await _addFavorite(crypto);
    await _getFavorites();
  }

  Future<void> startFavorites() async {
    await _startFavorites();
    await _getFavorites();
  }

  Future<void> removeFavorite(CryptocurrencySimpleModel crypto) async {
    await _removeFavorite(crypto);
  }

  Future<void> addFavorite(CryptocurrencySimpleModel crypto) async {
    await _addFavorite(crypto);
  }

  Future<void> saveAllFavorites(List<CryptocurrencySimpleModel> cryptos) async {
    await _saveAll(cryptos);
  }

  Future<void> updateState() async {
    final List<CryptocurrencySimpleModel> list =
        List<CryptocurrencySimpleModel>.from(_list);
    update(list);
  }

  Future<void> getCryptocurrenciesByIDs() async {
    setLoading(true);
    await startFavorites();
    marketsParams.ids = _listIDs;
    
    marketsParams.vsCurrency = 'usd';
    log('getCryptocurrenciesByIDs: ${marketsParams.ids}');
    try {
      final response = await _repository
          .getCryptocurrenciesByIDs(marketsParams)
          .then((value) {
        _list = value;
        update(_list);
        updateState();
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
      log(e.toString());
      throw e;
    }
  }
}
