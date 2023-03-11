import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterRepository with Disposable {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> authRegister(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (e.code == 'weak-password') {
        throw FirebaseAuthException(
          message: 'Senha fraca',
          code: e.code,
        );
      } else if (e.code == 'email-already-in-use') {
        throw FirebaseAuthException(
          message: 'Email já cadastrado',
          code: e.code,
        );
      } else {
        throw FirebaseAuthException(
          message: 'Erro desconhecido',
          code: e.code,
        );
      }
    }
  }

  Future<void> setAcceptTerms(bool value) async {
    log('setAcceptTermsRepository $value');
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser?.uid)
          .set({'acceptTerms': value});
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _firebaseAuth = FirebaseAuth.instance;
  }
}
