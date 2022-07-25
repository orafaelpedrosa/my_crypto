import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/authentication/auth_check_store.dart';
import 'package:mycrypto/app/modules/authentication/login/login_repository.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/obscure_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/cryptocurrency_details_page.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/list_cryptocurrencies_page.dart';
import 'package:mycrypto/app/modules/cryptocurrency/repositories/cryptocurrency_repository.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/cryptocurrency_data_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/list_cryptocurrencies_store.dart';

class CryptocurrencyModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ListCryptocurrenciesStore()),
    Bind.lazySingleton((i) => CryptocurrencyDataStore()),
    Bind.lazySingleton((i) => CryptocurrencyRepository()),
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => AuthCheckStore()),
    Bind.lazySingleton((i) => LoginRepository()),
    Bind.lazySingleton((i) => ObscureStore()),


  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ListCryptocurrenciesPage()),
    ChildRoute('/details',
        child: (_, args) => CryptocurrencyDetailsPage(
              id: args.data!['id'],
              name: args.data!['name'],
            )),
  ];
}
