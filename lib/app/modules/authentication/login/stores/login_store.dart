import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/authentication/login/models/credential_model.dart';
import 'package:mycrypto/app/modules/authentication/login/login_repository.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/obscure_store.dart';

// ignore: must_be_immutable
class LoginStore extends NotifierStore<FirebaseAuthException, CredentialModel> {
  LoginStore()
      : super(
          CredentialModel(),
        );

  final LoginRepository _loginRepository = Modular.get<LoginRepository>();
  final ObscureStore obscureStore = Modular.get<ObscureStore>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? userCurrent;

  void authService() async {
    authCheck();
  }

  void authCheck() async {
    userCurrent = await _firebaseAuth.authStateChanges().first;
  }

  _getUser() {
    userCurrent = _firebaseAuth.currentUser;
  }

  void updateForm(CredentialModel form) {
    update(CredentialModel.fromJson(form.toJson()));
  }

  Future<void> authLogin(CredentialModel data) async {
    await _loginRepository.authLogin(data).then((value) {
      _getUser();
    }).catchError(
      (error) {
        throw error;
      },
    );
  }

  Future<void> authLogout() async {
    setLoading(true);
    await _loginRepository.authLogout().then((value) {
      _getUser();
      setLoading(false);
    }).catchError(
      (error) {
        setLoading(false);
        throw error;
      },
    );
  }

  Future<void> resetPassword(String email) async {
    setLoading(true);
    await _loginRepository.authResetPassword(email).then((value) {
      _getUser();
      setLoading(false);
    }).catchError(
      (error) {
        setLoading(false);
        setError(error);
        throw error;
      },
    );
  }

  Future<void> authGoogle() async {
    setLoading(true);
    await _loginRepository.googleAuth().then((value) {
      _getUser();
      setLoading(false);
    }).catchError(
      (error) {
        log(error);
        setLoading(false);
        setError(error);
        throw error;
      },
    );
  }

  bool get isDisable {
    return state.password == null ||
        state.email == null ||
        (state.password != null && state.password!.length < 3) ||
        (state.email != null && state.email!.length < 3);
  }

  void obscurePassword() {
    obscureStore.update(!obscureStore.state);
  }
}
