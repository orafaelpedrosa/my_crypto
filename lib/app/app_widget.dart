import 'package:flutter/material.dart';
import 'package:mycrypto/app/modules/auth/auth_login_page.dart';
import 'package:mycrypto/app/modules/crypto/crypto_page.dart';
import 'package:mycrypto/app/modules/crypto/widget/cryptocurrency_list_widget.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const CryptoPage(),
    );
  }
}
