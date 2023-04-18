import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/models/user_model.dart';
import 'package:mycrypto/app/core/models/user_preference_model.dart';
import 'package:mycrypto/app/core/services/firestore_repository.dart';
import 'package:mycrypto/app/core/services/preferences_service.dart';

// ignore: must_be_immutable
class UserStore extends Store<UserModel> {
  UserStore()
      : super(UserModel(
          userPreference: UserPreferenceModel(),
        ));
  User? user;

  late FirebaseFirestore db;

  startFirestore() async {
    db = FirestoreRepository.get();
  }

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

  Future<void> setPreferenceFirebase(UserPreferenceModel preference) async {
    db
        .collection('users')
        .doc(user!.uid)
        .collection('preferences')
        .doc(DateTime.now().toIso8601String())
        .set(preference.toMap());
  }

  Future<void> getPreference() async {
    final userPreference = await PreferencesService.getPreferencesUser();
    state.userPreference = userPreference;
    update(state);
  }  
}
