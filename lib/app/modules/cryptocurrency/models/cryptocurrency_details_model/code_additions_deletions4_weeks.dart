import 'dart:convert';

import 'package:collection/collection.dart';

class CodeAdditionsDeletions4Weeks {
	int? additions;
	int? deletions;

	CodeAdditionsDeletions4Weeks({this.additions, this.deletions});

	factory CodeAdditionsDeletions4Weeks.fromMap(Map<String, dynamic> data) {
		return CodeAdditionsDeletions4Weeks(
			additions: data['additions'] as int?,
			deletions: data['deletions'] as int?,
		);
	}



	Map<String, dynamic> toMap() => {
				'additions': additions,
				'deletions': deletions,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CodeAdditionsDeletions4Weeks].
	factory CodeAdditionsDeletions4Weeks.fromJson(String data) {
		return CodeAdditionsDeletions4Weeks.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [CodeAdditionsDeletions4Weeks] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! CodeAdditionsDeletions4Weeks) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => additions.hashCode ^ deletions.hashCode;
}
