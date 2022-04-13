import 'package:mycrypto/app/modules/auth/auth_repository.dart';
import 'package:mycrypto/app/modules/auth/modules/login/login_page.dart';
import 'package:mycrypto/app/modules/auth/modules/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => AuthRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const LoginPage()),
  ];
}
