import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/shared/widgets/loading/loading_widget.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({Key? key}) : super(key: key);

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData && snapshot.data!.emailVerified) {
          Modular.to.pushNamed('/cryptocurrency/');
          // return ListCryptocurrenciesPage();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          Modular.to.pushNamed('/login/');
          // return LoginPage();
        }
        return LoadingWidget();
        // return SizedBox.shrink();
      },
    );
  }
}
