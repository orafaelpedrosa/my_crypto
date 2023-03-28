import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/markets_params_model.dart';
import 'package:mycrypto/app/modules/favorites/favorites_repository.dart';

// ignore: must_be_immutable
class FavoritesStore extends Store<List<CryptocurrencySimpleModel>> {
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

  Future<void> updateStateLoading() async {
    setLoading(true);
    final List<CryptocurrencySimpleModel> list =
        List<CryptocurrencySimpleModel>.from(_list);
    update(list);
    setLoading(false);
  }

  Future<void> removeFavoriteByID(CryptocurrencySimpleModel coin) async {
    setLoading(true);
    await removeFavorite(coin);
    await getCryptocurrenciesByIDs();
    setLoading(false);
  }

  Future<void> getCryptocurrenciesByIDs() async {
    setLoading(true);
    await startFavorites();
    listIDs = await _repository.getFavoritesIDs();

    if (listIDs.isNotEmpty) {
      marketsParams.ids = listIDs;
      marketsParams.vsCurrency = 'usd';
      marketsParams.order = 'market_cap_desc';
      marketsParams.perPage = 100;
      marketsParams.page = 1;
      marketsParams.sparkline = 'true';
      marketsParams.priceChangePercentage = '1h,24h,7d,14d,30d,200d,1y';
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

  num getPriceChangePercentage(CryptocurrencySimpleModel coin) {
    if (coin.priceChangePercentage24hInCurrency != null) {
      return coin.priceChangePercentage24hInCurrency!;
    } else if (coin.priceChangePercentage1hInCurrency != null) {
      return coin.priceChangePercentage1hInCurrency!;
    } else if (coin.priceChangePercentage7dInCurrency != null) {
      return coin.priceChangePercentage7dInCurrency!;
    } else if (coin.priceChangePercentage14dInCurrency != null) {
      return coin.priceChangePercentage14dInCurrency!;
    } else if (coin.priceChangePercentage30dInCurrency != null) {
      return coin.priceChangePercentage30dInCurrency!;
    } else if (coin.priceChangePercentage200dInCurrency != null) {
      return coin.priceChangePercentage200dInCurrency!;
    } else if (coin.priceChangePercentage1yInCurrency != null) {
      return coin.priceChangePercentage1yInCurrency!;
    } else {
      return coin.priceChangePercentage24hInCurrency!;
    }
  }
}
