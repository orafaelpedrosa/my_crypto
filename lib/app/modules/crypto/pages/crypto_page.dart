import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycrypto/app/modules/crypto/pages/widget/crypto_list_widget.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({Key? key}) : super(key: key);

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/app/mycrypto.svg',
          color: Theme.of(context).primaryColor,
          height: 25,
          width: 25,
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: const CryptocurrencyListWidget(),
    );
  }
}
