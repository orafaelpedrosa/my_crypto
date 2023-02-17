import 'package:flutter/material.dart';
import 'package:mycrypto/app/core/user_store.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final UserStore userStore = UserStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configurações',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: ColoredBox(
        color: Colors.white,
        child: ListView.separated(
          itemCount: 1,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(
                Icons.fingerprint,
              ),
              title: Text(
                'Biometria',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              trailing: Switch(
                value: false,
                onChanged: (value) async {
                  userStore.state.userPreference?.hasBiometric = value;
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
