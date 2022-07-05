import 'package:mycrypto/app/modules/crypto/stores/crypto_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/repositories/cryptocurrency_repository.dart';
import 'package:mycrypto/app/modules/crypto/pages/crypto_details.dart';
import 'package:mycrypto/app/modules/crypto/pages/crypto_page.dart';
import 'package:mycrypto/app/modules/crypto/stores/crypto_list_store.dart';

class CryptoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CryptoStore()),
    Bind.lazySingleton((i) => CryptoListStore()),
    Bind.lazySingleton((i) => CryptocurrencyRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => CryptoPage()),
    ChildRoute('/crypto_details',
        child: (_, args) => CryptoDetailsPage(cryptoModel: args.data)),
  ];
}
