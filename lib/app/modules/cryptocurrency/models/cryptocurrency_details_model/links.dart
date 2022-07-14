import 'dart:convert';

import 'package:collection/collection.dart';

import 'repos_url.dart';

class Links {
	List<String>? homepage;
	List<String>? blockchainSite;
	List<String>? officialForumUrl;
	List<String>? chatUrl;
	List<String>? announcementUrl;
	String? twitterScreenName;
	String? facebookUsername;
	int? bitcointalkThreadIdentifier;
	String? telegramChannelIdentifier;
	String? subredditUrl;
	ReposUrl? reposUrl;

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
		this.reposUrl, 
	});

	factory Links.fromMap(Map<String, dynamic> data) => Links(
				homepage: data['homepage'] as List<String>?,
				blockchainSite: data['blockchain_site'] as List<String>?,
				officialForumUrl: data['official_forum_url'] as List<String>?,
				chatUrl: data['chat_url'] as List<String>?,
				announcementUrl: data['announcement_url'] as List<String>?,
				twitterScreenName: data['twitter_screen_name'] as String?,
				facebookUsername: data['facebook_username'] as String?,
				bitcointalkThreadIdentifier: data['bitcointalk_thread_identifier'] as int?,
				telegramChannelIdentifier: data['telegram_channel_identifier'] as String?,
				subredditUrl: data['subreddit_url'] as String?,
				reposUrl: data['repos_url'] == null
						? null
						: ReposUrl.fromMap(data['repos_url'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toMap() => {
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
				'repos_url': reposUrl?.toMap(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Links].
	factory Links.fromJson(String data) {
		return Links.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Links] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Links) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			homepage.hashCode ^
			blockchainSite.hashCode ^
			officialForumUrl.hashCode ^
			chatUrl.hashCode ^
			announcementUrl.hashCode ^
			twitterScreenName.hashCode ^
			facebookUsername.hashCode ^
			bitcointalkThreadIdentifier.hashCode ^
			telegramChannelIdentifier.hashCode ^
			subredditUrl.hashCode ^
			reposUrl.hashCode;
}
