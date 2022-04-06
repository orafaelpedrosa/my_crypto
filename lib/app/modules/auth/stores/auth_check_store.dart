import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

// ignore: must_be_immutable
class AuthCheckStore extends NotifierStore<Exception, bool> with Disposable {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  AuthCheckStore() : super(false) {
    _authCheck();
  }

  void _authCheck() {
    setLoading(true);
    _auth.authStateChanges().listen(
      (User? user) {
        this.user = (user == null) ? null : user;
        setLoading(false);
      },
    );
  }

  Future<void> register(String email, String password) async {
    setLoading(true);
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setError(Exception('Senha fraca'));
      } else if (e.code == 'email-already-in-use') {
        setError(Exception('Email já cadastrado'));
      } else {
        setError(Exception('Erro desconhecido'));
      }
    }
    setLoading(false);
  }

  _getUser() {
    user = _auth.currentUser;
    update(true);
  }

  Future<void> login(String email, String password) async {
    setLoading(true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _getUser();
      update(true);
      log('Logado');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setError(Exception('Email não cadastrado'));
        log('Email não cadastrado');
      } else if (e.code == 'wrong-password') {
        setError(Exception('Senha incorreta'));
      } else {
        setError(Exception('Erro desconhecido'));
      }
    }
    setLoading(false);
  }

  logout() async {
    setLoading(true);
    await _auth.signOut();
    _getUser();
    update(false);
    setLoading(true);
  }

  @override
  void dispose() {}
}
