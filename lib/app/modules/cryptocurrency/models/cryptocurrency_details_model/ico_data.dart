import 'dart:convert';

import 'package:collection/collection.dart';

import 'links.dart';

class IcoData {
	DateTime? icoStartDate;
	DateTime? icoEndDate;
	String? shortDesc;
	dynamic description;
	Links? links;
	String? softcapCurrency;
	String? hardcapCurrency;
	String? totalRaisedCurrency;
	dynamic softcapAmount;
	dynamic hardcapAmount;
	dynamic totalRaised;
	String? quotePreSaleCurrency;
	dynamic basePreSaleAmount;
	dynamic quotePreSaleAmount;
	String? quotePublicSaleCurrency;
	int? basePublicSaleAmount;
	double? quotePublicSaleAmount;
	String? acceptingCurrencies;
	String? countryOrigin;
	dynamic preSaleStartDate;
	dynamic preSaleEndDate;
	String? whitelistUrl;
	dynamic whitelistStartDate;
	dynamic whitelistEndDate;
	String? bountyDetailUrl;
	dynamic amountForSale;
	bool? kycRequired;
	dynamic whitelistAvailable;
	dynamic preSaleAvailable;
	bool? preSaleEnded;

	IcoData({
		this.icoStartDate, 
		this.icoEndDate, 
		this.shortDesc, 
		this.description, 
		this.links, 
		this.softcapCurrency, 
		this.hardcapCurrency, 
		this.totalRaisedCurrency, 
		this.softcapAmount, 
		this.hardcapAmount, 
		this.totalRaised, 
		this.quotePreSaleCurrency, 
		this.basePreSaleAmount, 
		this.quotePreSaleAmount, 
		this.quotePublicSaleCurrency, 
		this.basePublicSaleAmount, 
		this.quotePublicSaleAmount, 
		this.acceptingCurrencies, 
		this.countryOrigin, 
		this.preSaleStartDate, 
		this.preSaleEndDate, 
		this.whitelistUrl, 
		this.whitelistStartDate, 
		this.whitelistEndDate, 
		this.bountyDetailUrl, 
		this.amountForSale, 
		this.kycRequired, 
		this.whitelistAvailable, 
		this.preSaleAvailable, 
		this.preSaleEnded, 
	});

	factory IcoData.fromMap(Map<String, dynamic> data) => IcoData(
				icoStartDate: data['ico_start_date'] == null
						? null
						: DateTime.parse(data['ico_start_date'] as String),
				icoEndDate: data['ico_end_date'] == null
						? null
						: DateTime.parse(data['ico_end_date'] as String),
				shortDesc: data['short_desc'] as String?,
				description: data['description'] as dynamic,
				links: data['links'] == null
						? null
						: Links.fromMap(data['links'] as Map<String, dynamic>),
				softcapCurrency: data['softcap_currency'] as String?,
				hardcapCurrency: data['hardcap_currency'] as String?,
				totalRaisedCurrency: data['total_raised_currency'] as String?,
				softcapAmount: data['softcap_amount'] as dynamic,
				hardcapAmount: data['hardcap_amount'] as dynamic,
				totalRaised: data['total_raised'] as dynamic,
				quotePreSaleCurrency: data['quote_pre_sale_currency'] as String?,
				basePreSaleAmount: data['base_pre_sale_amount'] as dynamic,
				quotePreSaleAmount: data['quote_pre_sale_amount'] as dynamic,
				quotePublicSaleCurrency: data['quote_public_sale_currency'] as String?,
				basePublicSaleAmount: data['base_public_sale_amount'] as int?,
				quotePublicSaleAmount: (data['quote_public_sale_amount'] as num?)?.toDouble(),
				acceptingCurrencies: data['accepting_currencies'] as String?,
				countryOrigin: data['country_origin'] as String?,
				preSaleStartDate: data['pre_sale_start_date'] as dynamic,
				preSaleEndDate: data['pre_sale_end_date'] as dynamic,
				whitelistUrl: data['whitelist_url'] as String?,
				whitelistStartDate: data['whitelist_start_date'] as dynamic,
				whitelistEndDate: data['whitelist_end_date'] as dynamic,
				bountyDetailUrl: data['bounty_detail_url'] as String?,
				amountForSale: data['amount_for_sale'] as dynamic,
				kycRequired: data['kyc_required'] as bool?,
				whitelistAvailable: data['whitelist_available'] as dynamic,
				preSaleAvailable: data['pre_sale_available'] as dynamic,
				preSaleEnded: data['pre_sale_ended'] as bool?,
			);

	Map<String, dynamic> toMap() => {
				'ico_start_date': icoStartDate?.toIso8601String(),
				'ico_end_date': icoEndDate?.toIso8601String(),
				'short_desc': shortDesc,
				'description': description,
				'links': links?.toMap(),
				'softcap_currency': softcapCurrency,
				'hardcap_currency': hardcapCurrency,
				'total_raised_currency': totalRaisedCurrency,
				'softcap_amount': softcapAmount,
				'hardcap_amount': hardcapAmount,
				'total_raised': totalRaised,
				'quote_pre_sale_currency': quotePreSaleCurrency,
				'base_pre_sale_amount': basePreSaleAmount,
				'quote_pre_sale_amount': quotePreSaleAmount,
				'quote_public_sale_currency': quotePublicSaleCurrency,
				'base_public_sale_amount': basePublicSaleAmount,
				'quote_public_sale_amount': quotePublicSaleAmount,
				'accepting_currencies': acceptingCurrencies,
				'country_origin': countryOrigin,
				'pre_sale_start_date': preSaleStartDate,
				'pre_sale_end_date': preSaleEndDate,
				'whitelist_url': whitelistUrl,
				'whitelist_start_date': whitelistStartDate,
				'whitelist_end_date': whitelistEndDate,
				'bounty_detail_url': bountyDetailUrl,
				'amount_for_sale': amountForSale,
				'kyc_required': kycRequired,
				'whitelist_available': whitelistAvailable,
				'pre_sale_available': preSaleAvailable,
				'pre_sale_ended': preSaleEnded,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [IcoData].
	factory IcoData.fromJson(String data) {
		return IcoData.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [IcoData] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! IcoData) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			icoStartDate.hashCode ^
			icoEndDate.hashCode ^
			shortDesc.hashCode ^
			description.hashCode ^
			links.hashCode ^
			softcapCurrency.hashCode ^
			hardcapCurrency.hashCode ^
			totalRaisedCurrency.hashCode ^
			softcapAmount.hashCode ^
			hardcapAmount.hashCode ^
			totalRaised.hashCode ^
			quotePreSaleCurrency.hashCode ^
			basePreSaleAmount.hashCode ^
			quotePreSaleAmount.hashCode ^
			quotePublicSaleCurrency.hashCode ^
			basePublicSaleAmount.hashCode ^
			quotePublicSaleAmount.hashCode ^
			acceptingCurrencies.hashCode ^
			countryOrigin.hashCode ^
			preSaleStartDate.hashCode ^
			preSaleEndDate.hashCode ^
			whitelistUrl.hashCode ^
			whitelistStartDate.hashCode ^
			whitelistEndDate.hashCode ^
			bountyDetailUrl.hashCode ^
			amountForSale.hashCode ^
			kycRequired.hashCode ^
			whitelistAvailable.hashCode ^
			preSaleAvailable.hashCode ^
			preSaleEnded.hashCode;
}
