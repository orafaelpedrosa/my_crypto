import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/crypto/cryptocurrency_model.dart';
import 'package:mycrypto/app/modules/crypto/cryptocurrency_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

class CryptocurrencyStore extends NotifierStore<DioError, CryptocurrencyModel>
    with Disposable {
  final CryptocurrencyRepository _repository =
      Modular.get<CryptocurrencyRepository>();

  CryptocurrencyStore(CryptocurrencyModel initialState) : super(initialState);

  Future<void> getCrypto() async {
    setLoading(true);
    try {
      final cryptoData = await _repository.getCryptocurrencyData();
    } catch (e) {
      log('StoreCrypto $e');
    }
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
