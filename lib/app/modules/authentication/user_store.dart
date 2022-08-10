import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_triple/flutter_triple.dart';

// ignore: must_be_immutable
class UserStore extends NotifierStore<Exception, bool> {
  UserStore() : super(false);
  User? user;

  Future<void> getUser() async {
    user = FirebaseAuth.instance.currentUser!;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> stateUser() async {
    return FirebaseAuth.instance.currentUser != null;
  }
}
