import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/list_cryptocurrencies_page.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/cryptocurrency_store.dart';

class CryptocurrencyModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CryptocurrencyStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ListCryptocurrenciesPage()),
  ];
}
