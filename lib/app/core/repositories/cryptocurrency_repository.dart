import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/model/cryptocurrency_model.dart';

class CryptocurrencyRepository with Disposable {
  final Dio _dio = Dio();
  final String urlBase = dotenv.get('URL_BASE');
  final String apiKey = dotenv.get('API_KEY');

  Future<List<CryptocurrencyModel>> getCryptocurrencyData() async {
    try {
      final Response response = await _dio.get('$urlBase?key=$apiKey');
      final List<CryptocurrencyModel> cryptos = List.empty(growable: true);
      response.data.forEach((crypto) {
        cryptos.add(CryptocurrencyModel.fromJson(crypto));
      });
      return cryptos;
    } catch (e) {
      log('Error getCrypto: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _dio.clear();
  }
}
