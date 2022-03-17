import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/crypto/cryptocurrency_model.dart';

class CryptocurrencyRepository with Disposable {
  final Dio _dio = Dio();
  final String urlBase = 'https://api.nomics.com/v1/currencies/ticker';
  final String apiKey = '87f126845e26f8aa761c8f7045668c8d9b1f260c';
  final String date = '0d';
  final String? countPage = '100';


  Future<List<CryptocurrencyModel>> getCryptocurrencyData() async {
    try {
      final Response response = await _dio
          .get('$urlBase?key=$apiKey&internal=$date&per-page=$countPage');
      final List<Map<String, dynamic>> result = jsonDecode(response.data);
      return result
          .map<CryptocurrencyModel>((resp) => CryptocurrencyModel.fromMap(resp))
          .toList();
    } catch (e) {
            log('getCrypto $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _dio.clear();
  }
}
