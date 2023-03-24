import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DeleteAccountWidget extends StatefulWidget {
  const DeleteAccountWidget({Key? key}) : super(key: key);

  @override
  State<DeleteAccountWidget> createState() => _DeleteAccountWidgetState();
}

class _DeleteAccountWidgetState extends State<DeleteAccountWidget> {
  final UserStore store = UserStore();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                'Deletar conta',
              ),
              content: Text(
                'Lembre-se que ao deletar sua conta, você perderá todos os seus dados e não poderá recuperá-los.',
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text(
                    'Cancelar',
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoDialogAction(
                  child: Text(
                    'Deletar',
                  ),
                  onPressed: () async {
                    // store.userStore.deleteUser();
                    await store.deleteUser();
                    await store.signOut();
                    Modular.to.pop();
                    Modular.to.pushNamed('/login/');
                  },
                ),
              ],
            );
          },
        );
      },
      leading: Icon(
        Icons.delete,
        color: Theme.of(context).colorScheme.error,
        size: 30,
      ),
      title: Text(
        'Deletar conta',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
      ),
    );
  }
}
