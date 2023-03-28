import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/services/preferences_service.dart';

class ThemeModeStore extends Store<ThemeMode> {
  ThemeModeStore() : super(ThemeMode.system);

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await PreferencesService.setThemeType(themeMode);
    if (themeMode == ThemeMode.system) {
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      if (brightness == Brightness.dark) {
        update(ThemeMode.dark);
      } else {
        update(ThemeMode.light);
      }
    } else {
      update(themeMode);
    }
  }

  Future<ThemeMode> getThemeMode() async {
    final themeMode = await PreferencesService.getThemeType();
    update(themeMode);
    switch (themeMode) {
      case ThemeMode.light:
        return ThemeMode.light;
      case ThemeMode.dark:
        return ThemeMode.dark;
      case ThemeMode.system:
        return ThemeMode.system;
    }
  }

  void updateState(ThemeMode theme) {
    update(theme);
  }
}
