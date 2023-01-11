import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/wallet/wallet_store.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  final String title;
  const WalletPage({Key? key, this.title = 'WalletPage'}) : super(key: key);
  @override
  WalletPageState createState() => WalletPageState();
}

class WalletPageState extends State<WalletPage> {
  final WalletStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
