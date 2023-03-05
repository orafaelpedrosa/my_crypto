import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';
import 'package:mycrypto/app/modules/wallet/wallet_store.dart';
import 'package:flutter/material.dart';
import 'package:mycrypto/app/modules/wallet/widgets/modal_menu_wallet_widget.dart';

class WalletPage extends StatefulWidget {
  final String title;
  const WalletPage({Key? key, this.title = 'Carteira'}) : super(key: key);
  @override
  WalletPageState createState() => WalletPageState();
}

class WalletPageState extends State<WalletPage> {
  final WalletStore store = Modular.get();

  MyCryptoModel crypto = MyCryptoModel(
    id: 'bloktopia',
    amount: 3406.0,
    averagePrice: 0.027,
  );

  @override
  void initState() {
    store.updatePrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
            onPressed: () {
              //modal menu aqui
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return ModalMenuWalletWidget();
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
