import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/model/credential_model.dart';

class AuthRepository with Disposable {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? user;

  void authCheck() {
    _firebaseAuth.authStateChanges().listen(
      (User? user) {
        this.user = (user == null) ? null : user;
      },
    );
  }

  Future<void> authRegister(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('Senha fraca');
      } else if (e.code == 'email-already-in-use') {
        log('Email já cadastrado');
      } else {
        log('Erro desconhecido');
      }
    }
  }

  Future<void> authLogin(CredentialModel data) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: data.email!,
        password: data.password!,
      );
      _getUser();
      log('AuthRepository.authLogin: success');
    } on FirebaseAuthException catch (e) {
      log(e.code);

      if (e.code == 'user-not-found') {
        log('Usuário não encontrado');
      } else if (e.code == 'wrong-password') {
        log('Senha incorreta');
      } else {
        log('Erro desconhecido');
      }
    }
  }

  Future<void> authLogout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('Usuário não encontrado');
      } else {
        log('Erro desconhecido');
      }
    }
  }

  Future<void> _getUser() async {
    try {
      user = _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('Usuário não encontrado');
      } else {
        log('Erro desconhecido');
      }
    }
  }

  Future<void> authResetPassword(CredentialModel data) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: data.email!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('Email não cadastrado');
      } else {
        log('Erro desconhecido');
      }
    }
  }

  @override
  void dispose() {}
}
