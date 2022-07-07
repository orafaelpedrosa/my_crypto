import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/crypto/models/cryptocurrency_model.dart';

class CryptoRepository with Disposable {
  final Dio _dio = Dio();
  final String urlBase = dotenv.get('URL_BASE');
  final String apiKey = dotenv.get('API_KEY');
  final String convert = 'USD';
  final String perPage = '100';

  Future<List<CryptocurrencyModel>> getCryptocurrencyData() async {
    try {
      final Response response = await _dio
          .get('$urlBase?key=$apiKey&convert=$convert&per-page=$perPage');
      final List<CryptocurrencyModel> cryptos = List.empty(growable: true);
      response.data.forEach(
        (crypto) {
          cryptos.add(CryptocurrencyModel.fromJson(crypto));
        },
      );
      return cryptos;
    } catch (e) {
      log('Error getCrypto: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}