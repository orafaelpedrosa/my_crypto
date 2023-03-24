import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';
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
  final UserStore _userStore = Modular.get();

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
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: <Widget>[
            ClipOval(
              child: SizedBox.fromSize(
                size: Size(100, 100),
                child: _userStore.user!.photoURL != null
                    ? Image.network(
                        '${_userStore.user!.photoURL!}',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )
                    : Icon(
                        Icons.person,
                        size: 100,
                        color: Theme.of(context).colorScheme.primary,
                      ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              '${_userStore.user!.displayName ?? 'Usuário'}',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                Modular.to.pushNamed('settings');
              },
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ),
              title: Text(
                'Configurações',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).colorScheme.secondary,
                size: 15,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  routeSettings: RouteSettings(name: 'Sair'),
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text('Sair'),
                      content: Text('Deseja realmente sair?'),
                      actions: [
                        CupertinoDialogAction(
                          child: Text('Não'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text('Sim'),
                          onPressed: () {
                            _userStore.signOut();
                            // Navigator.pushNamedAndRemoveUntil(context,
                            //     '/login/', ModalRoute.withName('/home/'));
                            Modular.to.pop();
                            Modular.to.pushReplacementNamed('/login/');
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              leading: Icon(
                Icons.logout_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ),
              title: Text(
                'Sair',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
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
