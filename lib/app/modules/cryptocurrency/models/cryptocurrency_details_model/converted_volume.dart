import 'dart:convert';

import 'package:collection/collection.dart';

class ConvertedVolume {
	int? btc;
	int? eth;
	int? usd;

	ConvertedVolume({this.btc, this.eth, this.usd});

	factory ConvertedVolume.fromMap(Map<String, dynamic> data) {
		return ConvertedVolume(
			btc: data['btc'] as int?,
			eth: data['eth'] as int?,
			usd: data['usd'] as int?,
		);
	}



	Map<String, dynamic> toMap() => {
				'btc': btc,
				'eth': eth,
				'usd': usd,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ConvertedVolume].
	factory ConvertedVolume.fromJson(String data) {
		return ConvertedVolume.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [ConvertedVolume] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! ConvertedVolume) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => btc.hashCode ^ eth.hashCode ^ usd.hashCode;
}
