import 'dart:convert';

import 'package:collection/collection.dart';

import 'converted_last.dart';
import 'converted_volume.dart';
import 'market.dart';

class Ticker {
	String? base;
	String? target;
	Market? market;
	double? last;
	double? volume;
	ConvertedLast? convertedLast;
	ConvertedVolume? convertedVolume;
	String? trustScore;
	double? bidAskSpreadPercentage;
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

	factory Ticker.fromMap(Map<String, dynamic> data) => Ticker(
				base: data['base'] as String?,
				target: data['target'] as String?,
				market: data['market'] == null
						? null
						: Market.fromMap(data['market'] as Map<String, dynamic>),
				last: (data['last'] as num?)?.toDouble(),
				volume: (data['volume'] as num?)?.toDouble(),
				convertedLast: data['converted_last'] == null
						? null
						: ConvertedLast.fromMap(data['converted_last'] as Map<String, dynamic>),
				convertedVolume: data['converted_volume'] == null
						? null
						: ConvertedVolume.fromMap(data['converted_volume'] as Map<String, dynamic>),
				trustScore: data['trust_score'] as String?,
				bidAskSpreadPercentage: (data['bid_ask_spread_percentage'] as num?)?.toDouble(),
				timestamp: data['timestamp'] as String?,
				lastTradedAt: data['last_traded_at'] as String?,
				lastFetchAt: data['last_fetch_at'] as String?,
				isAnomaly: data['is_anomaly'] as bool?,
				isStale: data['is_stale'] as bool?,
				tradeUrl: data['trade_url'] as String?,
				tokenInfoUrl: data['token_info_url'] as String?,
				coinId: data['coin_id'] as String?,
				targetCoinId: data['target_coin_id'] as String?,
			);

	Map<String, dynamic> toMap() => {
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

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Ticker].
	factory Ticker.fromJson(String data) {
		return Ticker.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Ticker] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Ticker) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			base.hashCode ^
			target.hashCode ^
			market.hashCode ^
			last.hashCode ^
			volume.hashCode ^
			convertedLast.hashCode ^
			convertedVolume.hashCode ^
			trustScore.hashCode ^
			bidAskSpreadPercentage.hashCode ^
			timestamp.hashCode ^
			lastTradedAt.hashCode ^
			lastFetchAt.hashCode ^
			isAnomaly.hashCode ^
			isStale.hashCode ^
			tradeUrl.hashCode ^
			tokenInfoUrl.hashCode ^
			coinId.hashCode ^
			targetCoinId.hashCode;
}
