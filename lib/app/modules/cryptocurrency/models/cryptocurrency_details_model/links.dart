import 'dart:convert';

class Links {
  List<String>? homepage;
  List<String>? blockchainSite;
  List<String>? officialForumUrl;
  List<String>? chatUrl;
  List<String>? announcementUrl;
  String? twitterScreenName;
  String? facebookUsername;
  num? bitcointalkThreadIdentifier;
  String? telegramChannelIdentifier;
  String? subredditUrl;

  Links({
    this.homepage,
    this.blockchainSite,
    this.officialForumUrl,
    this.chatUrl,
    this.announcementUrl,
    this.twitterScreenName,
    this.facebookUsername,
    this.bitcointalkThreadIdentifier,
    this.telegramChannelIdentifier,
    this.subredditUrl,
  });

  String toJson() => json.encode(toMap());

  factory Links.fromJson(String source) => Links.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'homepage': homepage,
      'blockchain_site': blockchainSite,
      'official_forum_url': officialForumUrl,
      'chat_url': chatUrl,
      'announcement_url': announcementUrl,
      'twitter_screen_name': twitterScreenName,
      'facebook_username': facebookUsername,
      'bitcointalk_thread_identifier': bitcointalkThreadIdentifier,
      'telegram_channel_identifier': telegramChannelIdentifier,
      'subreddit_url': subredditUrl,
    };
  }

  factory Links.fromMap(Map<String, dynamic> map) {
    return Links(
      homepage: List<String>.from(map['homepage']),
      blockchainSite: List<String>.from(map['blockchain_site']),
      officialForumUrl: List<String>.from(map['official_forum_url']),
      chatUrl: List<String>.from(map['chat_url']),
      announcementUrl: List<String>.from(map['announcement_url']),
      twitterScreenName: map['twitter_screen_name'],
      facebookUsername: map['facebook_username'],
      bitcointalkThreadIdentifier: map['bitcointalk_thread_identifier'],
      telegramChannelIdentifier: map['telegram_channel_identifier'],
      subredditUrl: map['subreddit_url'],
    );
  }
}
