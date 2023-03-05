import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/services/firestore_repository.dart';
import 'package:mycrypto/app/core/user_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/markets_params_model.dart';

class FavoritesRepository extends Disposable {
  final Dio _dio = Dio();
  late FirebaseFirestore db;
  UserStore userStore = Modular.get();
  List<CryptocurrencySimpleModel> _list =
      List<CryptocurrencySimpleModel>.empty(growable: true);
  List<String> _listIDs = List<String>.empty(growable: true);

  Future<List<CryptocurrencySimpleModel>> getCryptocurrenciesByIDs(
      MarketsParamsModel marketsParamsModel) async {
    try {
      final Response response = await _dio.get(
        'https://api.coingecko.com/api/v3/coins/markets',
        queryParameters: {
          'vs_currency': marketsParamsModel.vsCurrency,
          'ids': marketsParamsModel.ids!.join(','),
        },
      );
      final List<CryptocurrencySimpleModel> cryptos =
          List.empty(growable: true);
      response.data.forEach(
        (coin) {
          cryptos.add(CryptocurrencySimpleModel.fromJson(coin));
        },
      );
      return cryptos;
    } catch (e) {
      log('Error getCrypto: $e');
      rethrow;
    }
  }

  startFavorites() async {
    await userStore.getUser();
    _startFirestore();
  }

  _startFirestore() async {
    db = FirestoreRepository.get();
  }

  Future<List<CryptocurrencySimpleModel>> saveAll(
      List<CryptocurrencySimpleModel> cryptos) async {
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
            })
            .then((value) {})
            .catchError(
              (error) {
                log(error);
                throw error;
              },
            );
      }
    });
    return _list;
  }

  Future<List<CryptocurrencySimpleModel>> removeFavorite(
      CryptocurrencySimpleModel crypto) async {
    await db
        .collection('users')
        .doc(userStore.user!.uid)
        .collection('favorites')
        .doc(crypto.id)
        .delete()
        .then((value) {
      _list.removeWhere((current) => current.id == crypto.id);
      log('remove favorite: ${crypto.id}');
    }).catchError((error) {
      log(error);
      throw error;
    });
    return _list;
  }

  Future<List<CryptocurrencySimpleModel>> addFavorite(
      CryptocurrencySimpleModel crypto) async {
    if (_list.any((current) => current.id == crypto.id)) {
      return _list;
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
      log('add favorite: ${crypto.id}');
    }).catchError((error) {
      log(error);
      throw error;
    });
    return _list;
  }

  Future<List<CryptocurrencySimpleModel>> getFavorites() async {
    if (userStore.stateUser()) {
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
        return _list;
      }
    } else {
      log('User null _getFavorites');
      return [];
    }
    return [];
  }

  Future<List<String>> getFavoritesIDs() async {
    final List<String> _listIDsFavorites = List<String>.empty(growable: true);

    if (userStore.stateUser()) {
      final snapshot = await db
          .collection('users')
          .doc(userStore.user!.uid)
          .collection('favorites')
          .get();
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.forEach((doc) {
          _listIDsFavorites.add(doc.data()['id']);
        });
        return _listIDsFavorites;
      }
    } else {
      log('User null _getFavorites');
      return [];
    }
    return [];
  }

  @override
  void dispose() {
    _dio.close();
  }
}
