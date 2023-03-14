import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';
import 'package:mycrypto/app/core/models/user_model.dart';
import 'package:mycrypto/app/core/models/user_preference_model.dart';
import 'package:mycrypto/app/core/services/preferences_service.dart';

// ignore: must_be_immutable
class UserStore extends NotifierStore<Exception, UserModel> {
  UserStore()
      : super(UserModel(
          userPreference: UserPreferenceModel(),
        ));
  User? user;

  Future<void> getUser() async {
    user = FirebaseAuth.instance.currentUser!;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  bool stateUser() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> setUser(UserModel user) async {
    update(user);
  }

  Future<void> setBiometric(bool hasBiometric) async {
    if (hasBiometric) {
      state.userPreference.hasBiometric = UseBiometricPermissionEnum.accepted;
    } else {
      state.userPreference.hasBiometric =
          UseBiometricPermissionEnum.notAccepted;
    }
    await setPreference(state.userPreference);
    await getPreference();
    update(state);
  }

  Future<void> setPreference(UserPreferenceModel userPreference) async {
    await PreferencesService().setPreferencesUser(userPreference);
  }

  Future<void> getPreference() async {
    final userPreference = await PreferencesService().getPreferencesUser();
    state.userPreference = userPreference;
    update(state);
  }
}
