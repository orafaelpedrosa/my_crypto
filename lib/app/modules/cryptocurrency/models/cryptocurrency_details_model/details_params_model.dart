import 'dart:convert';

class CoinIDParamsModel {
  final String id;
  final String? localization;
  final bool? tickers;
  final bool? marketData;
  final bool? communityData;
  final bool? developerData;
  final bool? sparkline7d;
  
  CoinIDParamsModel({
    required this.id,
    this.localization,
    this.tickers,
    this.marketData,
    this.communityData,
    this.developerData,
    this.sparkline7d,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'localization': localization,
      'tickers': tickers,
      'marketData': marketData,
      'communityData': communityData,
      'developerData': developerData,
      'sparkline7d': sparkline7d,
    };
  }

  factory CoinIDParamsModel.fromMap(Map<String, dynamic> map) {
    return CoinIDParamsModel(
      id: map['id'] ?? '',
      localization: map['localization'],
      tickers: map['tickers'],
      marketData: map['marketData'],
      communityData: map['communityData'],
      developerData: map['developerData'],
      sparkline7d: map['sparkline7d'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CoinIDParamsModel.fromJson(String source) => CoinIDParamsModel.fromMap(json.decode(source));
}
