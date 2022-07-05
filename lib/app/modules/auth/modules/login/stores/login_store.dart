import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/model/credential_model.dart';
import 'package:mycrypto/app/core/repositories/auth_repository.dart';
import 'package:mycrypto/app/modules/auth/modules/login/stores/obscure_store.dart';

class LoginStore extends NotifierStore<FirebaseAuthException, CredentialModel> {
  LoginStore()
      : super(
          CredentialModel(),
        );

  final AuthRepository _authRepository = Modular.get<AuthRepository>();
  final ObscureStore obscureStore = Modular.get<ObscureStore>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? userCurrent;

  void authService() {
    _authCheck();
  }

  void _authCheck() {
    setLoading(true);
    _firebaseAuth.authStateChanges().listen(
      (User? user) {
        this.userCurrent = (user == null) ? null : user;
        setLoading(false);
      },
    );
  }

  _getUser() {
    userCurrent = _firebaseAuth.currentUser;
  }

  void updateForm(CredentialModel form) {
    update(CredentialModel.fromJson(form.toJson()));
  }

  Future<void> authLogin(CredentialModel data) async {
    await _authRepository.authLogin(data).then((value) {
      _getUser();
    }).catchError(
      (error) {
        throw error;
      },
    );
  }

  Future<void> authLogout() async {
    setLoading(true);
    await _authRepository.authLogout().then((value) {
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
    await _authRepository.authResetPassword(email).then((value) {
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

  Future<void> authRegister(CredentialModel data) async {
    setLoading(true);
    await _authRepository
        .authRegister(data.email!, data.password!)
        .then((value) {
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
