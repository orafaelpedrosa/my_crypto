import 'dart:convert';

class Description {
  String? en;
  String? pt;

  Description({this.en});

  factory Description.fromMap(Map<String, dynamic> data) => Description(
        en: data['en'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'en': en,
      };

  factory Description.fromJson(String data) {
    return Description.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
