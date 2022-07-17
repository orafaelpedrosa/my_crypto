import 'dart:convert';

class ConvertedLast {
  num? btc;
  num? eth;
  num? usd;
  
  ConvertedLast({
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

  factory ConvertedLast.fromMap(Map<String, dynamic> map) {
    return ConvertedLast(
      btc: map['btc'] as num?,
      eth: map['eth'] as num?,
      usd: map['usd'] as num?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConvertedLast.fromJson(String source) => ConvertedLast.fromMap(json.decode(source));
}
