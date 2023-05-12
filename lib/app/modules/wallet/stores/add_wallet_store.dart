import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';

class AddWalletStore extends Store<MyCryptoModel> {
  AddWalletStore() : super(MyCryptoModel());

  String fiat = 'BRL';
  final UserStore userStore = Modular.get();

  Future<void> updateState() async {
    update(state, force: true);
  }
}
