import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/cryptocurrency_details_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/repositories/cryptocurrency_repository.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/chart_store.dart';
import 'package:mycrypto/app/shared/utils/utils.dart';

class CryptocurrencyDataStore
    extends NotifierStore<DioError, CryptocurrencyDetailsModel> {
  CryptocurrencyDataStore() : super(CryptocurrencyDetailsModel());
  final CryptocurrencyRepository _repository =
      Modular.get<CryptocurrencyRepository>();
  final ChartStore chartStore = Modular.get();

  Future<void> getCryptocurrencyById(String id) async {
    setLoading(true);
    await _repository.getCryptoData(id).then((value) async {
      value.description!.en = Utils.parseHtmlString(value.description!.en!);
      update(value);
      await priceChangePercente(0);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      log(onError.toString());
      setError(onError);
    });
  }

  Future<void> getStreamCryptocurrency(String id, int index) async {
    await _repository.getCryptoData(id).then((value) async {
      value.description!.en = Utils.parseHtmlString(value.description!.en!);
      value.priceChangePercente = changePricePercente(index);
      update(value);
    }).catchError((onError) {
      log(onError.toString());
      setError(onError);
    });
  }

  double changePricePercente(int period) {
    switch (period) {
      case 0:
        return state.marketData!.priceChangePercentage24h!.toDouble();
      case 1:
        return state.marketData!.priceChangePercentage7d!.toDouble();
      case 2:
        return state.marketData!.priceChangePercentage30d!.toDouble();
      case 3:
        return state.marketData!.priceChangePercentage1y!.toDouble();
      default:
        return 0.0;
    }
  }

  Future<void> priceChangePercente(int period) async {
    switch (period) {
      case 0:
        state.priceChangePercente = 
            state.marketData?.priceChangePercentage24h!.toDouble() ?? 0.0;
        break;
      case 1:
        state.priceChangePercente =
            state.marketData?.priceChangePercentage7d!.toDouble() ?? 0.0;
        break;
      case 2:
        state.priceChangePercente =
            state.marketData?.priceChangePercentage30d!.toDouble() ?? 0.0;
        break;
      case 3:
        state.priceChangePercente =
            state.marketData?.priceChangePercentage1y!.toDouble() ?? 0.0;
        break;
      default:
        state.priceChangePercente =
            state.marketData?.priceChangePercentage24h!.toDouble() ?? 0.0;
        break;
    }
    updateState(state);
  }

  Future<void> updateState(CryptocurrencyDetailsModel data) async {
    update(data);
  }
}
