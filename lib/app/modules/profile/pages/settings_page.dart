import 'package:flutter/material.dart';
import 'package:mycrypto/app/modules/profile/pages/widgets/change_vs_currency_widget.dart';
import 'package:mycrypto/app/modules/profile/pages/widgets/delete_account_widget.dart';
import 'package:mycrypto/app/modules/profile/pages/widgets/enable_biometric_widget.dart';
import 'package:mycrypto/app/modules/profile/pages/widgets/theme_mode_widget.dart';
import 'package:mycrypto/app/shared/widgets/app_bar_widget.dart';

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
      appBar: AppBarWidget(
        title: 'Configurações',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ).build(context) as AppBar,
      body: Container(
        padding: EdgeInsets.all(15),
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: <Widget>[
            EnableBiometricWidget(),
            Divider(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
              thickness: 0.5,
            ),
            ChangeVsCurrenyWidget(),
            Divider(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
              thickness: 0.5,
            ),
            ThemeModeWidget(),
            Divider(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
              thickness: 0.5,
            ),
            DeleteAccountWidget(),
            Divider(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
