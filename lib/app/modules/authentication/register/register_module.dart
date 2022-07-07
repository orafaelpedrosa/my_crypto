import 'package:mycrypto/app/modules/authentication/register/pages/register_page.dart';
import 'package:mycrypto/app/modules/authentication/register/register_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/authentication/register/stores/register_store.dart';

class RegisterModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RegisterStore()),
    Bind.lazySingleton((i) => RegisterRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const RegisterPage()),
  ];
}
