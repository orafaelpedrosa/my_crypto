import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/model/credential_model.dart';
import 'package:mycrypto/app/modules/auth/auth_repository.dart';

class LoginStore extends NotifierStore<Exception, CredentialModel> {
  LoginStore()
      : super(
          CredentialModel(
            email: 'orafaelpedrosa@outlook.com',
            password: 'aezakmi',
            // email: '',
            // password: '',
          ),
        ) {
    user = _authRepository.user;
  }

  final AuthRepository _authRepository = Modular.get<AuthRepository>();
  User? user;

  void updateForm(CredentialModel form) {
    update(CredentialModel.fromJson(form.toJson()));
  }

  Future<void> authLogin(CredentialModel data) async {
    setLoading(true);
    await _authRepository.authLogin(data).then((value) {
      setLoading(false);
    }).catchError(
      (error) {
        setLoading(false);
        setError(error);
        throw error;
      },
    );
  }

  Future<void> resetPassword(String email) async {
    setLoading(true);
    await _authRepository.authResetPassword(email).then((value) {
      setLoading(false);
    }).catchError(
      (error) {
        setLoading(false);
        setError(error);
        throw error;
      },
    );
  }

  Future<void> authCheck() async {
    setLoading(true);
    _authRepository.authCheck();
    setLoading(false);
  }

  bool get isDisable {
    return state.password == null ||
        state.email == null ||
        (state.password != null && state.password!.length < 3) ||
        (state.email != null && state.email!.length < 3);
  }
}
