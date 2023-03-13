import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:local_auth/local_auth.dart';

class AuthCheckStore extends NotifierStore<PlatformException, bool> {
  AuthCheckStore() : super(false);
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    return canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Desbloqueie seu celular para continuar',
      );
    } on PlatformException catch (e) {
      log('$e');
      return false;
    }
  }

  void updateState(bool value) {
    update(value);
  }
}
