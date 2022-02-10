import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/crypto/cryptocurrency_model.dart';

class CryptocurrencyRepository with Disposable {
  final Dio dio = Dio();
  final String key = '87f126845e26f8aa761c8f7045668c8d9b1f260c';
  final String url = 'https://api.nomics.com/v1/currencies/ticker';
  final String? count = '10';

  Future<List<CryptocurrencyModel>> getCryptocurrencyData() async {
    try {
      final Response response = await dio.get('$url?key=$key&per-page=$count');

      List<dynamic> result = response.data;
      final List<CryptocurrencyModel> cryptocurrenciesList = [];

      result.forEach(
        (element) {
          cryptocurrenciesList.add(CryptocurrencyModel.fromJson(element));
        },
      );
      return cryptocurrenciesList;
    } catch (e) {
      log('getCrypto $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    dio.clear();
  }
}
