import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/markets_params_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/repositories/cryptocurrency_repository.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/cryptocurrency_data_store.dart';

// ignore: must_be_immutable
class ListCryptocurrenciesStore
    extends NotifierStore<DioError, List<CryptocurrencySimpleModel>> {
  ListCryptocurrenciesStore() : super([]);
  final CryptocurrencyRepository _repository =
      Modular.get<CryptocurrencyRepository>();
  final CryptocurrencyDataStore dataStore =
      Modular.get<CryptocurrencyDataStore>();
  List<CryptocurrencySimpleModel> listCrypto = [];
  final MarketsParamsModel marketsParams = MarketsParamsModel();

  Future<void> getListCryptocurrencies() async {
    setLoading(true);
    await _repository.getListCryptocurrenciesData(marketsParams).then((value) {
      update(value);
      setLoading(false);
    }).catchError((onError) async {
      setLoading(false);
      log(onError.toString());
      setError(onError);
    });
  }

  Future<void> getListCryptoStream() async {
    await _repository.getListCryptocurrenciesData(marketsParams).then((value) {
      listCrypto = value;
      update(value);
    }).catchError((onError) {
      log(onError.toString());
      setError(onError);
    });
  }

  String getFormatImage(String? url) {
    if (url == null) {
      return 'null';
    } else {
      int ponto = url.lastIndexOf('.');
      String imageFormat = url.substring(ponto + 1, url.length);
      return imageFormat;
    }
  }

  Future<void> updateState(List<CryptocurrencySimpleModel> data) async {
    update(data);
  }

  Future<void> setMarketParamsOrder(String order) async {
    if (marketsParams.order == order) {
      if (marketsParams.order == 'market_cap_desc') {
        marketsParams.order = 'market_cap_asc';
      } else if (marketsParams.order == 'market_cap_asc') {
        marketsParams.order = 'market_cap_desc';
      } else if (marketsParams.order == 'volume_desc') {
        marketsParams.order = 'volume_asc';
      } else if (marketsParams.order == 'volume_asc') {
        marketsParams.order = 'volume_desc';
      }
    } else {
      marketsParams.order = order;
    }
    await getListCryptocurrencies();
  }

  num getPriceChangePercentage(CryptocurrencySimpleModel coin) {
    if (coin.priceChangePercentage1hInCurrency != null) {
      return coin.priceChangePercentage1hInCurrency!;
    } else if (coin.priceChangePercentage24hInCurrency != null) {
      return coin.priceChangePercentage24hInCurrency!;
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
      return 0;
    }
  }
}
