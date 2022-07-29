import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/cryptocurrency_details_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/repositories/cryptocurrency_repository.dart';
import 'package:mycrypto/app/shared/utils/utils.dart';

class CryptocurrencyDataStore
    extends NotifierStore<DioError, CryptocurrencyDetailsModel> {
  CryptocurrencyDataStore() : super(CryptocurrencyDetailsModel());
  final CryptocurrencyRepository _repository =
      Modular.get<CryptocurrencyRepository>();
  String htmlString = '<a href="https://www.google.com">Google</a>';
  Utils utils = Utils();

  Future<void> getCryptocurrencyById(String id) async {
    setLoading(true);
    await _repository.getCryptoData(id).then((value) {
      value.description!.en = utils.parseHtmlString(value.description!.en!);
      update(value);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      log(onError.toString());
      setError(onError);
    });
  }

  Future<void> getStreamCryptocurrency(String id) async {
    await _repository.getCryptoData(id).then((value) {
      value.description!.en = utils.parseHtmlString(value.description!.en!);
      update(value);
    }).catchError((onError) {
      log(onError.toString());
      setError(onError);
    });
  }

  Future<void> updateState(CryptocurrencyDetailsModel data) async {
    update(data);
  }
}
