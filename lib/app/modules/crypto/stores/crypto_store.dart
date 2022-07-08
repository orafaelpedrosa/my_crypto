import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/crypto/models/cryptocurrency_model.dart';
import 'package:mycrypto/app/modules/crypto/stores/crypto_list_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/list_cryptocurrencies_store.dart';

class CryptoStore extends NotifierStore<Exception, CryptocurrencyModel> {
  CryptoStore() : super(CryptocurrencyModel());

  final CryptoListStore cryptoListStore = Modular.get<CryptoListStore>();
  final ListCryptocurrenciesStore cryptocurrencyStore =
      Modular.get<ListCryptocurrenciesStore>();

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
      setLoading(false);
      throw e;
    }
    setLoading(false);
  }
}
