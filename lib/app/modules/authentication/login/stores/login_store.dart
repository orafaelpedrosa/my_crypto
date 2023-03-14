import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/authentication/auth_check_store.dart';
import 'package:mycrypto/app/modules/authentication/login/models/credential_model.dart';
import 'package:mycrypto/app/modules/authentication/login/login_repository.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/obscure_store.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';

// ignore: must_be_immutable
class LoginStore extends NotifierStore<FirebaseAuthException, CredentialModel> {
  LoginStore()
      : super(
          CredentialModel(),
        );

  final LoginRepository _loginRepository = Modular.get<LoginRepository>();
  final ObscureStore obscureStore = Modular.get<ObscureStore>();
  final AuthCheckStore _authCheckStore = Modular.get<AuthCheckStore>();
  UserStore userStore = Modular.get<UserStore>();

  void updateForm(CredentialModel form) {
    update(CredentialModel.fromJson(form.toJson()));
  }

  Future<void> authLogin(CredentialModel data) async {
    setLoading(true);
    await _loginRepository.authLogin(data).then((value) async {
      _authCheckStore.updateState(true);
      await userStore.getUser();
      setLoading(false);
    }).catchError(
      (error) {
        setLoading(false);
        throw error;
      },
    );
  }

  Future<void> authLogout() async {
    setLoading(true);
    await _loginRepository.authLogout().then((value) {
      Modular.to.pushReplacementNamed('/login/');
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
    await _loginRepository.authResetPassword(email).then((value) async {
      setLoading(false);
    }).catchError(
      (error) {
        setLoading(false);
        throw error;
      },
    );
  }

  Future<void> authGoogle() async {
    setLoading(true);
    await _loginRepository.googleAuth().then((value) async {
      await userStore.getUser();
      setLoading(false);
    }).catchError(
      (error) {
        setLoading(false);
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
