import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/price_simple_model.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';
import 'package:mycrypto/app/modules/wallet/wallet_repository.dart';

// ignore: must_be_immutable
class WalletStore extends Store<List<MyCryptoModel>> {
  WalletStore() : super([]);

  final WalletRepository _repository = WalletRepository();
  MyCryptoModel crypto = MyCryptoModel();
  PriceSimpleModel price = PriceSimpleModel();
  String fiat = 'BRL';

  Future<void> updateState() async {
    update(state, force: true);
  }

  Future<void> addCryptocurrency(MyCryptoModel crypto) async {
    await _repository.addCryptocurrency(crypto);
  }

  Future<void> removeCryptocurrency(MyCryptoModel crypto) async {
    await _repository.removeCryptocurrency(crypto);
  }

  Future<void> updateCryptocurrency(MyCryptoModel crypto) async {
    await _repository.updateCryptocurrency(crypto);
  }

  Future<void> updatePrice() async {
    setLoading(true);
    await _repository.updatePrice().then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
    });
  }

  Future<void> getWallet() async {
    setLoading(true);
    await _repository.getAll().then((value) {
      update(value);
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
    });
  }

  Future<void> totalValue() async {
    setLoading(true);
    await _repository.updateTotalWallet().then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
    });
    setLoading(false);
  }

  Future<void> searchCoin(String value) async {
    setLoading(true);
    await _repository.getSearchCoin(value).then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
    });
  }

  Future<void> getSimplePriceID(String id) async {
    setLoading(true);
    await _repository.getSimplePriceID(id).then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }
}
