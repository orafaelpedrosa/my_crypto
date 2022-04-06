import 'package:mycrypto/app/modules/auth/modules/register/register_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RegisterStore()),
  ];

  @override
  final List<ModularRoute> routes = [];
}
