import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/repositories/cryptocurrency_repository.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/cryptocurrency_data_store.dart';

class ListCryptocurrenciesStore
    extends NotifierStore<DioError, List<CryptocurrencySimpleModel>> {
  ListCryptocurrenciesStore() : super([]);
  final CryptocurrencyRepository _repository =
      Modular.get<CryptocurrencyRepository>();
  final CryptocurrencyDataStore dataStore =
      Modular.get<CryptocurrencyDataStore>();
  List<CryptocurrencySimpleModel> listCrypto = [];
  bool search = false;

  Future<void> getListCryptocurrencies() async {
    await _repository.getListCryptocurrenciesData().then((value) {
      listCrypto = value;
      update(value);
    }).catchError((onError) {
      log(onError.toString());
      setError(onError);
    });
  }


  String getFormatImage(String? url) {
    if (url == null) {
      return 'null';
    } else {
      int ponto = url.lastIndexOf('.');
      String imageFormat = url.substring(ponto + 1, url.length);
      return imageFormat;
    }
  }

  Future<void> searchCrypto(String find) async {
    final suggestions = state.where((crypto) {
      final cryptoName = crypto.name!.toLowerCase();
      final input = find.toLowerCase();
      return cryptoName.contains(input);
    }).toList();
    if (suggestions.isNotEmpty) {
      await updateState(suggestions);
    }
  }

  Future<void> updateState(List<CryptocurrencySimpleModel> data) async {
    update(data);
  }
}
