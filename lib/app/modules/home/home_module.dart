import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/cryptocurrency/cryptocurrency_module.dart';
import 'package:mycrypto/app/modules/favorites/favorites_module.dart';
import 'package:mycrypto/app/modules/home/home_page.dart';
import 'package:mycrypto/app/modules/home/home_store.dart';
import 'package:mycrypto/app/modules/profile/profile_module.dart';
import 'package:mycrypto/app/modules/wallet/wallet_module.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
      children: [
        ModuleRoute(
          '/cryptocurrency',
          module: CryptocurrencyModule(),
        ),
        ModuleRoute(
          '/favorites',
          module: FavoritesModule(),
        ),
        ModuleRoute(
          '/wallet',
          module: WalletModule(),
        ),
        ModuleRoute(
          '/profile',
          module: ProfileModule(),
        ),
      ],
    ),
  ];
}
