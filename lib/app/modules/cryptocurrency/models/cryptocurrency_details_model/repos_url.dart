import 'dart:convert';

class ReposUrl {
  List<String>? github;
  List<String>? bitbucket;

  ReposUrl({this.github, this.bitbucket});

  factory ReposUrl.fromMap(Map<String, dynamic> data) => ReposUrl(
        github: data['github'] as List<String>?,
        bitbucket: data['bitbucket'] as List<String>?,
      );

  Map<String, dynamic> toMap() => {
        'github': github,
        'bitbucket': bitbucket,
      };

  factory ReposUrl.fromJson(String data) {
    return ReposUrl.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
