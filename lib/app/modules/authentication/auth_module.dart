import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/authentication/auth_check_page.dart';
import 'package:mycrypto/app/modules/authentication/login/login_module.dart';
import 'package:mycrypto/app/modules/authentication/login/login_repository.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/obscure_store.dart';
import 'package:mycrypto/app/modules/authentication/register/register_module.dart';
import 'package:mycrypto/app/modules/authentication/register/register_repository.dart';
import 'package:mycrypto/app/modules/crypto/crypto_module.dart';
import 'package:mycrypto/app/modules/crypto/stores/crypto_store.dart';

class AuthModule extends Module {
  List<Module> get imports => [
        CryptoModule(),
      ];
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginRepository()),
    Bind.lazySingleton((i) => RegisterRepository()),
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => ObscureStore()),
    Bind.lazySingleton((i) => CryptoStore()),
    Bind.lazySingleton((i) => RegisterModule()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => AuthCheckPage()),
    ModuleRoute('/crypto', module: CryptoModule()),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/register', module: RegisterModule()),
  ];
}
