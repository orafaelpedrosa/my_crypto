import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/auth/modules/login/stores/login_store.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({Key? key}) : super(key: key);

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  final LoginStore _loginStore = Modular.get();
  @override
  void initState() {
    // _loginStore.authService();
    super.initState();
  }

//   @override
//   Widget build(BuildContext context) {
//     if (_loginStore.userCurrent == null) {
//       Modular.to.pushNamed('login_module');
//     } else {
//       Modular.to.pushNamed('crypto_module/');
//     }
//     return SizedBox.shrink();
//   }
// }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            Modular.to.pushReplacementNamed('login_module');
            _loginStore.userCurrent = null;
          } else {
            Modular.to.pushReplacementNamed('crypto_module/');
            _loginStore.userCurrent = snapshot.data;
          }
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
