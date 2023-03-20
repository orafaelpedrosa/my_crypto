import 'dart:convert';

import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';

class UserPreferenceModel {
  String? language;
  String? vsCurrency;
  UseBiometricPermissionEnum hasBiometrics;
  bool? hasDarkMode;
  bool? acceptTerms;

  UserPreferenceModel({
    this.language,
    this.vsCurrency,
    this.hasBiometrics = UseBiometricPermissionEnum.notAccepted,
    this.hasDarkMode,
    this.acceptTerms,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (language != null) {
      result.addAll({'language': language});
    }
    if (vsCurrency != null) {
      result.addAll({'vs_currency': vsCurrency});
    }
    result.addAll({'has_biometric': hasBiometrics.label});
    if (hasDarkMode != null) {
      result.addAll({'hasDarkMode': hasDarkMode});
    }
    if (acceptTerms != null) {
      result.addAll({'acceptTerms': acceptTerms});
    }

    return result;
  }

  factory UserPreferenceModel.fromMap(Map<String, dynamic> map) {
    return UserPreferenceModel(
      language: map['language'],
      vsCurrency: map['vs_currency'],
      hasBiometrics: UseBiometricPermissionEnum.notAccepted,
      hasDarkMode: map['hasDarkMode'],
      acceptTerms: map['acceptTerms'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPreferenceModel.fromJson(String source) =>
      UserPreferenceModel.fromMap(json.decode(source));
}
