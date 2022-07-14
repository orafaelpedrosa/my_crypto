import 'dart:convert';

import 'package:collection/collection.dart';

class Market {
	String? name;
	String? identifier;
	bool? hasTradingIncentive;

	Market({this.name, this.identifier, this.hasTradingIncentive});

	factory Market.fromMap(Map<String, dynamic> data) => Market(
				name: data['name'] as String?,
				identifier: data['identifier'] as String?,
				hasTradingIncentive: data['has_trading_incentive'] as bool?,
			);

	Map<String, dynamic> toMap() => {
				'name': name,
				'identifier': identifier,
				'has_trading_incentive': hasTradingIncentive,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Market].
	factory Market.fromJson(String data) {
		return Market.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Market] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Market) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			name.hashCode ^
			identifier.hashCode ^
			hasTradingIncentive.hashCode;
}
