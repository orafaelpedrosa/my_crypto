import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';
import 'package:mycrypto/app/core/services/preferences_service.dart';

class UseBiometricStore
    extends NotifierStore<Exception, UseBiometricPermissionEnum> {
  UseBiometricStore() : super(UseBiometricPermissionEnum.notAccepted);

  final PreferencesService preferencesService = PreferencesService();

  void updateState(UseBiometricPermissionEnum useBiometrics) {
    update(useBiometrics);
  }

  Future<UseBiometricPermissionEnum> getHasBiometrics() async {
    return preferencesService.getHasBiometrics().then(
      (value) {
        if (value == null) return UseBiometricPermissionEnum.notAccepted;
        update(value);
        return value;
      },
    );
  }

  void changeBiometricPermission(bool hasBiometrics) {
    if (hasBiometrics) {
      update(UseBiometricPermissionEnum.accepted);
      preferencesService.setHasBiometrics(UseBiometricPermissionEnum.accepted);
    } else {
      update(UseBiometricPermissionEnum.denied);
      preferencesService.setHasBiometrics(UseBiometricPermissionEnum.denied);
    }
  }
}
