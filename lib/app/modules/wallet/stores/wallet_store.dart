import 'dart:developer';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';
import 'package:mycrypto/app/modules/wallet/wallet_repository.dart';

// ignore: must_be_immutable
class WalletStore extends NotifierStore<Exception, List<MyCryptoModel>> {
  WalletStore() : super([]);

  final WalletRepository _repository = WalletRepository();
  

  Future<void> addCryptocurrency(MyCryptoModel crypto) async {
    await _repository.addCryptocurrency(crypto);
  }

  Future<void> removeCryptocurrency(MyCryptoModel crypto) async {
    await _repository.removeCryptocurrency(crypto);
  }

  Future<void> updateCryptocurrency(MyCryptoModel crypto) async {
    await _repository.updateCryptocurrency(crypto);
  }

  Future<void> getCurrentPrice() async {
    await _repository.getCurrentPrice();
  }

  Future<void> updatePrice() async {
    await _repository.updatePrice();
  }

  Future<void> getWallet() async {
    setLoading(true);
    await _repository.getAll().then((value) {
      update(value);
      log('WalletStore: getWallet: ${value.length}');
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
    });
  }

  Future<void> totalValue() async {
    setLoading(true);
    await _repository.updateTotalWallet();
    setLoading(false);
  }
}
