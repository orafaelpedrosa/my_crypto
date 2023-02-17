import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/chart_model/charts_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/chart_model/charts_params_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/cryptocurrency_details_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/markets_params_model.dart';

class CryptocurrencyRepository with Disposable {
  final Dio _dio = Dio();
  final String urlBase = dotenv.get('URL_BASE');

  Future<List<CryptocurrencySimpleModel>> getListCryptocurrenciesData(
      MarketsParamsModel paramsModel) async {
    try {
      final Response _response = await _dio.get(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=7d',
      );

      final List<CryptocurrencySimpleModel> _cryptocurrencies =
          List.empty(growable: true);
      _response.data.forEach(
        (coin) {
          _cryptocurrencies.add(CryptocurrencySimpleModel.fromJson(coin));
        },
      );
      return _cryptocurrencies;
    } catch (e) {
      log('Error getCrypto: $e');
      rethrow;
    }
  }

  Future<CryptocurrencyDetailsModel> getCryptoData(String id) async {
    try {
      final Response _response = await _dio.get(
        'https://api.coingecko.com/api/v3/coins/$id?sparkline=true',
      );
      final CryptocurrencyDetailsModel _cryptocurrencies =
          CryptocurrencyDetailsModel.fromMap(_response.data);
      return _cryptocurrencies;
    } catch (e) {
      log('Error getCrypto: $e');
      rethrow;
    }
  }

  Future<ChartModel> getChartData(ChartsParamsModel paramsModel) async {
    try {
      final Response _response = await _dio.get(
        'https://api.coingecko.com/api/v3/coins/${paramsModel.id}/market_chart',
        queryParameters: paramsModel.toJson(),
      );
      return ChartModel.fromJson(_response.data);
    } catch (e) {
      log('Error getChart: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _dio.close();
  }
}
