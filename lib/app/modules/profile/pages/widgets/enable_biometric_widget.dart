import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';
import 'package:mycrypto/app/core/services/local_auth_service.dart';
import 'package:mycrypto/app/core/stores/use_biometric_store.dart';

class EnableBiometricWidget extends StatefulWidget {
  const EnableBiometricWidget({Key? key}) : super(key: key);

  @override
  State<EnableBiometricWidget> createState() => _EnableBiometricWidgetState();
}

class _EnableBiometricWidgetState extends State<EnableBiometricWidget> {
  final UseBiometricStore _store = Modular.get<UseBiometricStore>();
  bool _visibleBiometric = true;

  @override
  void initState() {
    _checkBiometric();
    super.initState();
  }

  void _checkBiometric() async {
    _visibleBiometric = await _store.hasBiometricsAvailable();
    if (!_visibleBiometric) {
      _store.setHasBiometrics(false);
    }
    _store.updateState(await _store.getHasBiometrics());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visibleBiometric,
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Icon(
          Icons.fingerprint,
          color: Theme.of(context).colorScheme.primary,
          size: 30,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Biometria',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            IconButton(
              icon: Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.secondary,
                size: 17,
              ),
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text('Biometria'),
                      content: Text(
                        'Nós utilizamos a biometria somente para desbloquear o aplicativo e garantir a sua segurança. Saiba que as suas informações biométricas não são coletadas ou armazenadas em nossos sistemas. A sua privacidade é uma prioridade para nós.',
                      ),
                      actions: [
                        CupertinoDialogAction(
                          child: Text('Entendi'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        trailing: TripleBuilder<UseBiometricStore, UseBiometricPermissionEnum>(
          store: _store,
          builder: (_, triple) {
            return CupertinoSwitch(
              activeColor: Theme.of(context).colorScheme.primary,
              value: triple.state == UseBiometricPermissionEnum.accepted,
              onChanged: (change) async {
                LocalAuthService.authenticate().then(
                  (value) {
                    _store.setHasBiometrics(change);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
