import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/model/credential_model.dart';

class AuthRepository with Disposable {
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

  Future<void> authLogin(CredentialModel data) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: data.email!,
        password: data.password!,
      );
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (e.code == 'user-not-found') {
        throw FirebaseAuthException(
          message: 'Usuário não encontrado',
          code: e.code,
        );
      } else if (e.code == 'wrong-password') {
        throw FirebaseAuthException(
          message: 'Senha incorreta',
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

  Future<void> authLogout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (e.code == 'user-not-found') {
        throw FirebaseAuthException(
          message: 'Usuário não encontrado',
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

  Future<void> authResetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (e.code == 'user-not-found') {
        throw FirebaseAuthException(
          message: 'Usuário não encontrado',
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

  @override
  void dispose() {}
}
