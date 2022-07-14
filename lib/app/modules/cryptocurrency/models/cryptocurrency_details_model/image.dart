import 'dart:convert';

class Image {
  String? thumb;
  String? small;
  String? large;

  Image({this.thumb, this.small, this.large});

  factory Image.fromMap(Map<String, dynamic> data) => Image(
        thumb: data['thumb'] as String?,
        small: data['small'] as String?,
        large: data['large'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'thumb': thumb,
        'small': small,
        'large': large,
      };

  factory Image.fromJson(String data) {
    return Image.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
