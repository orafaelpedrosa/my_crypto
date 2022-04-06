import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

// ignore: must_be_immutable
class AuthCheckStore extends NotifierStore<Exception, bool> with Disposable {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  AuthCheckStore() : super(false) {
    authCheck();
  }

  void authCheck() {
    setLoading(true);
    _auth.authStateChanges().listen(
      (User? user) {
        this.user = (user == null) ? null : user;
        setLoading(false);
      },
    );
  }

  Future<void> authRegister(String email, String password) async {
    setLoading(true);
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('AuthCheckStore.authRegister: success');
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setError(Exception('Senha fraca'));
        log('Senha fraca');
      } else if (e.code == 'email-already-in-use') {
        setError(Exception('Email já cadastrado'));
        log('Email já cadastrado');
      } else {
        setError(Exception('Erro desconhecido'));
        log('Erro desconhecido');
      }
    }
    setLoading(false);
  }

  _getUser() {
    user = _auth.currentUser;
    update(true);
  }

  Future<void> authLogin(String email, String password) async {
    setLoading(true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('AuthCheckStore.authLogin: success');
      _getUser();
      update(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setError(Exception('Email não cadastrado'));
        log('Email não cadastrado');
      } else if (e.code == 'wrong-password') {
        setError(Exception('Senha incorreta'));
        log('Senha incorreta');
      } else {
        setError(Exception('Erro desconhecido'));
        log('Erro desconhecido');
      }
    }
    setLoading(false);
  }

  Future<void> authLogout() async {
    setLoading(true);
    await _auth.signOut();
    _getUser();
    update(false);
    setLoading(false);
  }

  Future<void> authResetPassword(String email) async {
    setLoading(true);
    await _auth.sendPasswordResetEmail(email: email);
    setLoading(false);
  }

  @override
  void dispose() {}
}
