import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/profile/profile_store.dart';
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
    log(DateTime.now().toString());
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     widget.title,
      //     style: Theme.of(context).textTheme.displaySmall,
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Theme.of(context).colorScheme.background,
      //   elevation: 1,
      // ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
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
              leading: Icon(
                Icons.settings,
              ),
              title: Text(
                'Configurações',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              onTap: () {
                Modular.to.pushNamed('/home/profile/settings');
              },
            ),
          ],
        ),
      ),
    );
  }
}
