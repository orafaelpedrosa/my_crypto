import 'dart:convert';

import 'package:collection/collection.dart';

class PublicInterestStats {
	int? alexaRank;
	dynamic bingMatches;

	PublicInterestStats({this.alexaRank, this.bingMatches});

	factory PublicInterestStats.fromMap(Map<String, dynamic> data) {
		return PublicInterestStats(
			alexaRank: data['alexa_rank'] as int?,
			bingMatches: data['bing_matches'] as dynamic,
		);
	}



	Map<String, dynamic> toMap() => {
				'alexa_rank': alexaRank,
				'bing_matches': bingMatches,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PublicInterestStats].
	factory PublicInterestStats.fromJson(String data) {
		return PublicInterestStats.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [PublicInterestStats] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! PublicInterestStats) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => alexaRank.hashCode ^ bingMatches.hashCode;
}
