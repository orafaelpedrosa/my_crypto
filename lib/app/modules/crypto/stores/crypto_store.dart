import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/model/cryptocurrency_model.dart';
import 'package:mycrypto/app/modules/crypto/stores/crypto_list_store.dart';

class CryptoStore extends NotifierStore<Exception, CryptocurrencyModel> {
  CryptoStore() : super(CryptocurrencyModel());

  final CryptoListStore cryptoListStore = Modular.get<CryptoListStore>();

  Future<void> getCryptoData() async {
    try {
      log('${state.id}');
      cryptoListStore.state.forEach(
        (element) async {
          if (element.id == state.id) {
            state.id = element.id;
            update(element);
            updateState();
            await Future.delayed(Duration(seconds: 1));
          }
        },
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateState() async {
    // update(CryptocurrencyModel.fromJson(state.toJson()));
    update(
      state,
      force: true,
    );
  }
}
