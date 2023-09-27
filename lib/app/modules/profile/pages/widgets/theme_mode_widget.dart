import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/stores/theme_mode_store.dart';

class ThemeModeWidget extends StatefulWidget {
  const ThemeModeWidget({Key? key}) : super(key: key);

  @override
  State<ThemeModeWidget> createState() => _ThemeModeWidgetState();
}

class _ThemeModeWidgetState extends State<ThemeModeWidget> {
  final ThemeModeStore _store = Modular.get();
  ThemeMode? theme;

  void getTheme() async {
    final themeMode = await _store.getThemeMode();
    theme = themeMode;
    setState(() {});
  }

  @override
  void initState() {
    getTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            title: Text('Selecione o tema'),
            message: Text('Escolha o tema que deseja utilizar no aplicativo'),
            actions: [
              CupertinoActionSheetAction(
                child: Text(
                  'Automático',
                  style: TextStyle(
                    color: theme == ThemeMode.system
                        ? Theme.of(context).colorScheme.secondary
                        : null,
                  ),
                ),
                onPressed: () async {
                  await _store.setThemeMode(ThemeMode.system, context);
                  setState(() {
                    theme = ThemeMode.system;
                  });
                  Modular.to.pop();
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Escuro',
                  style: TextStyle(
                    color: theme == ThemeMode.dark
                        ? Theme.of(context).colorScheme.secondary
                        : null,
                  ),
                ),
                onPressed: () async {
                  await _store.setThemeMode(ThemeMode.dark, context);
                  setState(() {
                    theme = ThemeMode.dark;
                  });
                  Modular.to.pop();
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Claro',
                  style: TextStyle(
                    color: theme == ThemeMode.light
                        ? Theme.of(context).colorScheme.secondary
                        : null,
                  ),
                ),
                onPressed: () async {
                  await _store.setThemeMode(ThemeMode.light, context);
                  setState(() {
                    theme = ThemeMode.light;
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
      title: Text(
        'Tema',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
      leading: Icon(
        Icons.brightness_6_rounded,
        color: Theme.of(context).colorScheme.primary,
        size: 30,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            theme == ThemeMode.system
                ? 'Automático'
                : theme == ThemeMode.light
                    ? 'Claro'
                    : 'Escuro',
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
