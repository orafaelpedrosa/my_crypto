import 'package:mycrypto/app/app_widget.dart';
import 'package:mycrypto/app/core/repositories/cryptocurrency_repository.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/auth/auth_module.dart';
import 'package:mycrypto/app/modules/auth/stores/auth_check_store.dart';
import 'package:mycrypto/app/modules/crypto/stores/cryptocurrency_store.dart';

import 'modules/crypto/crypto_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CryptocurrencyRepository()),
    Bind.lazySingleton((i) => CryptocurrencyStore()),
    Bind.lazySingleton((i) => AuthCheckStore()),
    Bind.lazySingleton((i) => MyNavigatorObserver()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: AuthModule()),
    ModuleRoute('/crypto_module', module: CryptoModule()),
  ];
}
