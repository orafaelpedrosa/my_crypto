import 'dart:convert';

import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';
import 'package:mycrypto/app/core/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final _preferences = SharedPreferences.getInstance();

  static Future<void> setUserPreferences(UserModel user) async {
    await SharedPreferences.getInstance().then(
      (instance) async {
        await instance.setString('userID', user.uid!);
        await instance.setString(
          'userPreferences',
          jsonEncode(user.userPreference!.toMap()),
        );
      },
    );
  }

  Future<void> setHasBiometrics(
      UseBiometricPermissionEnum useBiometrics) async {
    _preferences.then(
      (instance) async {
        await instance.setString(
          'hasBiometrics',
          useBiometricPermissionFromJson(useBiometrics),
        );
      },
    );
  }
}
