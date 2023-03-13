import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final _preferences = SharedPreferences.getInstance();

  static Future<void> setHasBiometricPermission(
      UseBiometricPermissionEnum hasBiometricPermission) async {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('hasBiometric', hasBiometricPermission.label);
    });
  }

  static Future<UseBiometricPermissionEnum> getHasBiometricPermission() async {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getString('hasBiometric') == 'accepted'
          ? UseBiometricPermissionEnum.accepted
          : prefs.getString('hasBiometric') == 'notAccepted'
              ? UseBiometricPermissionEnum.notAccepted
              : UseBiometricPermissionEnum.denied;
    });
  }

  //print all preferences
  static Future<void> printAllPreferences() async {
    SharedPreferences.getInstance().then((prefs) {
      prefs.getKeys().forEach((key) {
        print('$key: ${prefs.getString(key)}');
      });
    });
  }
}
