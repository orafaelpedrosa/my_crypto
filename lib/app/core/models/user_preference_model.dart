import 'dart:convert';

class UserPreferenceModel {
  String? language;
  String? vsCurrency;
  bool? hasBiometric;
  bool? hasDarkMode;
  bool? acceptTerms;

  UserPreferenceModel({
    this.language,
    this.vsCurrency,
    this.hasBiometric,
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
    if (hasBiometric != null) {
      result.addAll({'hasBiometric': hasBiometric});
    }
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
      hasBiometric: map['hasBiometric'],
      hasDarkMode: map['hasDarkMode'],
      acceptTerms: map['acceptTerms'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPreferenceModel.fromJson(String source) =>
      UserPreferenceModel.fromMap(json.decode(source));
}
