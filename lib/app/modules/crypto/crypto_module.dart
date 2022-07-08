import 'package:mycrypto/app/modules/crypto/stores/crypto_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/crypto/crypto_repository.dart';
import 'package:mycrypto/app/modules/crypto/pages/crypto_details.dart';
import 'package:mycrypto/app/modules/crypto/pages/crypto_page.dart';
import 'package:mycrypto/app/modules/crypto/stores/crypto_list_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/list_cryptocurrencies_store.dart';

class CryptoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CryptoStore()),
    Bind.lazySingleton((i) => CryptoListStore()),
    Bind.lazySingleton((i) => CryptoRepository()),
    Bind.lazySingleton((i) => ListCryptocurrenciesStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => CryptoPage()),
    ChildRoute('/crypto_details',
        child: (_, args) => CryptoDetailsPage(cryptoModel: args.data)),
  ];
}
