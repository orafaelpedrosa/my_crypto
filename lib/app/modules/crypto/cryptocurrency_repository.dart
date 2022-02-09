import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/crypto/cryptocurrency_model.dart';

class CryptocurrencyRepository with Disposable {
  final Dio _client;
  final String key = '87f126845e26f8aa761c8f7045668c8d9b1f260c';
  final String url = 'https://api.nomics.com/v1/currencies/ticker';
  final String? count = '10';

  CryptocurrencyRepository(this._client);

  Future<CryptocurrencyModel> getCryptocurrencyData(
      ) async {
    try {
      final Response response = await _client.get('$url?key=$key&per-page=$count');
      return CryptocurrencyModel.fromJson(response.data);
    } catch (e) {
      log('getCrypto $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _client.clear();
  }
}
