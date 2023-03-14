import 'dart:convert';

import 'package:mycrypto/app/core/models/user_preference_model.dart';

class UserModel {
  String? name;
  String? email;
  String? photoUrl;
  String? uid;
  String? cpf;
  UserPreferenceModel userPreference;

  UserModel({
    this.name,
    this.email,
    this.photoUrl,
    this.uid,
    this.cpf,
    required this.userPreference,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (photoUrl != null) {
      result.addAll({'photoUrl': photoUrl});
    }
    if (uid != null) {
      result.addAll({'uid': uid});
    }
    if (cpf != null) {
      result.addAll({'cpf': cpf});
    }
    result.addAll({'userPreference': userPreference.toMap()});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      uid: map['uid'],
      cpf: map['cpf'],
      userPreference: UserPreferenceModel.fromMap(map['userPreference']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
