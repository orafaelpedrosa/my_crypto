import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/model/cryptocurrency_model.dart';

class CryptocurrencyRepository with Disposable {
  final Dio _dio = Dio();
  final String urlBase = 'https://api.nomics.com/v1/currencies/ticker';
  final String apiKey = '87f126845e26f8aa761c8f7045668c8d9b1f260c';
  final String date = '0d';
  final String? countPage = '50';

  Future<List<CryptocurrencyModel>> getCryptocurrencyData() async {
    try {
      final Response response =
          await _dio.get('$urlBase?key=$apiKey&internal=$date&per-page=$countPage');
      final List<CryptocurrencyModel> cryptos = List.empty(growable: true);
      response.data.forEach((crypto) {
        cryptos.add(CryptocurrencyModel.fromJson(crypto));
      });
      log('CryptocurrencyRepository: getCryptocurrencyData: ${cryptos.length}');
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
