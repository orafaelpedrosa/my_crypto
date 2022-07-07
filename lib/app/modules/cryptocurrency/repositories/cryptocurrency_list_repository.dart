import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';

class CryptocurrencyRepository with Disposable {
  final Dio _dio = Dio();
  final String urlBase = 'https://api.coingecko.com/api/v3/coins/markets';
  final String vsCurrency = 'usd';
  final String ids = 'bitcoin';
  final String order = 'market_cap_desc';
  final String perPage = '250';
  final String page = '1';
  final String sparkline = 'true';
  final String priceChangePercentage = '1y';

  Future<List<CryptocurrencySimpleModel>> getCryptocurrencyData() async {
    try {
      final Response response = await _dio.get(
          '$urlBase?vs_currency=$vsCurrency&$order&per_page=$perPage&page=$page&sparkline=$sparkline');
      final List<CryptocurrencySimpleModel> cryptos =
          List.empty(growable: true);
      response.data.forEach(
        (crypto) {
          cryptos.add(CryptocurrencySimpleModel.fromJson(crypto));
        },
      );
      log('CryptocurrencyRepository');
      return cryptos;
    } catch (e) {
      log('Error getCrypto: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
