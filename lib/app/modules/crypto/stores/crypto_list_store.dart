import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/model/cryptocurrency_model.dart';
import 'package:mycrypto/app/core/repositories/cryptocurrency_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

class CryptoListStore extends NotifierStore<DioError, List<CryptocurrencyModel>>
    with Disposable {
  final CryptocurrencyRepository _repository =
      Modular.get<CryptocurrencyRepository>();

  CryptoListStore() : super([]);

  Future<void> getListCrypto() async {
    try {
      final cryptoData = await _repository.getCryptocurrencyData();
      update(cryptoData);
    } catch (e) {
      log('StoreCrypto $e');
    }
  }

  Future<void> updateState(List<CryptocurrencyModel> data) async {
    update(data);
  }

  Future<void> searchCrypto(String search) async {
    final suggestions = state.where((crypto) {
      final cryptoName = crypto.name!.toLowerCase();
      final input = search.toLowerCase();
      return cryptoName.contains(input);
    }).toList();
    state.clear();
    update(suggestions);
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
