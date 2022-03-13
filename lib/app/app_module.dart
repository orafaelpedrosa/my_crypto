import 'package:mycrypto/app/modules/crypto/cryptocurrency_repository.dart';
import 'package:dio/dio.dart';


import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/crypto/cryptocurrency_store.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CryptocurrencyRepository(i.get<Dio>())),
    Bind.lazySingleton((i) => CryptocurrencyStore()),


  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
  ];
}
