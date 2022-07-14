import 'dart:convert';

import 'package:collection/collection.dart';

class ConvertedLast {
	double? btc;
	double? eth;
	double? usd;

	ConvertedLast({this.btc, this.eth, this.usd});

	factory ConvertedLast.fromMap(Map<String, dynamic> data) => ConvertedLast(
				btc: (data['btc'] as num?)?.toDouble(),
				eth: (data['eth'] as num?)?.toDouble(),
				usd: (data['usd'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toMap() => {
				'btc': btc,
				'eth': eth,
				'usd': usd,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ConvertedLast].
	factory ConvertedLast.fromJson(String data) {
		return ConvertedLast.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [ConvertedLast] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! ConvertedLast) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => btc.hashCode ^ eth.hashCode ^ usd.hashCode;
}
