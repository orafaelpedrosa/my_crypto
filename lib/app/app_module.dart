import 'package:mycrypto/app/core/repositories/cryptocurrency_repository.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/auth/auth_module.dart';
import 'package:mycrypto/app/modules/auth/modules/login/login_module.dart';
import 'package:mycrypto/app/modules/auth/modules/login/pages/login_page.dart';
import 'package:mycrypto/app/modules/crypto/stores/crypto_list_store.dart';

import 'modules/crypto/crypto_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CryptocurrencyRepository()),
    Bind.lazySingleton((i) => CryptoListStore()),
    Bind.lazySingleton((i) => LoginPage()),
    // Bind.lazySingleton((i) => MyNavigatorObserver()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: AuthModule()),
    ModuleRoute('/crypto_module', module: CryptoModule()),
    ModuleRoute('/login_module', module: LoginModule()),
  ];
}
