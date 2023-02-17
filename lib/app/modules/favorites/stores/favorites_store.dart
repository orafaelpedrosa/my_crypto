import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/markets_params_model.dart';
import 'package:mycrypto/app/modules/favorites/favorites_repository.dart';

class FavoritesStore
    extends NotifierStore<Exception, List<CryptocurrencySimpleModel>> {
  FavoritesStore() : super([]);

  List<CryptocurrencySimpleModel> _list =
      List<CryptocurrencySimpleModel>.empty(growable: true);
  List<String> listIDs = List<String>.empty(growable: true);
  final MarketsParamsModel marketsParams = MarketsParamsModel();
  final FavoritesRepository _repository = Modular.get<FavoritesRepository>();

  Future<void> addOrRemoveFavorite(CryptocurrencySimpleModel crypto) async {
    if (_list.any((current) => current.id == crypto.id)) {
      _list = await _repository.removeFavorite(crypto);
    } else {
      _list = await _repository.addFavorite(crypto);
    }
    update(_list);
  }

  bool isFavorite(CryptocurrencySimpleModel crypto) {
    return (_list.any((current) => current.id == crypto.id));
  }

  Future<void> toggleFavorite(CryptocurrencySimpleModel crypto) async {
    setLoading(true);
    (_list.any((current) => current.id == crypto.id))
        ? await _repository.removeFavorite(crypto)
        : await _repository.addFavorite(crypto);
    _list = await _repository.getFavorites();
    update(_list);
    setLoading(false);
  }

  Future<void> startFavorites() async {
    await _repository.startFavorites();
    _list = await _repository.getFavorites();
    update(_list);
  }

  Future<void> removeFavorite(CryptocurrencySimpleModel crypto) async {
    _list = await _repository.removeFavorite(crypto);
    update(_list);
  }

  Future<void> addFavorite(CryptocurrencySimpleModel crypto) async {
    _list = await _repository.addFavorite(crypto);
    update(_list);
  }

  Future<void> saveAllFavorites(List<CryptocurrencySimpleModel> cryptos) async {
    _list = await _repository.saveAll(cryptos);
    update(_list);
  }

  Future<void> updateState() async {
    final List<CryptocurrencySimpleModel> list =
        List<CryptocurrencySimpleModel>.from(_list);
    update(list);
  }

  Future<void> getCryptocurrenciesByIDs() async {
    setLoading(true);
    await startFavorites();
    listIDs = await _repository.getFavoritesIDs();

    if (listIDs.isNotEmpty) {
      marketsParams.ids = listIDs;
      marketsParams.vsCurrency = 'usd';
      await _repository.getCryptocurrenciesByIDs(marketsParams).then((value) {
        update(value);
        setLoading(false);
      }).catchError(
        (onError) {
          setLoading(false);
          log(onError.toString());
          setError(onError);
        },
      );
    } else {
      setLoading(false);
    }
  }
}
