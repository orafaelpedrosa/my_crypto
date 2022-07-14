import 'dart:convert';

import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/description.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/ico_data.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/image.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/market_data.dart';

class CryptocurrencyDetailsModel {
  String? id;
  String? symbol;
  String? name;
  num? blockTimeInMinutes;
  String? hashingAlgorithm;
  Description? description;
  Image? image;
  String? countryOrigin;
  String? genesisDate;
  num? sentimentVotesUpPercentage;
  num? sentimentVotesDownPercentage;
  IcoData? icoData;
  num? marketCapRank;
  num? coingeckoRank;
  num? coingeckoScore;
  num? developerScore;
  num? communityScore;
  num? liquidityScore;
  num? publicnumerestScore;
  MarketData? marketData;
  CryptocurrencyDetailsModel({
    this.id,
    this.symbol,
    this.name,
    this.blockTimeInMinutes,
    this.hashingAlgorithm,
    this.description,
    this.image,
    this.countryOrigin,
    this.genesisDate,
    this.sentimentVotesUpPercentage,
    this.sentimentVotesDownPercentage,
    this.icoData,
    this.marketCapRank,
    this.coingeckoRank,
    this.coingeckoScore,
    this.developerScore,
    this.communityScore,
    this.liquidityScore,
    this.publicnumerestScore,
    this.marketData,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'blockTimeInMinutes': blockTimeInMinutes,
      'hashingAlgorithm': hashingAlgorithm,
      'description': description?.toMap(),
      'image': image?.toMap(),
      'countryOrigin': countryOrigin,
      'genesisDate': genesisDate,
      'sentimentVotesUpPercentage': sentimentVotesUpPercentage,
      'sentimentVotesDownPercentage': sentimentVotesDownPercentage,
      'icoData': icoData?.toMap(),
      'marketCapRank': marketCapRank,
      'coingeckoRank': coingeckoRank,
      'coingeckoScore': coingeckoScore,
      'developerScore': developerScore,
      'communityScore': communityScore,
      'liquidityScore': liquidityScore,
      'publicnumerestScore': publicnumerestScore,
      'marketData': marketData?.toMap(),
    };
  }

  factory CryptocurrencyDetailsModel.fromMap(Map<String, dynamic> map) {
    return CryptocurrencyDetailsModel(
      id: map['id'],
      symbol: map['symbol'],
      name: map['name'],
      blockTimeInMinutes: map['blockTimeInMinutes'],
      hashingAlgorithm: map['hashingAlgorithm'],
      description: map['description'] != null
          ? Description.fromMap(map['description'])
          : null,
      image: map['image'] != null ? Image.fromMap(map['image']) : null,
      countryOrigin: map['countryOrigin'],
      genesisDate: map['genesisDate'],
      sentimentVotesUpPercentage: map['sentimentVotesUpPercentage'],
      sentimentVotesDownPercentage: map['sentimentVotesDownPercentage'],
      icoData: map['icoData'] != null ? IcoData.fromMap(map['icoData']) : null,
      marketCapRank: map['marketCapRank'],
      coingeckoRank: map['coingeckoRank'],
      coingeckoScore: map['coingeckoScore'],
      developerScore: map['developerScore'],
      communityScore: map['communityScore'],
      liquidityScore: map['liquidityScore'],
      publicnumerestScore: map['publicnumerestScore'],
      marketData: map['marketData'] != null
          ? MarketData.fromMap(map['marketData'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CryptocurrencyDetailsModel.fromJson(String source) =>
      CryptocurrencyDetailsModel.fromMap(json.decode(source));
}
