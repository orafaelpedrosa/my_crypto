import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/repositories/cryptocurrency_list_repository.dart';

class CryptocurrencyStore
    extends NotifierStore<DioError, List<CryptocurrencySimpleModel>> {
  CryptocurrencyStore() : super([]);
  final CryptocurrencyRepository _repository = CryptocurrencyRepository();
  List<CryptocurrencySimpleModel> listCrypto = [];

  Future<void> getCryptocurrencyData() async {
    await _repository.getCryptocurrencyData().then((value) {
      listCrypto = value;
      update(value);
    }).catchError((onError) {
      setError(onError);
    });
  }
}
