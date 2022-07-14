import 'dart:convert';

import 'package:collection/collection.dart';

import 'code_additions_deletions4_weeks.dart';

class DeveloperData {
	int? forks;
	int? stars;
	int? subscribers;
	int? totalIssues;
	int? closedIssues;
	int? pullRequestsMerged;
	int? pullRequestContributors;
	CodeAdditionsDeletions4Weeks? codeAdditionsDeletions4Weeks;
	int? commitCount4Weeks;
	List<dynamic>? last4WeeksCommitActivitySeries;

	DeveloperData({
		this.forks, 
		this.stars, 
		this.subscribers, 
		this.totalIssues, 
		this.closedIssues, 
		this.pullRequestsMerged, 
		this.pullRequestContributors, 
		this.codeAdditionsDeletions4Weeks, 
		this.commitCount4Weeks, 
		this.last4WeeksCommitActivitySeries, 
	});

	factory DeveloperData.fromMap(Map<String, dynamic> data) => DeveloperData(
				forks: data['forks'] as int?,
				stars: data['stars'] as int?,
				subscribers: data['subscribers'] as int?,
				totalIssues: data['total_issues'] as int?,
				closedIssues: data['closed_issues'] as int?,
				pullRequestsMerged: data['pull_requests_merged'] as int?,
				pullRequestContributors: data['pull_request_contributors'] as int?,
				codeAdditionsDeletions4Weeks: data['code_additions_deletions_4_weeks'] == null
						? null
						: CodeAdditionsDeletions4Weeks.fromMap(data['code_additions_deletions_4_weeks'] as Map<String, dynamic>),
				commitCount4Weeks: data['commit_count_4_weeks'] as int?,
				last4WeeksCommitActivitySeries: data['last_4_weeks_commit_activity_series'] as List<dynamic>?,
			);

	Map<String, dynamic> toMap() => {
				'forks': forks,
				'stars': stars,
				'subscribers': subscribers,
				'total_issues': totalIssues,
				'closed_issues': closedIssues,
				'pull_requests_merged': pullRequestsMerged,
				'pull_request_contributors': pullRequestContributors,
				'code_additions_deletions_4_weeks': codeAdditionsDeletions4Weeks?.toMap(),
				'commit_count_4_weeks': commitCount4Weeks,
				'last_4_weeks_commit_activity_series': last4WeeksCommitActivitySeries,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DeveloperData].
	factory DeveloperData.fromJson(String data) {
		return DeveloperData.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [DeveloperData] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! DeveloperData) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			forks.hashCode ^
			stars.hashCode ^
			subscribers.hashCode ^
			totalIssues.hashCode ^
			closedIssues.hashCode ^
			pullRequestsMerged.hashCode ^
			pullRequestContributors.hashCode ^
			codeAdditionsDeletions4Weeks.hashCode ^
			commitCount4Weeks.hashCode ^
			last4WeeksCommitActivitySeries.hashCode;
}
