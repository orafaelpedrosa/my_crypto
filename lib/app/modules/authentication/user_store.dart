import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_triple/flutter_triple.dart';

// ignore: must_be_immutable
class UserStore extends NotifierStore<Exception, bool> {
  UserStore() : super(false);
  User? user;

  Future<void> getUser() async {
    user = FirebaseAuth.instance.currentUser!;
    log('User UID: ${user!.uid}');
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static bool stateUser() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
