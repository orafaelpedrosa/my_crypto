import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/repositories/cryptocurrency_repository.dart';
import 'package:mycrypto/app/modules/crypto/stores/cryptocurrency_store.dart';
import '../home/home_store.dart'; 

import 'home_page.dart';
 
class HomeModule extends Module {
  @override
  final List<Bind> binds = [
 Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => CryptocurrencyRepository()),
    Bind.lazySingleton((i) => CryptocurrencyRepository()),
 Bind.lazySingleton((i) => CryptocurrencyStore()),

 ];

 @override
 final List<ModularRoute> routes = [
   ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),

 ];
}