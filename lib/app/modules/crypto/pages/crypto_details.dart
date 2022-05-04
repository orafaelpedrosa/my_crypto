import 'package:flutter/material.dart';
import 'package:mycrypto/app/core/model/cryptocurrency_model.dart';

class CryptoDetailsPage extends StatefulWidget {
  final CryptocurrencyModel cryptoModel;

  const CryptoDetailsPage({
    Key? key,
    required this.cryptoModel,
  }) : super(key: key);

  @override
  State<CryptoDetailsPage> createState() => _CryptoDetailsPageState();
}

class _CryptoDetailsPageState extends State<CryptoDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.cryptoModel.name!,
          style: Theme.of(context).textTheme.headline4,
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(),
    );
  }
}
