import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/repositories/cryptocurrency_repository.dart';
import 'package:mycrypto/app/modules/auth/modules/login/pages/login_page.dart';
import 'package:mycrypto/app/modules/crypto/stores/list_crypto_store.dart';
import '../home/home_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => CryptocurrencyRepository()),
    Bind.lazySingleton((i) => CryptoListStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const LoginPage()),
  ];
}
