import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/repositories/cryptocurrency_repository.dart';
import 'package:mycrypto/app/modules/crypto/crypto_page.dart';
import 'package:mycrypto/app/modules/crypto/stores/cryptocurrency_store.dart';

class CryptoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CryptocurrencyStore()),
    Bind.lazySingleton((i) => CryptocurrencyRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => CryptoPage(),
    ),
  ];
}