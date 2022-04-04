import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/auth/auth_login_page.dart';
import 'package:mycrypto/app/modules/auth/stores/auth_check_store.dart';
import 'package:mycrypto/app/modules/crypto/crypto_page.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({Key? key}) : super(key: key);

  @override
  _AuthCheckPageState createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  final AuthCheckStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<AuthCheckStore, Exception, bool>(
      store: store,
      builder: (_, context) {
        if (store.isLoading) {
          return Scaffold(
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (store.user == null) {
            return AuthLoginPage();
          } else {
            return CryptoPage();
          }
        }
      },
    );
  }
}