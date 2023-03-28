import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ModalMenuWalletWidget extends StatelessWidget {
  const ModalMenuWalletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: Text('Adicionar'),
          onPressed: () {
            Modular.to.pushNamed('/wallet/add');
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Remover'),
          onPressed: () {
            Modular.to.pushNamed('/wallet/remove');
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Editar'),
          onPressed: () {
            Modular.to.pushNamed('/wallet/edit');
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          'Cancelar',
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () {
          Modular.to.pop();
        },
      ),
    );
  }
}
