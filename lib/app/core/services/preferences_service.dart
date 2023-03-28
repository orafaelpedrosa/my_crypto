import 'package:flutter/material.dart';
import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';
import 'package:mycrypto/app/core/models/user_preference_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static Future<void> setPreferencesUser(
      UserPreferenceModel userPreference) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('userPreference', userPreference.toJson());
  }

  static Future<UserPreferenceModel> getPreferencesUser() async {
    final preferences = await SharedPreferences.getInstance();
    final userPreference = preferences.getString('userPreference');
    if (userPreference != null) {
      return UserPreferenceModel.fromJson(userPreference);
    } else {
      return UserPreferenceModel();
    }
  }

  static Future<void> setVsCurrency(String vsCurrency) async {
    await SharedPreferences.getInstance().then(
      (instance) async {
        await instance.setString('vs_currency', vsCurrency);
      },
    );
  }

  static Future<String> getVsCurrency() async {
    return SharedPreferences.getInstance().then(
      (instance) async {
        return instance.getString('vs_currency')!;
      },
    );
  }

  static Future<void> setHasBiometrics(
      UseBiometricPermissionEnum useBiometrics) async {
    await SharedPreferences.getInstance().then(
      (instance) async {
        await instance.setString(
          'has_biometric',
          useBiometricPermissionFromJson(useBiometrics),
        );
      },
    );
  }

  static Future<UseBiometricPermissionEnum?> getHasBiometrics() async {
    return SharedPreferences.getInstance().then(
      (instance) async {
        return useBiometricPermissionFromDevice(
          instance.getString('has_biometric'),
        );
      },
    );
  }

  static Future<bool> clearPreferences() async {
    return SharedPreferences.getInstance().then(
      (instance) async {
        return instance.clear();
      },
    );
  }

  static Future<void> setThemeType(ThemeMode themeMode) async {
    await SharedPreferences.getInstance().then(
      (instance) async {
        await instance.setString(
          'theme',
          themeMode.name,
        );
      },
    );
  }

  static Future<ThemeMode> getThemeType() async {
    return SharedPreferences.getInstance().then(
      (instance) async {
        if (instance.getString('theme') != null) {
          return themeModeFromJson(instance.getString('theme')!);
        } else {
          return ThemeMode.system;
        }
      },
    );
  }

  static ThemeMode themeModeFromJson(String s) {
    switch (s) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
