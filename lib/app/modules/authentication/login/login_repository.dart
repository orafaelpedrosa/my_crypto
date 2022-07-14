import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mycrypto/app/modules/authentication/login/models/credential_model.dart';

class LoginRepository with Disposable {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
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

  // Future<void> authGoogle() async {
  //   final googleUser = await googleSignIn.signIn();
  //   if (googleUser == null) {
  //     throw FirebaseAuthException(
  //       message: 'Erro ao logar com o Google',
  //       code: 'google-login-error',
  //     );
  //   } else {
  //     _user = googleUser;
  //   }

  //   final googleAuth = await googleUser.authentication;

  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   await _firebaseAuth.signInWithCredential(credential);
  // }

  // Future<bool> googleLoginProcess() async {
  //   try {
  //     final googleUser = await googleSignIn.signIn();
  //     if (googleUser == null) {
  //       throw FirebaseAuthException(
  //         message: 'Erro ao logar com o Google',
  //         code: 'google-login-error',
  //       );
  //     } else {
  //       _user = googleUser;
  //     }

  //     final googleAuth = await googleUser.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     await _firebaseAuth.signInWithCredential(credential);
  //     return true;
  //   } on FirebaseAuthException catch (e) {
  //     log(e.code);
  //     if (e.code == 'user-not-found') {
  //       throw FirebaseAuthException(
  //         message: 'Usuário não encontrado',
  //         code: e.code,
  //       );
  //     } else {
  //       throw FirebaseAuthException(
  //         message: 'Erro desconhecido',
  //         code: e.code,
  //       );
  //     }
  //   }
  // }

  Future<void> googleAuth() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      User user = userCredential.user!;
      log("User name: ${user.phoneNumber}");
    } else {
      log("Erro ao logar com o Google");
    }
  }

  @override
  void dispose() {}
}
