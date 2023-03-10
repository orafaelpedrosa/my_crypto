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
  String order = 'market_cap_desc';

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

  Future<void> orderList(String order) async {
    setLoading(true);
    final List<CryptocurrencySimpleModel> _list = state;
    switch (order) {
      case 'market_cap_desc':
        _list.sort((a, b) => b.marketCap!.compareTo(a.marketCap!));
        break;
      case 'market_cap_asc':
        _list.sort((a, b) => a.marketCap!.compareTo(b.marketCap!));
        break;
      case 'volume_desc':
        _list.sort((a, b) => b.totalVolume!.compareTo(a.totalVolume!));
        break;
      case 'volume_asc':
        _list.sort((a, b) => a.totalVolume!.compareTo(b.totalVolume!));
        break;
      case 'percent_change_desc':
        _list.sort((a, b) =>
            b.priceChangePercentage24h!.compareTo(a.priceChangePercentage24h!));
        break;
      case 'percent_change_asc':
        _list.sort((a, b) =>
            a.priceChangePercentage24h!.compareTo(b.priceChangePercentage24h!));
        break;
      default:
    }
    update(_list);
    setLoading(false);
  }

  Future<void> updateState(List<CryptocurrencySimpleModel> data) async {
    update(data);
  }
}
