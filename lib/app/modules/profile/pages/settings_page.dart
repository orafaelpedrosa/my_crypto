import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycrypto/app/core/services/preferences_service.dart';
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
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text('Limpar cache'),
                      content: Text('Deseja limpar o cache do aplicativo?'),
                      actions: [
                        CupertinoDialogAction(
                          child: Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text('Limpar'),
                          onPressed: () async {
                            Navigator.of(context).pop();

                            await PreferencesService.clearPreferences()
                                .whenComplete(
                              () {
                                Future.delayed(Duration(seconds: 1)).then(
                                  (value) {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          content: Column(
                                            children: [
                                              Icon(
                                                Icons.check_circle_outline,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                size: 50,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Cache limpo!',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'O cache foi limpo com sucesso!',
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: Text('Ok'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                                // showCupertinoDialog(
                                //   context: context,
                                //   builder: (context) {
                                //     return CupertinoAlertDialog(
                                //       content: Column(
                                //         children: [
                                //           Icon(
                                //             Icons.check_circle_outline,
                                //             color: Theme.of(context)
                                //                 .colorScheme
                                //                 .primary,
                                //             size: 50,
                                //           ),
                                //           SizedBox(
                                //             height: 10,
                                //           ),
                                //           Text(
                                //             'Cache limpo!',
                                //             style: TextStyle(
                                //               fontWeight: FontWeight.bold,
                                //               fontSize: 18,
                                //             ),
                                //           ),
                                //           SizedBox(
                                //             height: 10,
                                //           ),
                                //           Text(
                                //             'O cache foi limpo com sucesso!',
                                //           ),
                                //         ],
                                //       ),
                                //       actions: [
                                //         CupertinoDialogAction(
                                //           child: Text('Ok'),
                                //           onPressed: () {
                                //             Navigator.of(context).pop();
                                //           },
                                //         ),
                                //       ],
                                //     );
                                //   },
                                // );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              title: Text(
                'Limpar Cache',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              leading: Icon(
                Icons.cleaning_services,
                color: Theme.of(context).colorScheme.primary,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
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
