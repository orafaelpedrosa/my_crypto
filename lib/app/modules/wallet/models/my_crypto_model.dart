import 'dart:convert';

class MyCryptoModel {
  String? id;
  String? name;
  String? symbol;
  String? lastUpdate;
  num? amount;
  num? averagePrice;
  num? currentPrice;
  num? profit;
  num? profitPercentage;

  MyCryptoModel({
    this.id,
    this.name,
    this.symbol,
    this.lastUpdate,
    this.amount,
    this.averagePrice,
    this.currentPrice,
    this.profit,
    this.profitPercentage,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (symbol != null) {
      result.addAll({'symbol': symbol});
    }
    if (lastUpdate != null) {
      result.addAll({'lastUpdate': lastUpdate});
    }
    if (amount != null) {
      result.addAll({'amount': amount});
    }
    if (averagePrice != null) {
      result.addAll({'averagePrice': averagePrice});
    }
    if (currentPrice != null) {
      result.addAll({'currentPrice': currentPrice});
    }
    if (profit != null) {
      result.addAll({'profit': profit});
    }
    if (profitPercentage != null) {
      result.addAll({'profitPercentage': profitPercentage});
    }

    return result;
  }

  factory MyCryptoModel.fromMap(Map<String, dynamic> map) {
    return MyCryptoModel(
      id: map['id'],
      name: map['name'],
      symbol: map['symbol'],
      lastUpdate: map['lastUpdate'],
      amount: map['amount'],
      averagePrice: map['averagePrice'],
      currentPrice: map['currentPrice'],
      profit: map['profit'],
      profitPercentage: map['profitPercentage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyCryptoModel.fromJson(String source) =>
      MyCryptoModel.fromMap(json.decode(source));
}
