import 'package:flutter/material.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';
import 'package:mycrypto/app/core/shared/widgets/app_bar_widget.dart';

class CoinEditPage extends StatefulWidget {
  final MyCryptoModel coin;
  CoinEditPage({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  State<CoinEditPage> createState() => _CoinEditPageState();
}

class _CoinEditPageState extends State<CoinEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBarWidget(
        title: 'Editar',
      ).build(context) as AppBar,
      body: Container(
        padding: EdgeInsets.all(20),
      ),
    );
  }
}
