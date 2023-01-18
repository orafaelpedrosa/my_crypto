import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/authentication/auth_check_store.dart';
import 'package:mycrypto/app/shared/widgets/button/button_primary_widget.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({Key? key}) : super(key: key);

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  final AuthCheckStore _store = Modular.get<AuthCheckStore>();

  checkLocalAuth() async {
    final isLocalAuthAvilable = await _store.isBiometricAvailable();
    final _authFirebase = FirebaseAuth.instance;

    _store.updateState(false);
    if (_authFirebase.currentUser == null ||
        !_authFirebase.currentUser!.emailVerified) {
      Modular.to.pushReplacementNamed('/login/');
    } else {
      if (isLocalAuthAvilable) {
        final _authenticate = await _store.authenticate();

        if (!_authenticate) {
          _store.updateState(true);
        } else {
          Modular.to.pushReplacementNamed('/home/');
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
        if (_store.state) {
          return Container(
            color: Theme.of(context).backgroundColor,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/login/auth.svg',
                  height: 200,
                  width: 200,
                  placeholderBuilder: (context) => Container(
                    height: 100,
                    width: 100,
                    child: const CircularProgressIndicator(),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Acesse o MyCrypto',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).cardColor,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Erro ao autenticar. Tente novamente para continuar usando o app.',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Theme.of(context).cardColor,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                ButtonPrimaryWidget(
                  text: 'Tente novamente',
                  onPressed: () {
                    checkLocalAuth();
                  },
                  isLoading: false,
                ),
              ],
            ),
          );
        }
        return Container(
          color: Theme.of(context).cardColor,
        );
      },
    );
  }
}
