import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/authentication/auth_check_store.dart';
import 'package:mycrypto/app/shared/widgets/loading/loading_widget.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({Key? key}) : super(key: key);

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  final AuthCheckStore _store = Modular.get<AuthCheckStore>();

  checkLocalAuth() async {
    final isLocalAuthAvilable = await _store.isBiometricAvailable();
    if (isLocalAuthAvilable) {
      final isAuthenticated = await _store.authenticate();
      log('store 1: ${_store.state}');
      _store.updateState(isAuthenticated);
      log('store 2: ${_store.state}');

      if (_store.state) {
        Modular.to.pushReplacementNamed('/cryptocurrency/');
      }
    } else {
      Modular.to.pushReplacementNamed('/login/');
    }
  }

  @override
  void initState() {
    checkLocalAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<AuthCheckStore, PlatformException, bool>(
      store: _store,
      builder: (_, failed) {
        if (_store.state) {
          return Center(
            child: ElevatedButton(
              child: Text('Tente autenticar'),
              onPressed: () {
                checkLocalAuth();
              },
            ),
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}

          // return StreamBuilder<User?>(
          //   stream: FirebaseAuth.instance.authStateChanges(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     } else if (snapshot.hasData && snapshot.data!.emailVerified) {
          //       Modular.to.pushNamed('/cryptocurrency/');
          //     } else if (snapshot.hasError) {
          //       return Center(
          //         child: Text('Error: ${snapshot.error}'),
          //       );
          //     } else {
          //       Modular.to.pushNamed('/login/');
          //     }
          //     return LoadingWidget();
          //   },
          // );
