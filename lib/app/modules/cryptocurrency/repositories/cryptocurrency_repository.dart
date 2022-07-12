import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';

class CryptocurrencyRepository with Disposable {
  final Dio _dio = Dio();
  // final String urlBase = 'https://api.coingecko.com/api/v3/coins/markets';
  final String urlBase = dotenv.get('URL_BASE');
  final String vsCurrency = 'usd';
  final String ids = 'bitcoin';
  final String order = 'market_cap_desc';
  final String perPage = '2';
  final String page = '1';
  final String sparkline = 'true';
  final String priceChangePercentage = '';

  Future<List<CryptocurrencySimpleModel>> getListCryptocurrenciesData() async {
    try {
      // final Response response = await _dio.get(
      //     '$urlBase/markets?vs_currency=$vsCurrency&$order&per_page=$perPage&page=$page&sparkline=$sparkline&price_change_percentage=$priceChangePercentage');

      final Response response = await _dio.get(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true');

      final List<CryptocurrencySimpleModel> cryptos =
          List.empty(growable: true);
      response.data.forEach(
        (crypto) {
          cryptos.add(CryptocurrencySimpleModel.fromJson(crypto));
        },
      );
      return cryptos;
    } catch (e) {
      log('Error getCrypto: $e');
      rethrow;
    }
  }

  Future<void> getCryptoData(String id) async {
    try {
      final Response response = await _dio.get('$urlBase/$id');
      log(response.data.toString());
    } catch (e) {
      log('Error getCrypto: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
