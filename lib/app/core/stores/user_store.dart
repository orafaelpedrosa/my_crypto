import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';
import 'package:mycrypto/app/core/models/user_model.dart';
import 'package:mycrypto/app/core/models/user_preference_model.dart';
import 'package:mycrypto/app/core/services/preferences_service.dart';

// ignore: must_be_immutable
class UserStore extends Store<UserModel> {
  UserStore()
      : super(UserModel(
          userPreference: UserPreferenceModel(),
        ));
  User? user;

  Future<void> getUser() async {
    user = FirebaseAuth.instance.currentUser!;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //delete user
  Future<void> deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  bool stateUser() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> setUser(UserModel user) async {
    update(user);
  }

  Future<void> setBiometric(bool hasBiometrics) async {
    if (hasBiometrics) {
      state.userPreference.hasBiometrics = UseBiometricPermissionEnum.accepted;
    } else {
      state.userPreference.hasBiometrics = UseBiometricPermissionEnum.denied;
    }
    await setPreference(state.userPreference);
    await getPreference();
    update(state);
  }

  Future<void> setPreference(UserPreferenceModel userPreference) async {
    await PreferencesService.setPreferencesUser(userPreference);
  }

  Future<void> getPreference() async {
    final userPreference = await PreferencesService.getPreferencesUser();
    state.userPreference = userPreference;
    update(state);
  }
}
