import 'package:flutter/material.dart';
import 'package:mycrypto/app/modules/profile/pages/widgets/enable_biometric_widget.dart';

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
            // ListTile(
            //   leading: Icon(
            //     Icons.dark_mode_rounded,
            //     color: Theme.of(context).colorScheme.secondary,
            //   ),
            //   title: Text(
            //     'Tema Escuro',
            //     style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            //           color: Theme.of(context).colorScheme.secondary,
            //         ),
            //   ),
            //   trailing: TripleBuilder<UseBiometricStore, Exception,
            //           UseBiometricPermissionEnum>(
            //       store: _store,
            //       builder: (_, triple) {
            //         return CupertinoSwitch(
            //           thumbColor: Theme.of(context).colorScheme.secondary,
            //           activeColor: Theme.of(context).colorScheme.primary,
            //           value:
            //               triple.state == UseBiometricPermissionEnum.accepted,
            //           onChanged: (change) async {
            //             LocalAuthService.authenticate().then(
            //               (value) {
            //                 _store.changeBiometricPermission(change);
            //               },
            //             );
            //           },
            //         );
            //       }),
            // ),
            // ListTile(
            //   leading: Icon(
            //     Icons.monetization_on_outlined,
            //     color: Theme.of(context).colorScheme.secondary,
            //   ),
            //   title: Text(
            //     'Moeda',
            //     style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            //           color: Theme.of(context).colorScheme.secondary,
            //         ),
            //   ),
            //   trailing: IconButton(
            //     onPressed: () {
            //       showModalBottomSheet(
            //         context: context,
            //         builder: (context) {
            //           return Container(
            //             height: 200,
            //             child: Column(
            //               children: [
            //                 ListTile(
            //                   onTap: () {},
            //                   title: Text('Real'),
            //                   trailing: Icon(Icons.check),
            //                 ),
            //                 ListTile(
            //                   onTap: () {},
            //                   title: Text('Dolar'),
            //                 ),
            //                 ListTile(
            //                   onTap: () {},
            //                   title: Text('Euro'),
            //                 ),
            //               ],
            //             ),
            //           );
            //         },
            //       );
            //     },
            //     icon: Icon(
            //       Icons.arrow_forward_ios,
            //       color: Theme.of(context).colorScheme.secondary,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
