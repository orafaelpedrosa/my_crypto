import 'dart:convert';

import 'package:mycrypto/app/core/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
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
}
