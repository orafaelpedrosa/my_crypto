import 'package:flutter/material.dart';
import 'package:mycrypto/app/core/enums/theme_type_enum.dart';
import 'package:mycrypto/app/core/services/preferences_service.dart';
import 'package:mycrypto/app/core/theme/app_theme.dart';

class ThemeManager {
  ThemeModeEnum? _themeType;

  Future<ThemeModeEnum> getThemeType() async {
    await PreferencesService.getThemeType().then((value) {
      _themeType = value;
    });
    return _themeType!;
  }

  Future<void> setThemeType(ThemeModeEnum themeType) async {
    await PreferencesService.setThemeType(themeType);

    if (themeType == ThemeModeEnum.system) {
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      if (brightness == Brightness.dark) {
        _themeType = ThemeModeEnum.dark;
      } else {
        _themeType = ThemeModeEnum.light;
      }
    } else {
      _themeType = themeType;
    }
  }

  ThemeData get themeData {
    switch (_themeType) {
      case ThemeModeEnum.light:
        return AppTheme.lightTheme;
      case ThemeModeEnum.dark:
        return AppTheme.darkTheme;
      default:
        return AppTheme.lightTheme;
    }
  }
}
