import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycrypto/app/core/services/theme_manager.dart';
import 'package:mycrypto/app/core/enums/theme_type_enum.dart';

class ThemeModeWidget extends StatefulWidget {
  const ThemeModeWidget({Key? key}) : super(key: key);

  @override
  State<ThemeModeWidget> createState() => _ThemeModeWidgetState();
}

class _ThemeModeWidgetState extends State<ThemeModeWidget> {
  final theme =  ThemeManager().getThemeType();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (theme == ThemeType.light) {
          ThemeManager().setThemeType(ThemeType.dark);
        } else {
          ThemeManager().setThemeType(ThemeType.light);
        }
      },
      leading: Icon(
        Icons.nightlight_round,
        color: Theme.of(context).colorScheme.primary,
        size: 30,
      ),
      title: Text(
        'Tema escuro',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
      trailing: CupertinoSwitch(
        activeColor: Theme.of(context).colorScheme.primary,
        value: true,
        onChanged: (value) {
          // store.themeStore.setDarkMode(value);
        },
      ),
      // value: store.themeStore.isDarkMode,
    );
  }
}
