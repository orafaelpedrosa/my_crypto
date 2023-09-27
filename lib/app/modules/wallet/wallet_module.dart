import 'package:mycrypto/app/modules/wallet/pages/add_wallet_page.dart';
import 'package:mycrypto/app/modules/wallet/pages/coin_details_in_wallet_pager.dart';
import 'package:mycrypto/app/modules/wallet/pages/coin_edit_paget.dart';
import 'package:mycrypto/app/modules/wallet/pages/transaction_history_page.dart';
import 'package:mycrypto/app/modules/wallet/pages/wallet_page.dart';
import 'package:mycrypto/app/modules/wallet/stores/transaction_history_store.dart';
import 'package:mycrypto/app/modules/wallet/stores/wallet_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/wallet/wallet_repository.dart';

class WalletModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => WalletRepository()),
    Bind.lazySingleton((i) => WalletStore()),
    Bind.lazySingleton((i) => TransactionHistoryStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => WalletPage()),
    ChildRoute('/add', child: (_, args) => AddWalletPage(coin: args.data)),
    ChildRoute('/edit', child: (_, args) => CoinEditPage(coin: args.data)),
    ChildRoute('/transaction',
        child: (_, args) => TransactionHistoryPage(id: args.data)),
    ChildRoute('/coin_details',
        child: (_, args) => CoinDetaisInWalletPage(coin: args.data)),
  ];
}
