import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';
import 'package:mycrypto/app/core/services/preferences_service.dart';
import 'package:mycrypto/app/core/stores/use_biometric_store.dart';

class AuthCheckStore extends NotifierStore<PlatformException, bool> {
  AuthCheckStore() : super(false);
  final UseBiometricStore _useBiometricStore = Modular.get();

  Future<void> checkLocalAuth() async {
    setLoading(true);

    // Instância do Firebase
    final _authFirebase = FirebaseAuth.instance;

    // Verifica se o celular tem biometria
    final isLocalAuthAvailable =
        await _useBiometricStore.isBiometricAvailable();

    // Verifica se o usuário já aceitou ou não a biometria
    final hasBiometrics = await PreferencesService.getHasBiometrics();

    // Verifica se o dispositivo tem biometria e se o usuário já aceitou
    final hasBiometricsAvailable = isLocalAuthAvailable &&
        await _useBiometricStore.hasBiometricsAvailable();

    setLoading(false);

    if (_authFirebase.currentUser == null) {
      log('teste 1');
      Modular.to.pushReplacementNamed('/login/');
    } else if (!_authFirebase.currentUser!.emailVerified) {
      log('teste 2');
      Modular.to.pushReplacementNamed('/login/');
    } else if (hasBiometricsAvailable &&
        hasBiometrics == UseBiometricPermissionEnum.accepted) {
      log('teste 3');
      final isAuthenticated = await _useBiometricStore.authenticate();
      if (isAuthenticated) {
        log('teste 4');
        Modular.to.pushReplacementNamed('/home/');
      } else {
        log('teste 5');
        update(true);
      }
    } else {
      log('teste 6');
      Modular.to.pushReplacementNamed('/home/');
    }
  }

  void updateState(bool value) {
    update(value);
  }
}
