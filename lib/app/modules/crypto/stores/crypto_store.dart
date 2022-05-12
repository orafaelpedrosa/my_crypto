import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/model/cryptocurrency_model.dart';
import 'package:mycrypto/app/modules/crypto/stores/crypto_list_store.dart';

class CryptoStore extends NotifierStore<Exception, CryptocurrencyModel> {
  CryptoStore() : super(CryptocurrencyModel());

  final CryptoListStore cryptoListStore = Modular.get<CryptoListStore>();

  Future<void> getCryptoData() async {
    setLoading(true);
    try {
      cryptoListStore.state.forEach(
        (element) async {
          if (element.id == state.id) {
            update(element);
          }
        },
      );
    } catch (e) {
      throw e;
    }
    setLoading(false);
  }
}
