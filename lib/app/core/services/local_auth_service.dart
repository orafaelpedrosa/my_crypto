import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

// ignore: avoid_classes_with_only_static_members
class LocalAuthService {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return _auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  static Future<BiometricType> getBiometricType() async {
    return _auth.getAvailableBiometrics().then(
      (value) {
        if (value.contains(BiometricType.face)) {
          return BiometricType.face;
        } else if (value.contains(BiometricType.fingerprint)) {
          return BiometricType.fingerprint;
        } else if (value.contains(BiometricType.iris)) {
          return BiometricType.iris;
        } else {
          return BiometricType.strong;
        }
      },
    );
  }

  static Future<bool> canAuthenticateUser() async {
    return await hasBiometrics() || await _auth.isDeviceSupported();
  }

  static Future<bool> authenticate() async {
    final canAuthenticate = await canAuthenticateUser();
    if (!canAuthenticate) return false;
    try {
      return _auth.authenticate(
        localizedReason: 'Utilize sua biometria para entrar',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Oops! Autenticação por biometria requerida!',
            biometricHint: 'Faça a autenticação',
            biometricSuccess: 'Autenticação realizada com sucesso!',
          ),
        ],
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
    } on PlatformException {
      return false;
    }
  }
}
