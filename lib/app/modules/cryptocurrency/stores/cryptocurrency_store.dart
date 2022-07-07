import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/repositories/cryptocurrency_list_repository.dart';

class CryptocurrencyStore
    extends NotifierStore<DioError, List<CryptocurrencySimpleModel>> {
  CryptocurrencyStore() : super([]);
  final CryptocurrencyRepository _repository = CryptocurrencyRepository();
  List<CryptocurrencySimpleModel> listCrypto = [];
  bool search = false;

  Future<void> getCryptocurrencyData() async {
    await _repository.getCryptocurrencyData().then((value) {
      listCrypto = value;
      update(value);
    }).catchError((onError) {
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
    updateState(suggestions);
  }

  Future<void> updateState(List<CryptocurrencySimpleModel> data) async {
    update(data);
  }
}
