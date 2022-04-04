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

  @override
  void dispose() {}
}
