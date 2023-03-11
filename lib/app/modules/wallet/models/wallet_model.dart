import 'dart:convert';

import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';

class WalletModel {
  String? lastUpdate;
  List<MyCryptoModel>? cryptocurrencies;
  num? totalValue;
  num? totalProfit;
  num? totalProfitPercentage;

  WalletModel({
    this.lastUpdate,
    this.cryptocurrencies,
    this.totalValue,
    this.totalProfit,
    this.totalProfitPercentage,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (lastUpdate != null) {
      result.addAll({'last_update': lastUpdate});
    }
    if (cryptocurrencies != null) {
      result.addAll({
        'cryptocurrencies': cryptocurrencies!.map((x) => x.toMap()).toList()
      });
    }
    if (totalValue != null) {
      result.addAll({'total_value': totalValue});
    }
    if (totalProfit != null) {
      result.addAll({'total_profit': totalProfit});
    }
    if (totalProfitPercentage != null) {
      result.addAll({'total_profit_percentage': totalProfitPercentage});
    }

    return result;
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      lastUpdate: map['last_update'],
      cryptocurrencies: map['cryptocurrencies'] != null
          ? List<MyCryptoModel>.from(
              map['cryptocurrencies']?.map((x) => MyCryptoModel.fromMap(x)))
          : null,
      totalValue: map['total_value'],
      totalProfit: map['total_profit'],
      totalProfitPercentage: map['total_profit_percentage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) =>
      WalletModel.fromMap(json.decode(source));
}
