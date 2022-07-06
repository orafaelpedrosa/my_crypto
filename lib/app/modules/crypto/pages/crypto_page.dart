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
          color: Colors.white,
          height: 25,
          width: 25,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: CryptocurrencyListWidget(),
    );
  }
}
