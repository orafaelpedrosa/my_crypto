import 'dart:convert';

class CommunityData {
  num? facebookLikes;
  num? twitterFollowers;
  double? redditAveragePosts48h;
  double? redditAverageComments48h;
  num? redditSubscribers;
  num? redditAccountsActive48h;
  num? telegramChannelUserCount;

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
        facebookLikes: data['facebook_likes'] as num?,
        twitterFollowers: data['twitter_followers'] as num?,
        redditAveragePosts48h:
            (data['reddit_average_posts_48h'] as num?)?.toDouble(),
        redditAverageComments48h:
            (data['reddit_average_comments_48h'] as num?)?.toDouble(),
        redditSubscribers: data['reddit_subscribers'] as int?,
        redditAccountsActive48h: data['reddit_accounts_active_48h'] as num?,
        telegramChannelUserCount: data['telegram_channel_user_count'] as num?,
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

  factory CommunityData.fromJson(String data) {
    return CommunityData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
