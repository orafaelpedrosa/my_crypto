import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/model/credential_model.dart';
import 'package:mycrypto/app/modules/auth/modules/login/pages/login_page.dart';
import 'package:mycrypto/app/modules/auth/modules/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/crypto/pages/crypto_page.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({Key? key}) : super(key: key);

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  final LoginStore _loginStore = Modular.get();
  @override
  void initState() {
    _loginStore.authService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TripleBuilder<LoginStore, FirebaseAuthException, CredentialModel>(
        store: _loginStore,
        builder: (context, triple) {
          if (triple.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_loginStore.userCurrent == null) {
            return LoginPage();
          } else {
            return CryptoPage();
          }
        },
      ),
    );
  }
}
