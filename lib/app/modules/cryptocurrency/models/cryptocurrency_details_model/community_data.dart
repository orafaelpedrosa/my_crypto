import 'dart:convert';

import 'package:collection/collection.dart';

class CommunityData {
	dynamic facebookLikes;
	int? twitterFollowers;
	double? redditAveragePosts48h;
	double? redditAverageComments48h;
	int? redditSubscribers;
	int? redditAccountsActive48h;
	dynamic telegramChannelUserCount;

	CommunityData({
		this.facebookLikes, 
		this.twitterFollowers, 
		this.redditAveragePosts48h, 
		this.redditAverageComments48h, 
		this.redditSubscribers, 
		this.redditAccountsActive48h, 
		this.telegramChannelUserCount, 
	});

	factory CommunityData.fromMap(Map<String, dynamic> data) => CommunityData(
				facebookLikes: data['facebook_likes'] as dynamic,
				twitterFollowers: data['twitter_followers'] as int?,
				redditAveragePosts48h: (data['reddit_average_posts_48h'] as num?)?.toDouble(),
				redditAverageComments48h: (data['reddit_average_comments_48h'] as num?)?.toDouble(),
				redditSubscribers: data['reddit_subscribers'] as int?,
				redditAccountsActive48h: data['reddit_accounts_active_48h'] as int?,
				telegramChannelUserCount: data['telegram_channel_user_count'] as dynamic,
			);

	Map<String, dynamic> toMap() => {
				'facebook_likes': facebookLikes,
				'twitter_followers': twitterFollowers,
				'reddit_average_posts_48h': redditAveragePosts48h,
				'reddit_average_comments_48h': redditAverageComments48h,
				'reddit_subscribers': redditSubscribers,
				'reddit_accounts_active_48h': redditAccountsActive48h,
				'telegram_channel_user_count': telegramChannelUserCount,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CommunityData].
	factory CommunityData.fromJson(String data) {
		return CommunityData.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [CommunityData] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! CommunityData) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			facebookLikes.hashCode ^
			twitterFollowers.hashCode ^
			redditAveragePosts48h.hashCode ^
			redditAverageComments48h.hashCode ^
			redditSubscribers.hashCode ^
			redditAccountsActive48h.hashCode ^
			telegramChannelUserCount.hashCode;
}
