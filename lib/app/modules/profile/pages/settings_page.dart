import 'package:flutter/material.dart';
import 'package:mycrypto/app/modules/profile/pages/widgets/delete_account_widget.dart';
import 'package:mycrypto/app/modules/profile/pages/widgets/enable_biometric_widget.dart';
import 'package:mycrypto/app/modules/profile/pages/widgets/theme_mode_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            EnableBiometricWidget(),
            ThemeModeWidget(),
            DeleteAccountWidget(),
          ],
        ),
      ),
    );
  }
}
