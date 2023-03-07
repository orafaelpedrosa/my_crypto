import 'dart:convert';

import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';

class UserPreferenceModel {
  String? language;
  String? vsCurrency;
  UseBiometricPermissionEnum hasBiometric;
  bool? hasDarkMode;
  bool? acceptTerms;

  UserPreferenceModel({
    this.language,
    this.vsCurrency,
    this.hasBiometric = UseBiometricPermissionEnum.notAccepted,
    this.hasDarkMode,
    this.acceptTerms,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (language != null) {
      result.addAll({'language': language});
    }
    if (vsCurrency != null) {
      result.addAll({'vsCurrency': vsCurrency});
    }
    result.addAll({'hasBiometric': hasBiometric.label});
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
      vsCurrency: map['vsCurrency'],
      hasBiometric: UseBiometricPermissionEnum.notAccepted,
      hasDarkMode: map['hasDarkMode'],
      acceptTerms: map['acceptTerms'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPreferenceModel.fromJson(String source) =>
      UserPreferenceModel.fromMap(json.decode(source));
}
