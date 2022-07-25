import 'dart:convert';

class ConvertedVolume {
  num? btc;
  num? eth;
  num? usd;
  
  ConvertedVolume({
    this.btc,
    this.eth,
    this.usd,
  });

  Map<String, dynamic> toMap() {
    return {
      'btc': btc,
      'eth': eth,
      'usd': usd,
    };
  }

  factory ConvertedVolume.fromMap(Map<String, dynamic> map) {
    return ConvertedVolume(
      btc: map['btc'] as num?,
      eth: map['eth'] as num?,
      usd: map['usd'] as num?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConvertedVolume.fromJson(String source) => ConvertedVolume.fromMap(json.decode(source));
}
