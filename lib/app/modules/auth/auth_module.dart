import 'package:mycrypto/app/modules/auth/auth_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/auth/auth_login_page.dart';
import 'package:mycrypto/app/modules/auth/modules/login/login_module.dart';
import 'package:mycrypto/app/modules/auth/modules/register/register_module.dart';
import 'package:mycrypto/app/modules/auth/stores/auth_check_store.dart';
import 'package:mycrypto/app/modules/crypto/crypto_module.dart';

class AuthModule extends Module {
  List<Module> get imports => [
        CryptoModule(),
      ];
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AuthRepository()),
    Bind.lazySingleton((i) => AuthCheckStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => AuthLoginPage()),
    ModuleRoute('/crypto', module: CryptoModule()),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/register', module: RegisterModule()),
  ];
}
