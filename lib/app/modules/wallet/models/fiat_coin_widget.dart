import 'dart:convert';

class FiatCoinModel {
  String? code;
  String? codein;
  String? name;
  String? high;
  String? low;
  String? varBid;
  String? pctChange;
  String? bid;
  String? ask;
  String? timestamp;
  String? createDate;

  FiatCoinModel({
    this.code,
    this.codein,
    this.name,
    this.high,
    this.low,
    this.varBid,
    this.pctChange,
    this.bid,
    this.ask,
    this.timestamp,
    this.createDate,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (code != null) {
      result.addAll({'code': code});
    }
    if (codein != null) {
      result.addAll({'codein': codein});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (high != null) {
      result.addAll({'high': high});
    }
    if (low != null) {
      result.addAll({'low': low});
    }
    if (varBid != null) {
      result.addAll({'varBid': varBid});
    }
    if (pctChange != null) {
      result.addAll({'pctChange': pctChange});
    }
    if (bid != null) {
      result.addAll({'bid': bid});
    }
    if (ask != null) {
      result.addAll({'ask': ask});
    }
    if (timestamp != null) {
      result.addAll({'timestamp': timestamp});
    }
    if (createDate != null) {
      result.addAll({'createDate': createDate});
    }

    return result;
  }

  factory FiatCoinModel.fromMap(Map<String, dynamic> map) {
    return FiatCoinModel(
      code: map['code'],
      codein: map['codein'],
      name: map['name'],
      high: map['high'],
      low: map['low'],
      varBid: map['varBid'],
      pctChange: map['pctChange'],
      bid: map['bid'],
      ask: map['ask'],
      timestamp: map['timestamp'],
      createDate: map['createDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FiatCoinModel.fromJson(String source) =>
      FiatCoinModel.fromMap(json.decode(source));
}
