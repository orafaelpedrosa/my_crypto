import 'package:flutter/material.dart';
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

  void checkLocalAuth() async {
    await _store.checkLocalAuth();
  }

  @override
  void initState() {
    checkLocalAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<AuthCheckStore, bool>(
      store: _store,
      builder: (_, failed) {
        if (_store.state) {
          return Container(
            color: Theme.of(context).colorScheme.background,
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        height: 1.5,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Erro ao autenticar. Tente novamente para continuar usando o app.',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
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
        if (failed.isLoading)
          return Container(
            padding: const EdgeInsets.all(50),
            color: Theme.of(context).colorScheme.background,
            child: SvgPicture.asset(
              'assets/app/mycrypto.svg',
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              // color: Theme.of(context).brightness == Brightness.light
              //     ? Theme.of(context).colorScheme.primary
              //     : null,
            ),
          );
        return Container(
          color: Theme.of(context).colorScheme.background,
        );
      },
    );
  }
}
