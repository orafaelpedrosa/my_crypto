import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/model/cryptocurrency_model.dart';
import 'package:mycrypto/app/core/repositories/cryptocurrency_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

class CryptoListStore extends NotifierStore<DioError, List<CryptocurrencyModel>>
    with Disposable {
  final CryptocurrencyRepository _repository =
      Modular.get<CryptocurrencyRepository>();
  bool search = false;
  List<CryptocurrencyModel> listCrypto = [];

  CryptoListStore() : super([]);

  Future<void> getListCrypto() async {
    await _repository.getCryptocurrencyData().then((value) {
      listCrypto = value;
      update(value);
    }).catchError((onError) {
      setError(onError);
    });
  }

  Future<void> updateState(List<CryptocurrencyModel> data) async {
    update(data);
  }

  Future<void> searchCrypto(String find) async {
    final suggestions = state.where((crypto) {
      final cryptoName = crypto.name!.toLowerCase();
      final input = find.toLowerCase();
      return cryptoName.contains(input);
    }).toList();
    updateState(suggestions);
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
