import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/profile/stores/profile_store.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  const ProfilePage({Key? key, this.title = 'Perfil'}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final ProfileStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ),
              onPressed: () {
                // store.loginStore.authLogout();
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                //circular
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                Modular.to.pushNamed('/home/profile/settings');
              },
              leading: Icon(
                Icons.settings,
                // color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text(
                'Configurações',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).colorScheme.secondary,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
