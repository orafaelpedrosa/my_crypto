import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';
import 'package:mycrypto/app/core/services/local_auth_service.dart';
import 'package:mycrypto/app/core/services/preferences_service.dart';

class UseBiometricStore extends Store<UseBiometricPermissionEnum> {
  UseBiometricStore() : super(UseBiometricPermissionEnum.notAccepted);
  final LocalAuthentication _auth = LocalAuthentication();

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

  void updateState(UseBiometricPermissionEnum useBiometrics) {
    update(useBiometrics);
  }

  Future<bool> isBiometricAvailable() async {
    bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    return canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
  }

  Future<UseBiometricPermissionEnum> getHasBiometrics() async {
    return PreferencesService.getHasBiometrics().then(
      (value) {
        if (value == null) return UseBiometricPermissionEnum.notAccepted;
        update(value);
        return value;
      },
    );
  }

  void setHasBiometrics(bool hasBiometrics) {
    if (hasBiometrics) {
      update(UseBiometricPermissionEnum.accepted);
      PreferencesService.setHasBiometrics(UseBiometricPermissionEnum.accepted);
    } else {
      update(UseBiometricPermissionEnum.denied);
      PreferencesService.setHasBiometrics(UseBiometricPermissionEnum.denied);
    }
  }

  Future<bool> hasBiometricsAvailable() async {
    return await LocalAuthService.hasBiometricsAvailable();
  }
}
