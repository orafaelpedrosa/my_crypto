import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/authentication/auth_module.dart';
import 'package:mycrypto/app/modules/authentication/login/login_module.dart';
import 'package:mycrypto/app/modules/authentication/login/pages/login_page.dart';
import 'package:mycrypto/app/modules/authentication/register/register_module.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/cryptocurrency_module.dart';
import 'package:mycrypto/app/modules/home/home_module.dart';
import 'package:mycrypto/app/modules/profile/profile_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginPage()),
    Bind.lazySingleton((i) => UserStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: AuthModule()),
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/login_module', module: LoginModule()),
    ModuleRoute('/register_module', module: RegisterModule()),
    ModuleRoute('/cryptocurrency', module: CryptocurrencyModule()),
    ModuleRoute('/profile', module: ProfileModule()),
  ];
}
