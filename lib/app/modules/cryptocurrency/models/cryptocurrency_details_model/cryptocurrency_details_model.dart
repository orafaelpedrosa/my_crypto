import 'dart:convert';

import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/community_data.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/description.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/image.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/links.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/market_data.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/ticker.dart';

class CryptocurrencyDetailsModel {
  String? id;
  String? symbol;
  String? name;
  num? blockTimeInMinutes;
  String? hashingAlgorithm;
  List<String>? categories;
  Description? description;
  Links? links;
  Image? image;
  String? countryOrigin;
  String? genesisDate;
  num? sentimentVotesUpPercentage;
  num? sentimentVotesDownPercentage;
  num? marketCapRank;
  num? coingeckoRank;
  num? coingeckoScore;
  num? developerScore;
  num? communityScore;
  num? liquidityScore;
  num? publicnumerestScore;
  MarketData? marketData;
  CommunityData? communityData;
  DateTime? lastUpdated;
  List<Ticker>? tickers;
  double? priceChangePercente;

  CryptocurrencyDetailsModel({
    this.id,
    this.symbol,
    this.name,
    this.blockTimeInMinutes,
    this.hashingAlgorithm,
    this.categories,
    this.description,
    this.links,
    this.image,
    this.countryOrigin,
    this.genesisDate,
    this.sentimentVotesUpPercentage,
    this.sentimentVotesDownPercentage,
    this.marketCapRank,
    this.coingeckoRank,
    this.coingeckoScore,
    this.developerScore,
    this.communityScore,
    this.liquidityScore,
    this.publicnumerestScore,
    this.marketData,
    this.communityData,
    this.lastUpdated,
    this.tickers,
    this.priceChangePercente,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'block_time_in_minutes': blockTimeInMinutes,
      'hashing_algorithm': hashingAlgorithm,
      'categories': categories?.toList(),
      'description': description?.toMap(),
      'links': links?.toMap(),
      'image': image?.toMap(),
      'country_origin': countryOrigin,
      'genesis_date': genesisDate,
      'sentiment_votes_up_percentage': sentimentVotesUpPercentage,
      'sentiment_votes_down_percentage': sentimentVotesDownPercentage,
      'market_cap_rank': marketCapRank,
      'coingecko_rank': coingeckoRank,
      'coingecko_score': coingeckoScore,
      'developer_score': developerScore,
      'community_score': communityScore,
      'liquidity_score': liquidityScore,
      'public_interest_score': publicnumerestScore,
      'market_data': marketData?.toMap(),
      'community_data': communityData?.toMap(),
      'last_updated': lastUpdated?.toIso8601String(),
      'tickers': tickers?.map((x) => x.toMap()).toList(),
    };
  }

  factory CryptocurrencyDetailsModel.fromMap(Map<String, dynamic> map) {
    return CryptocurrencyDetailsModel(
      id: map['id'],
      symbol: map['symbol'],
      name: map['name'],
      blockTimeInMinutes: map['blockTimeInMinutes'],
      hashingAlgorithm: map['hashingAlgorithm'],
      categories: map['categories']?.cast<String>(),
      description: map['description'] != null
          ? Description.fromMap(map['description'])
          : null,
      links: map['links'] != null ? Links.fromMap(map['links']) : null,
      image: map['image'] != null ? Image.fromMap(map['image']) : null,
      countryOrigin: map['country_origin'],
      genesisDate: map['genesis_date'],
      sentimentVotesUpPercentage: map['sentiment_votes_up_percentage'],
      sentimentVotesDownPercentage: map['sentiment_votes_down_percentage'],
      marketCapRank: map['market_cap_rank'],
      coingeckoRank: map['coingecko_rank'],
      coingeckoScore: map['coingecko_score'],
      developerScore: map['developer_score'],
      communityScore: map['community_score'],
      liquidityScore: map['liquidity_score'],
      publicnumerestScore: map['public_interest_score'],
      marketData: map['market_data'] != null
          ? MarketData.fromMap(map['market_data'])
          : null,
      communityData: map['community_data'] != null
          ? CommunityData.fromMap(map['community_data'])
          : null,
      lastUpdated: map['last_updated'] != null
          ? DateTime.parse(map['last_updated'])
          : null,
      tickers: map['tickers'] != null
          ? List<Ticker>.from(map['tickers']?.map((x) => Ticker.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CryptocurrencyDetailsModel.fromJson(String source) =>
      CryptocurrencyDetailsModel.fromMap(json.decode(source));
}
