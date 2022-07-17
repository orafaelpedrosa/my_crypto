import 'dart:convert';

import 'package:collection/collection.dart';

import 'converted_last.dart';
import 'converted_volume.dart';
import 'market.dart';

class Ticker {
	String? base;
	String? target;
	Market? market;
	num? last;
	num? volume;
	ConvertedLast? convertedLast;
	ConvertedVolume? convertedVolume;
	String? trustScore;
	num? bidAskSpreadPercentage;
	String? timestamp;
	String? lastTradedAt;
	String? lastFetchAt;
	bool? isAnomaly;
	bool? isStale;
	String? tradeUrl;
	String? tokenInfoUrl;
	String? coinId;
	String? targetCoinId;

	Ticker({
		this.base, 
		this.target, 
		this.market, 
		this.last, 
		this.volume, 
		this.convertedLast, 
		this.convertedVolume, 
		this.trustScore, 
		this.bidAskSpreadPercentage, 
		this.timestamp, 
		this.lastTradedAt, 
		this.lastFetchAt, 
		this.isAnomaly, 
		this.isStale, 
		this.tradeUrl, 
		this.tokenInfoUrl, 
		this.coinId, 
		this.targetCoinId, 
	});



  Map<String, dynamic> toMap() {
    return {
      'base': base,
      'target': target,
      'market': market?.toMap(),
      'last': last,
      'volume': volume,
      'converted_last': convertedLast?.toMap(),
      'converted_volume': convertedVolume?.toMap(),
      'trust_score': trustScore,
      'bid_ask_spread_percentage': bidAskSpreadPercentage,
      'timestamp': timestamp,
      'last_traded_at': lastTradedAt,
      'last_fetch_at': lastFetchAt,
      'is_anomaly': isAnomaly,
      'is_stale': isStale,
      'trade_url': tradeUrl,
      'token_info_url': tokenInfoUrl,
      'coin_id': coinId,
      'target_coin_id': targetCoinId,
    };
  }

  factory Ticker.fromMap(Map<String, dynamic> map) {
    return Ticker(
      base: map['base'] as String?,
      target: map['target'] as String?,
      market: map['market'] != null ? Market.fromMap(map['market']) : null,
      last: map['last'] as num?,
      volume: map['volume'] as num?,
      convertedLast: map['converted_last'] != null ? ConvertedLast.fromMap(map['converted_last']) : null,
      convertedVolume: map['converted_volume'] != null ? ConvertedVolume.fromMap(map['converted_volume']) : null,
      trustScore: map['trust_score'] as String?,
      bidAskSpreadPercentage: map['bid_ask_spread_percentage'] as num?,
      timestamp: map['timestamp'] as String?,
      lastTradedAt: map['last_traded_at'] as String?,
      lastFetchAt: map['last_fetch_at'] as String?,
      isAnomaly: map['is_anomaly'] as bool?,
      isStale: map['is_stale'] as bool?,
      tradeUrl: map['trade_url'] as String?,
      tokenInfoUrl: map['token_info_url'] as String?,
      coinId: map['coin_id'] as String?,
      targetCoinId: map['target_coin_id'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticker.fromJson(String source) => Ticker.fromMap(json.decode(source));
}
