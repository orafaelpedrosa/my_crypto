import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/enums/theme_type_enum.dart';
import 'package:mycrypto/app/core/services/theme_manager.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';

class ThemeModeWidget extends StatefulWidget {
  const ThemeModeWidget({Key? key}) : super(key: key);

  @override
  State<ThemeModeWidget> createState() => _ThemeModeWidgetState();
}

class _ThemeModeWidgetState extends State<ThemeModeWidget> {
  ThemeModeEnum? theme;
  final UserStore _store = Modular.get();

  void getTheme() async {
    await ThemeManager().getThemeType().then((value) {
      setState(() {
        theme = value;
      });
    });
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
            actions: [
              CupertinoActionSheetAction(
                child: Text(
                  'Sistema',
                  style: theme == ThemeModeEnum.system
                      ? TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      : null,
                ),
                onPressed: () async {
                  await ThemeManager().setThemeType(ThemeModeEnum.system);
                  setState(() {
                    theme = ThemeModeEnum.system;
                  });
                  Modular.to.pop();
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Claro',
                  style: theme == ThemeModeEnum.light
                      ? TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      : null,
                ),
                onPressed: () async {
                  await ThemeManager().setThemeType(ThemeModeEnum.light);
                  setState(() {
                    theme = ThemeModeEnum.light;
                  });
                  Modular.to.pop();
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Escuro',
                  style: theme == ThemeModeEnum.dark
                      ? TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      : null,
                ),
                onPressed: () async {
                  await ThemeManager().setThemeType(ThemeModeEnum.dark);
                  setState(() {
                    theme = ThemeModeEnum.dark;
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
        children: [
          Text(
            theme == ThemeModeEnum.system
                ? 'Sistema'
                : theme == ThemeModeEnum.light
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
            color: Theme.of(context).colorScheme.secondary,
            size: 15,
          ),
        ],
      ),
    );
  }
}
