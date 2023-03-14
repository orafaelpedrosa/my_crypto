import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';
import 'package:mycrypto/app/core/models/user_preference_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future<void> setPreferencesUser(UserPreferenceModel userPreference) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('userPreference', userPreference.toJson());
  }

  Future<UserPreferenceModel> getPreferencesUser() async {
    final preferences = await SharedPreferences.getInstance();
    final userPreference = preferences.getString('userPreference');
    if (userPreference != null) {
      return UserPreferenceModel.fromJson(userPreference);
    } else {
      return UserPreferenceModel();
    }
  }

  Future<void> setVsCurrency(String vsCurrency) async {
    await SharedPreferences.getInstance().then(
      (instance) async {
        await instance.setString('vs_currency', vsCurrency);
      },
    );
  }

  Future<String> getVsCurrency() async {
    return SharedPreferences.getInstance().then(
      (instance) async {
        return instance.getString('vs_currency')!;
      },
    );
  }

  Future<void> setHasBiometrics(
      UseBiometricPermissionEnum useBiometrics) async {
    await SharedPreferences.getInstance().then(
      (instance) async {
        await instance.setString(
          'biometric',
          useBiometricPermissionFromJson(useBiometrics),
        );
      },
    );
  }

  Future<UseBiometricPermissionEnum?> getHasBiometrics() async {
    return SharedPreferences.getInstance().then(
      (instance) async {
        return useBiometricPermissionFromDevice(
          instance.getString('biometric'),
        );
      },
    );
  }

  Future<bool> clearPreferences() async {
    return SharedPreferences.getInstance().then(
      (instance) async {
        return instance.clear();
      },
    );
  }
}
