import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';
import 'package:mycrypto/app/core/services/preferences_service.dart';
import 'package:mycrypto/app/core/stores/use_biometric_store.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';

class AuthCheckStore extends Store<bool> {
  AuthCheckStore() : super(false);
  final UseBiometricStore _useBiometricStore = Modular.get();
  final UserStore _userStore = Modular.get();

  Future<void> checkLocalAuth() async {
    setLoading(true);

    await _userStore.getPreference();

    // Pega o usuário atual
    final User? currentUser = FirebaseAuth.instance.currentUser;

    // Verifica se o celular tem biometria
    final isLocalAuthAvailable =
        await _useBiometricStore.isBiometricAvailable();

    // Verifica se o usuário já aceitou ou não a biometria
    final hasBiometrics = await PreferencesService.getHasBiometrics();

    // Verifica se o dispositivo tem biometria e se o usuário já aceitou
    final hasBiometricsAvailable = isLocalAuthAvailable &&
        await _useBiometricStore.hasBiometricsAvailable();

    setLoading(false);
    if (currentUser == null || !currentUser.emailVerified) {
      //se não está logado ou não verificou o email, vai para a tela de login
      Modular.to.pushReplacementNamed('/login/');
    } else if (hasBiometricsAvailable &&
        hasBiometrics == UseBiometricPermissionEnum.accepted) {
      //se o usuário já aceitou a biometria, tenta autenticar
      final isAuthenticated = await _useBiometricStore.authenticate();
      if (isAuthenticated) {
        //se autenticou, vai para a home
        Modular.to.pushReplacementNamed('/home/');
      } else {
        //se não autenticou, vai para o pagina que solicita a biometria
        update(true);
      }
    } else {
      //se o usuário não aceitou a biometria e está logado, vai para a home
      Modular.to.pushReplacementNamed('/home/');
    }
  }

  Future<void> updateState(bool state) async {
    update(state);
  }
}
