import 'package:flutter/material.dart';
import 'package:mycrypto/app/modules/crypto/crypto_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CryptoPage(),
    );
  }
}
