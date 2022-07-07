import 'package:mycrypto/app/modules/crypto/crypto_repository.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/authentication/auth_module.dart';
import 'package:mycrypto/app/modules/authentication/login/login_module.dart';
import 'package:mycrypto/app/modules/authentication/login/pages/login_page.dart';
import 'package:mycrypto/app/modules/authentication/register/register_module.dart';
import 'package:mycrypto/app/modules/cryptocurrency/cryptocurrency_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CryptoRepository()),
    Bind.lazySingleton((i) => LoginPage()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: AuthModule()),
    ModuleRoute('/login_module', module: LoginModule()),
    ModuleRoute('/register_module', module: RegisterModule()),
    ModuleRoute('/cryptocurrency', module: CryptocurrencyModule()),
  ];
}
