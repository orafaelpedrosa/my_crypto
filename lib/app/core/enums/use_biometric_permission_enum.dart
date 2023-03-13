enum UseBiometricPermissionEnum { accepted, notAccepted, denied }

extension UseBiometricPermissionExtension on UseBiometricPermissionEnum {
  String get label {
    switch (this) {
      case UseBiometricPermissionEnum.accepted:
        return 'accepted';
      case UseBiometricPermissionEnum.notAccepted:
        return 'notAccepted';
      case UseBiometricPermissionEnum.denied:
        return 'denied';
      default:
        return toString();
    }
  }
}

UseBiometricPermissionEnum? useBiometricPermissionFromDevice(
    String? permission) {
  switch (permission) {
    case 'accepted':
      return UseBiometricPermissionEnum.accepted;
    case 'notAccepted':
      return UseBiometricPermissionEnum.notAccepted;
    case 'denied':
      return UseBiometricPermissionEnum.denied;
    default:
      return UseBiometricPermissionEnum.notAccepted;
  }
}

String useBiometricPermissionFromJson(UseBiometricPermissionEnum? permission) {
  switch (permission) {
    case UseBiometricPermissionEnum.accepted:
      return 'accepted';
    case UseBiometricPermissionEnum.notAccepted:
      return 'notAccepted';
    case UseBiometricPermissionEnum.denied:
      return 'denied';
    default:
      return 'notAccepted';
  }
}
