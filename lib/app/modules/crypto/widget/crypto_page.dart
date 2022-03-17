import 'package:flutter/material.dart';
import 'package:mycrypto/app/modules/crypto/widget/cryptocurrency_list_widget.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({ Key? key }) : super(key: key);

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto'),
      ),
      body: const CryptocurrencyListWidget(),
    );
  }
}