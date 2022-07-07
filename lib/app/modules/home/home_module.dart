import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/crypto/crypto_repository.dart';
import 'package:mycrypto/app/modules/authentication/modules/login/pages/login_page.dart';
import 'package:mycrypto/app/modules/crypto/stores/crypto_list_store.dart';
import '../home/home_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => CryptoRepository()),
    Bind.lazySingleton((i) => CryptoListStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const LoginPage()),
  ];
}
