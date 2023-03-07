import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';
import 'package:mycrypto/app/core/user_store.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final UserStore userStore = UserStore();

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
        child: ListView.separated(
          itemCount: 1,
          itemBuilder: (context, index) {
            return null;

            // return ListTile(
            //   leading: Icon(
            //     Icons.fingerprint,
            //   ),
            //   title: Text(
            //     'Biometria',
            //     style: Theme.of(context).textTheme.headlineSmall,
            //   ),
            //   trailing: CupertinoSwitch(
            //     value: userStore.state.userPreference!.hasBiometric ==
            //         UseBiometricPermissionEnum.accepted,
            //     onChanged: (value) {
            //       setState(() {
            //         userStore.state.userPreference!.hasBiometric =
            //             UseBiometricPermissionEnum.accepted;
            //       });
            //     },
            //   ),
            // );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
