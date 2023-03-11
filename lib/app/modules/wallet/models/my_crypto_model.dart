import 'dart:convert';

class MyCryptoModel {
  String? id;
  String? name;
  String? symbol;
  num? amount;
  num? averagePrice;
  num? currentPrice;
  num? totalValue;
  num? profit;
  num? profitPercentage;

  MyCryptoModel({
    this.id,
    this.name,
    this.symbol,
    this.amount,
    this.averagePrice,
    this.currentPrice,
    this.totalValue,
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
    if (amount != null) {
      result.addAll({'amount': amount});
    }
    if (averagePrice != null) {
      result.addAll({'average_price': averagePrice});
    }
    if (currentPrice != null) {
      result.addAll({'current_price': currentPrice});
    }
    if (totalValue != null) {
      result.addAll({'total_value': totalValue});
    }
    if (profit != null) {
      result.addAll({'profit': profit});
    }
    if (profitPercentage != null) {
      result.addAll({'profit_percentage': profitPercentage});
    }

    return result;
  }

  factory MyCryptoModel.fromMap(Map<String, dynamic> map) {
    return MyCryptoModel(
      id: map['id'],
      name: map['name'],
      symbol: map['symbol'],
      amount: map['amount'],
      averagePrice: map['average_price'],
      currentPrice: map['current_price'],
      totalValue: map['total_value'],
      profit: map['profit'],
      profitPercentage: map['profit_percentage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyCryptoModel.fromJson(String source) =>
      MyCryptoModel.fromMap(json.decode(source));
}
