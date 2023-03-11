import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/authentication/login/models/credential_model.dart';
import 'package:mycrypto/app/modules/authentication/register/register_repository.dart';

// ignore: must_be_immutable
class RegisterStore
    extends NotifierStore<FirebaseAuthException, CredentialModel> {
  RegisterStore()
      : super(
          CredentialModel(),
        );

  final RegisterRepository _registerRepository =
      Modular.get<RegisterRepository>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? userCurrent;

  _getUser() {
    userCurrent = _firebaseAuth.currentUser;
  }

  Future<void> authRegister(CredentialModel data) async {
    setLoading(true);
    await _registerRepository
        .authRegister(data.email!, data.password!)
        .then((value) {
      _getUser();
      userCurrent!.sendEmailVerification();
      setLoading(false);
    }).catchError(
      (error) {
        setLoading(false);
        throw error;
      },
    );
  }
}
