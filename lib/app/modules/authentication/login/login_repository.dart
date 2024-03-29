import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mycrypto/app/modules/authentication/login/models/credential_model.dart';

class LoginRepository with Disposable {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

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
      } else if (e.code == 'network-request-failed') {
        throw FirebaseAuthException(
          message: 'Sem conexão com a internet',
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
          message: 'Usuário não cadastrado',
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
          message: 'Usuário não cadastrado',
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

  Future<bool> googleAuth() async {
    try {
      final _googleUser = await _googleSignIn.signIn();
      if (_googleUser == null) {
        throw FirebaseAuthException(
          message: 'Erro ao logar com o Google',
          code: 'google-login-error',
        );
      } else {
        _user = _googleUser;
      }

      final googleAuth = await _googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential).then((value) {
        log('Logado com sucesso Google: ${value.user!.displayName}');
      });
      return true;
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (e.code == 'user-not-found') {
        throw FirebaseAuthException(
          message: 'Usuário não encontrado',
          code: e.code,
        );
      } else {
        throw FirebaseAuthException(
          message: 'Não foi possível logar com o Google',
          code: e.code,
        );
      }
    }
  }

  // Future<void> setLogAcess() async {
  //   FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   _firestore.collection('users').doc(_firebaseAuth.currentUser!.uid).set({
  //     'lastSignIn': DateTime.now(),
  //   }, SetOptions(merge: true));
  // }

  @override
  void dispose() {
    _firebaseAuth = FirebaseAuth.instance;
  }
}
