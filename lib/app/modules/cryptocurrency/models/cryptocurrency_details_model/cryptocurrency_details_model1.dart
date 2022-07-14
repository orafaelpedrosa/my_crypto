// import 'dart:convert';

// import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/community_data.dart';
// import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/description.dart';
// import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/developer_data.dart';
// import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/ico_data.dart';
// import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/image.dart';
// import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/links.dart';
// import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/market_data.dart';
// import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/public_interest_stats.dart';
// import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/ticker.dart';



// class CryptocurrencyDetailsModel {
// 	String? id;
// 	String? symbol;
// 	String? name;
// 	dynamic assetPlatformId;
// 	int? blockTimeInMinutes;
// 	String? hashingAlgorithm;
// 	List<dynamic>? categories;
// 	dynamic publicNotice;
// 	List<dynamic>? additionalNotices;
// 	Description? description;
// 	Links? links;
// 	Image? image;
// 	String? countryOrigin;
// 	String? genesisDate;
// 	double? sentimentVotesUpPercentage;
// 	double? sentimentVotesDownPercentage;
// 	IcoData? icoData;
// 	int? marketCapRank;
// 	int? coingeckoRank;
// 	double? coingeckoScore;
// 	double? developerScore;
// 	double? communityScore;
// 	double? liquidityScore;
// 	double? publicInterestScore;
// 	MarketData? marketData;
// 	CommunityData? communityData;
// 	DeveloperData? developerData;
// 	PublicInterestStats? publicInterestStats;
// 	List<dynamic>? statusUpdates;
// 	DateTime? lastUpdated;
// 	List<Ticker>? tickers;

// 	CryptocurrencyDetailsModel({
// 		this.id, 
// 		this.symbol, 
// 		this.name, 
// 		this.assetPlatformId, 
// 		this.blockTimeInMinutes, 
// 		this.hashingAlgorithm, 
// 		this.categories, 
// 		this.publicNotice, 
// 		this.additionalNotices, 
// 		this.description, 
// 		this.links, 
// 		this.image, 
// 		this.countryOrigin, 
// 		this.genesisDate, 
// 		this.sentimentVotesUpPercentage, 
// 		this.sentimentVotesDownPercentage, 
// 		this.icoData, 
// 		this.marketCapRank, 
// 		this.coingeckoRank, 
// 		this.coingeckoScore, 
// 		this.developerScore, 
// 		this.communityScore, 
// 		this.liquidityScore, 
// 		this.publicInterestScore, 
// 		this.marketData, 
// 		this.communityData, 
// 		this.developerData, 
// 		this.publicInterestStats, 
// 		this.statusUpdates, 
// 		this.lastUpdated, 
// 		this.tickers, 
// 	});

// 	factory CryptocurrencyDetailsModel.fromMap(Map<String, dynamic> data) {
// 		return CryptocurrencyDetailsModel(
// 			id: data['id'] as String?,
// 			symbol: data['symbol'] as String?,
// 			name: data['name'] as String?,
// 			assetPlatformId: data['asset_platform_id'] as dynamic,

// 			blockTimeInMinutes: data['block_time_in_minutes'] as int?,
// 			hashingAlgorithm: data['hashing_algorithm'] as String?,
// 			categories: data['categories'] as List<dynamic>?,
// 			publicNotice: data['public_notice'] as dynamic,
// 			additionalNotices: data['additional_notices'] as List<dynamic>?,
// 			description: data['description'] == null
// 						? null
// 						: Description.fromMap(data['description'] as Map<String, dynamic>),
// 			links: data['links'] == null
// 						? null
// 						: Links.fromMap(data['links'] as Map<String, dynamic>),
// 			image: data['image'] == null
// 						? null
// 						: Image.fromMap(data['image'] as Map<String, dynamic>),
// 			countryOrigin: data['country_origin'] as String?,
// 			genesisDate: data['genesis_date'] as String?,
// 			sentimentVotesUpPercentage: (data['sentiment_votes_up_percentage'] as num?)?.toDouble(),
// 			sentimentVotesDownPercentage: (data['sentiment_votes_down_percentage'] as num?)?.toDouble(),
// 			icoData: data['ico_data'] == null
// 						? null
// 						: IcoData.fromMap(data['ico_data'] as Map<String, dynamic>),
// 			marketCapRank: data['market_cap_rank'] as int?,
// 			coingeckoRank: data['coingecko_rank'] as int?,
// 			coingeckoScore: (data['coingecko_score'] as num?)?.toDouble(),
// 			developerScore: (data['developer_score'] as num?)?.toDouble(),
// 			communityScore: (data['community_score'] as num?)?.toDouble(),
// 			liquidityScore: (data['liquidity_score'] as num?)?.toDouble(),
// 			publicInterestScore: (data['public_interest_score'] as num?)?.toDouble(),
// 			marketData: data['market_data'] == null
// 						? null
// 						: MarketData.fromMap(data['market_data'] as Map<String, dynamic>),
// 			communityData: data['community_data'] == null
// 						? null
// 						: CommunityData.fromMap(data['community_data'] as Map<String, dynamic>),
// 			developerData: data['developer_data'] == null
// 						? null
// 						: DeveloperData.fromMap(data['developer_data'] as Map<String, dynamic>),
// 			publicInterestStats: data['public_interest_stats'] == null
// 						? null
// 						: PublicInterestStats.fromMap(data['public_interest_stats'] as Map<String, dynamic>),
// 			statusUpdates: data['status_updates'] as List<dynamic>?,
// 			lastUpdated: data['last_updated'] == null
// 						? null
// 						: DateTime.parse(data['last_updated'] as String),
// 			tickers: (data['tickers'] as List<dynamic>?)
// 						?.map((e) => Ticker.fromMap(e as Map<String, dynamic>))
// 						.toList(),
// 		);
// 	}



// 	Map<String, dynamic> toMap() => {
// 				'id': id,
// 				'symbol': symbol,
// 				'name': name,
// 				'asset_platform_id': assetPlatformId,
// 				'block_time_in_minutes': blockTimeInMinutes,
// 				'hashing_algorithm': hashingAlgorithm,
// 				'categories': categories,
// 				'public_notice': publicNotice,
// 				'additional_notices': additionalNotices,
// 				'description': description?.toMap(),
// 				'links': links?.toMap(),
// 				'image': image?.toMap(),
// 				'country_origin': countryOrigin,
// 				'genesis_date': genesisDate,
// 				'sentiment_votes_up_percentage': sentimentVotesUpPercentage,
// 				'sentiment_votes_down_percentage': sentimentVotesDownPercentage,
// 				'ico_data': icoData?.toMap(),
// 				'market_cap_rank': marketCapRank,
// 				'coingecko_rank': coingeckoRank,
// 				'coingecko_score': coingeckoScore,
// 				'developer_score': developerScore,
// 				'community_score': communityScore,
// 				'liquidity_score': liquidityScore,
// 				'public_interest_score': publicInterestScore,
// 				'market_data': marketData?.toMap(),
// 				'community_data': communityData?.toMap(),
// 				'developer_data': developerData?.toMap(),
// 				'public_interest_stats': publicInterestStats?.toMap(),
// 				'status_updates': statusUpdates,
// 				'last_updated': lastUpdated?.toIso8601String(),
// 				'tickers': tickers?.map((e) => e.toMap()).toList(),
// 			};


// 	factory CryptocurrencyDetailsModel.fromJson(String data) {
// 		return CryptocurrencyDetailsModel.fromMap(json.decode(data) as Map<String, dynamic>);
// 	}

// 	String toJson() => json.encode(toMap());


// }
