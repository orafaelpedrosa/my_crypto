import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({Key? key}) : super(key: key);

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  @override
  void initState() {
    _loginStore..authLogout();
    super.initState();
  }

  final LoginStore _loginStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          log('User is null');
          Modular.to.pushReplacementNamed('/login_module/');
          _loginStore.userCurrent = null;
        } else {
          log('User is ${snapshot.data!.email}');
          Modular.to.pushReplacementNamed('/crypto_module/');
          _loginStore.userCurrent = snapshot.data;
        }
        return Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ),
        );
      },
    );
  }
}
