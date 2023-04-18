import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/services/preferences_service.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';

class ChangeVsCurrenyWidget extends StatefulWidget {
  const ChangeVsCurrenyWidget({Key? key}) : super(key: key);

  @override
  State<ChangeVsCurrenyWidget> createState() => _ChangeVsCurrenyWidgetState();
}

class _ChangeVsCurrenyWidgetState extends State<ChangeVsCurrenyWidget> {
  final UserStore _userStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    String vsCurrency = _userStore.state.userPreference.vsCurrency!;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            title: Text('Seleciona a moeda'),
            message: Text(
                'Selecione a moeda que deseja utilizar para exibir o valor de suas criptomoedas'),
            actions: [
              CupertinoActionSheetAction(
                child: Text(
                  'USD',
                  style: TextStyle(
                    color: vsCurrency == 'USD'
                        ? Theme.of(context).colorScheme.secondary
                        : null,
                  ),
                ),
                onPressed: () async {
                  PreferencesService.setVsCurrency('USD');
                  await _userStore.getPreference();
                  setState(() {
                    vsCurrency = 'USD';
                  });
                  Modular.to.pop();
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'BRL',
                  style: TextStyle(
                    color: vsCurrency == 'BRL'
                        ? Theme.of(context).colorScheme.secondary
                        : null,
                  ),
                ),
                onPressed: () async {
                  PreferencesService.setVsCurrency('BRL');
                  await _userStore.getPreference();
                  setState(() {
                    vsCurrency = 'BRL';
                  });
                  Modular.to.pop();
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text('Cancelar'),
              onPressed: () {
                Modular.to.pop();
              },
            ),
          ),
        );
      },
      leading: Icon(
        Icons.attach_money_rounded,
        color: Theme.of(context).colorScheme.primary,
        size: 30,
      ),
      title: Text(
        'Moeda',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            vsCurrency,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                ),
          ),
          SizedBox(width: 8),
          Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).colorScheme.primary,
            size: 15,
          ),
        ],
      ),
    );
  }
}
