import 'package:flutter/material.dart';
import 'package:mycrypto/app/core/enums/theme_type_enum.dart';
import 'package:mycrypto/app/core/services/preferences_service.dart';
import 'package:mycrypto/app/core/theme/app_theme.dart';

class ThemeManager {
  ThemeType _themeType = ThemeType.dark;

  ThemeType getThemeType() {
    PreferencesService.getThemeType().then((value) {
      _themeType = value;
    });
    return _themeType;
  }

  Future<void> setThemeType(ThemeType themeType) async {
    _themeType = themeType;
    await PreferencesService.setThemeType(themeType);
  }

  ThemeData get themeData {
    switch (_themeType) {
      case ThemeType.light:
        return AppTheme.lightTheme;
      case ThemeType.dark:
        return AppTheme.darkTheme;
      default:
        return AppTheme.lightTheme;
    }
  }
}
