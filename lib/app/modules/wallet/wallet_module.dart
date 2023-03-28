import 'package:mycrypto/app/modules/wallet/pages/add_wallet_page.dart';
import 'package:mycrypto/app/modules/wallet/pages/remove_wallet_page.dart';
import 'package:mycrypto/app/modules/wallet/pages/wallet_page.dart';
import 'package:mycrypto/app/modules/wallet/stores/search_store.dart';
import 'package:mycrypto/app/modules/wallet/stores/wallet_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/wallet/wallet_repository.dart';

class WalletModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => WalletStore()),
    Bind.lazySingleton((i) => WalletRepository()),
    Bind.lazySingleton((i) => SearchStore()),

  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => WalletPage()),
    ChildRoute('/add', child: (_, args) => AddWalletPage()),
    ChildRoute('/remove', child: (_, args) => RemoveWalletPage()),
  ];
}
