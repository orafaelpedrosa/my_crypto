import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
        throw Exception('Senha fraca');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Email já cadastrado');
      } else {
        throw Exception('Erro desconhecido');
      }
    }
  }

  Future<void> authLogin(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw Exception('Senha incorreta');
      } else if (e.code == 'user-not-found') {
        throw Exception('Usuário não encontrado');
      } else {
        throw Exception('Erro desconhecido');
      }
    }
  }

  Future<void> authLogout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Usuário não encontrado');
      } else {
        throw Exception('Erro desconhecido');
      }
    }
  }

  Future<void> getUser() async {
    try {
      user = _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Usuário não encontrado');
      } else {
        throw Exception('Erro desconhecido');
      }
    }
  }

  Future<void> authResetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Email não cadastrado');
      } else {
        throw Exception('Erro desconhecido');
      }
    }
  }

  @override
  void dispose() {}
}
