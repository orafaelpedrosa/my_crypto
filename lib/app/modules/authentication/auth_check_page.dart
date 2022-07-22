import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/authentication/auth_check_store.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/shared/widgets/loading/loading_widget.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({Key? key}) : super(key: key);

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  final AuthCheckStore _store = Modular.get<AuthCheckStore>();
  final LoginStore _loginStore = Modular.get<LoginStore>();

  checkLocalAuth() async {
    final isLocalAuthAvilable = await _store.isBiometricAvailable();
    final _authFirebase = FirebaseAuth.instance;
    if (_authFirebase.currentUser == null ||
        !_authFirebase.currentUser!.emailVerified) {
      Modular.to.pushReplacementNamed('/login/');
    } else {
      if (isLocalAuthAvilable) {
        final isAuth = await _store.authenticate();
        _store.updateState(isAuth);
        if (_store.state) {
          Modular.to.pushReplacementNamed('/cryptocurrency/');
        } else {
          Modular.to.pushReplacementNamed('/login/');
        }
      }
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
        return LoadingWidget();
      },
    );
  }
}
