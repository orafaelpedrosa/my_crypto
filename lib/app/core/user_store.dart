import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/models/user_model.dart';

// ignore: must_be_immutable
class UserStore extends NotifierStore<Exception, UserModel> {
  UserStore() : super(UserModel());
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
}
