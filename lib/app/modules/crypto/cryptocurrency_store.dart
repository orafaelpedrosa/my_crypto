import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/crypto/cryptocurrency_model.dart';
import 'package:mycrypto/app/modules/crypto/cryptocurrency_repository.dart';

class CryptocurrencyStore extends NotifierStore<DioError, CryptocurrencyModel> {
  CryptocurrencyStore() : super(CryptocurrencyModel());
  final CryptocurrencyRepository _repository =
      Modular.get<CryptocurrencyRepository>();

  Future<CryptocurrencyModel> getCryptocurrencyData() async {
    setLoading(true);

    return _repository.getCryptocurrencyData().then((crypto) {
      update(crypto);
      setLoading(false);
      return crypto;
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }
}
