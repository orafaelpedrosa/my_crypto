import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/authentication/auth_check_store.dart';
import 'package:mycrypto/app/modules/authentication/login/login_repository.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/obscure_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/cryptocurrency_module.dart';
import 'package:mycrypto/app/modules/cryptocurrency/repositories/cryptocurrency_repository.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/chart_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/crypto_favorite_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/cryptocurrency_data_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/list_cryptocurrencies_store.dart';
import 'package:mycrypto/app/modules/home/home_page.dart';
import 'package:mycrypto/app/modules/home/home_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => ListCryptocurrenciesStore()),
    Bind.lazySingleton((i) => CryptocurrencyRepository()),
    Bind.lazySingleton((i) => CryptocurrencyDataStore()),
    Bind.lazySingleton((i) => ChartStore()),
    Bind.lazySingleton((i) => CryptoFavoriteStore()),
    Bind.lazySingleton((i) => ObscureStore()),
    Bind.lazySingleton((i) => AuthCheckStore()),
    Bind.lazySingleton((i) => LoginRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
      children: [
        ModuleRoute('/cryptocurrency', module: CryptocurrencyModule()),
      ],
    ),
  ];
}
