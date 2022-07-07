import 'package:mycrypto/app/modules/crypto/crypto_repository.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/authentication/auth_module.dart';
import 'package:mycrypto/app/modules/authentication/modules/login/login_module.dart';
import 'package:mycrypto/app/modules/authentication/modules/login/pages/login_page.dart';
import 'package:mycrypto/app/modules/authentication/modules/register/register_module.dart';
import 'package:mycrypto/app/modules/crypto/stores/crypto_list_store.dart';

import 'modules/crypto/crypto_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CryptoRepository()),
    Bind.lazySingleton((i) => CryptoListStore()),
    Bind.lazySingleton((i) => LoginPage()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: AuthModule()),
    ModuleRoute('/crypto_module', module: CryptoModule()),
    ModuleRoute('/login_module', module: LoginModule()),
    ModuleRoute('/register_module', module: RegisterModule()),
  ];
}
