import 'package:mycrypto/app/modules/wallet/wallet_page.dart';
import 'package:mycrypto/app/modules/wallet/wallet_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WalletModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => WalletStore()),];

  @override
  final List<ModularRoute> routes = [ChildRoute('/', child: (_, args) => WalletPage()),];

}