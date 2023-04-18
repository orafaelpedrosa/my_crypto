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
  final String _urlBase = dotenv.get('URL_BASE');

  Future<List<CryptocurrencySimpleModel>> getListCryptocurrenciesData(
      MarketsParamsModel paramsModel) async {
    try {
      final Response _response = await _dio.get(
        '$_urlBase/coins/markets',
        queryParameters: paramsModel.toJson(),
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
      log('Error getList: $e');
      rethrow;
    }
  }

  Future<CryptocurrencyDetailsModel> getCryptoData(String id) async {
    try {
      final Response _response = await _dio.get(
        '$_urlBase/coins/$id?sparkline=true',
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
        '$_urlBase/coins/${paramsModel.id}/market_chart',
        queryParameters: paramsModel.toJson(),
      );
      return ChartModel.fromJson(_response.data);
    } catch (e) {
      log('Error getChart: $e');
      rethrow;
    }
  }

  Future<String> getStatus() async {
    try {
      final Response _response = await _dio.get(
        'https://status.coingecko.com/',
      );
      return _response.data;
    } catch (e) {
      log('Error getStatus: $e');
      rethrow;
    }
  }

  void dispose() {
    _dio.close();
  }
}
