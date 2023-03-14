import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';
import 'package:mycrypto/app/core/services/local_auth_service.dart';
import 'package:mycrypto/app/core/stores/use_biometric_store.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final UseBiometricStore _store = Modular.get<UseBiometricStore>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          title: Text(
            'Configurações',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
        ),
      ),
      body: ColoredBox(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.fingerprint,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text(
                'Biometria',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              trailing: TripleBuilder<UseBiometricStore, Exception,
                      UseBiometricPermissionEnum>(
                  store: _store,
                  builder: (_, triple) {
                    return CupertinoSwitch(
                      value:
                          triple.state == UseBiometricPermissionEnum.accepted,
                      onChanged: (change) async {
                        LocalAuthService.authenticate().then(
                          (value) {
                            _store.changeBiometricPermission(change);
                          },
                        );
                      },
                    );
                  }),
            ),
            ListTile(
              leading: Icon(
                Icons.monetization_on_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text(
                'Moeda',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              trailing: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 200,
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  // userStore.setCurrency('BRL');
                                },
                                title: Text('Real'),
                                trailing: Icon(Icons.check),
                              ),
                              ListTile(
                                onTap: () {
                                  // userStore.setCurrency('USD');
                                },
                                title: Text('Dolar'),
                              ),
                              ListTile(
                                onTap: () {
                                  // userStore.setCurrency('EUR');
                                },
                                title: Text('Euro'),
                              ),
                            ],
                          ),
                        );
                      });
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
