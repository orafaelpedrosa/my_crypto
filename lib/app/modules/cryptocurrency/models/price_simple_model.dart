import 'dart:convert';

class PriceSimpleModel {
  String? id;
  double? usd;
  double? brl;

  PriceSimpleModel({
    this.id,
    this.usd,
    this.brl,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (usd != null) {
      result.addAll({'usd': usd});
    }
    if (brl != null) {
      result.addAll({'brl': brl});
    }

    return result;
  }

  factory PriceSimpleModel.fromMap(Map<String, dynamic> map) {
    return PriceSimpleModel(
      id: map['id'],
      usd: map['usd']?.toDouble(),
      brl: map['brl']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceSimpleModel.fromJson(String source) =>
      PriceSimpleModel.fromMap(json.decode(source));
}
