import 'dart:convert';

import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/ath_date.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/price_change_percentage_in_currency.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/roi_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/sparkline_in_7d_model.dart';

class MarketData {
  PriceChangePercentageInCurrency? currentPrice;
  RoiModel? roi;
  PriceChangePercentageInCurrency? ath;
  PriceChangePercentageInCurrency? athChangePercentage;
  AthDate? athDate;
  PriceChangePercentageInCurrency? atl;
  PriceChangePercentageInCurrency? atlChangePercentage;
  AthDate? atlDate;
  PriceChangePercentageInCurrency? marketCap;
  num? marketCapRank;
  PriceChangePercentageInCurrency? totalVolume;
  PriceChangePercentageInCurrency? high24h;
  PriceChangePercentageInCurrency? low24h;
  num? priceChange24h;
  num? priceChangePercentage24h;
  num? priceChangePercentage7d;
  num? priceChangePercentage14d;
  num? priceChangePercentage30d;
  num? priceChangePercentage60d;
  num? priceChangePercentage200d;
  num? priceChangePercentage1y;
  num? marketCapChange24h;
  num? marketCapChangePercentage24h;
  PriceChangePercentageInCurrency? priceChange24hInCurrency;
  PriceChangePercentageInCurrency? priceChangePercentage1hInCurrency;
  PriceChangePercentageInCurrency? priceChangePercentage24hInCurrency;
  PriceChangePercentageInCurrency? priceChangePercentage7dInCurrency;
  PriceChangePercentageInCurrency? priceChangePercentage14dInCurrency;
  PriceChangePercentageInCurrency? priceChangePercentage30dInCurrency;
  PriceChangePercentageInCurrency? priceChangePercentage60dInCurrency;
  PriceChangePercentageInCurrency? priceChangePercentage200dInCurrency;
  PriceChangePercentageInCurrency? priceChangePercentage1yInCurrency;
  PriceChangePercentageInCurrency? marketCapChange24hInCurrency;
  PriceChangePercentageInCurrency? marketCapChangePercentage24hInCurrency;
  num? totalSupply;
  num? maxSupply;
  num? circulatingSupply;
  SparklineIn7dModel? sparkline7d;
  DateTime? lastUpdated;

  MarketData({
    this.currentPrice,
    this.roi,
    this.ath,
    this.athChangePercentage,
    this.athDate,
    this.atl,
    this.atlChangePercentage,
    this.atlDate,
    this.marketCap,
    this.marketCapRank,
    this.totalVolume,
    this.high24h,
    this.low24h,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.priceChangePercentage7d,
    this.priceChangePercentage14d,
    this.priceChangePercentage30d,
    this.priceChangePercentage60d,
    this.priceChangePercentage200d,
    this.priceChangePercentage1y,
    this.marketCapChange24h,
    this.marketCapChangePercentage24h,
    this.priceChange24hInCurrency,
    this.priceChangePercentage1hInCurrency,
    this.priceChangePercentage24hInCurrency,
    this.priceChangePercentage7dInCurrency,
    this.priceChangePercentage14dInCurrency,
    this.priceChangePercentage30dInCurrency,
    this.priceChangePercentage60dInCurrency,
    this.priceChangePercentage200dInCurrency,
    this.priceChangePercentage1yInCurrency,
    this.marketCapChange24hInCurrency,
    this.marketCapChangePercentage24hInCurrency,
    this.totalSupply,
    this.maxSupply,
    this.circulatingSupply,
    this.sparkline7d,
    this.lastUpdated,
  });

  factory MarketData.fromMap(Map<String, dynamic> data) => MarketData(
        currentPrice: data['current_price'] == null
            ? null
            : PriceChangePercentageInCurrency.fromMap(
                data['current_price'] as Map<String, dynamic>),
        roi: data['roi'] == null
            ? null
            : RoiModel.fromJson(data['roi'] as Map<String, dynamic>),
        ath: data['ath'] == null
            ? null
            : PriceChangePercentageInCurrency.fromMap(
                data['ath'] as Map<String, dynamic>),
        athChangePercentage: data['ath_change_percentage'] == null
            ? null
            : PriceChangePercentageInCurrency.fromMap(
                data['ath_change_percentage'] as Map<String, dynamic>),
        athDate: data['ath_date'] == null
            ? null
            : AthDate.fromMap(data['ath_date'] as Map<String, dynamic>),
        atl: data['atl'] == null
            ? null
            : PriceChangePercentageInCurrency.fromMap(
                data['atl'] as Map<String, dynamic>),
        atlChangePercentage: data['atl_change_percentage'] == null
            ? null
            : PriceChangePercentageInCurrency.fromMap(
                data['atl_change_percentage'] as Map<String, dynamic>),
        atlDate: data['atl_date'] == null
            ? null
            : AthDate.fromMap(data['atl_date'] as Map<String, dynamic>),
        marketCap: data['market_cap'] == null
            ? null
            : PriceChangePercentageInCurrency.fromMap(
                data['market_cap'] as Map<String, dynamic>),
        marketCapRank: data['market_cap_rank'] as int?,
        totalVolume: data['total_volume'] == null
            ? null
            : PriceChangePercentageInCurrency.fromMap(
                data['total_volume'] as Map<String, dynamic>),
        high24h: data['high_24h'] == null
            ? null
            : PriceChangePercentageInCurrency.fromMap(
                data['high_24h'] as Map<String, dynamic>),
        low24h: data['low_24h'] == null
            ? null
            : PriceChangePercentageInCurrency.fromMap(
                data['low_24h'] as Map<String, dynamic>),
        priceChange24h: (data['price_change_24h'] as num).toDouble(),
        priceChangePercentage24h:
            (data['price_change_percentage_24h'] as num?)?.toDouble(),
        priceChangePercentage7d:
            (data['price_change_percentage_7d'] as num?)?.toDouble(),
        priceChangePercentage14d:
            (data['price_change_percentage_14d'] as num?)?.toDouble(),
        priceChangePercentage30d:
            (data['price_change_percentage_30d'] as num?)?.toDouble(),
        priceChangePercentage60d:
            (data['price_change_percentage_60d'] as num?)?.toDouble(),
        priceChangePercentage200d:
            (data['price_change_percentage_200d'] as num?)?.toDouble(),
        priceChangePercentage1y:
            (data['price_change_percentage_1y'] as num?)?.toDouble(),
        marketCapChange24h: data['market_cap_change_24h'] as num?,
        marketCapChangePercentage24h:
            (data['market_cap_change_percentage_24h'] as num?)?.toDouble(),
        priceChange24hInCurrency: data['price_change_24h_in_currency'] == null
            ? null
            : PriceChangePercentageInCurrency.fromMap(
                data['price_change_24h_in_currency'] as Map<String, dynamic>),
        priceChangePercentage1hInCurrency:
            data['price_change_percentage_1h_in_currency'] == null
                ? null
                : PriceChangePercentageInCurrency.fromMap(
                    data['price_change_percentage_1h_in_currency']
                        as Map<String, dynamic>),
        priceChangePercentage24hInCurrency:
            data['price_change_percentage_24h_in_currency'] == null
                ? null
                : PriceChangePercentageInCurrency.fromMap(
                    data['price_change_percentage_24h_in_currency']
                        as Map<String, dynamic>),
        priceChangePercentage7dInCurrency:
            data['price_change_percentage_7d_in_currency'] == null
                ? null
                : PriceChangePercentageInCurrency.fromMap(
                    data['price_change_percentage_7d_in_currency']
                        as Map<String, dynamic>),
        priceChangePercentage14dInCurrency:
            data['price_change_percentage_14d_in_currency'] == null
                ? null
                : PriceChangePercentageInCurrency.fromMap(
                    data['price_change_percentage_14d_in_currency']
                        as Map<String, dynamic>),
        priceChangePercentage30dInCurrency:
            data['price_change_percentage_30d_in_currency'] == null
                ? null
                : PriceChangePercentageInCurrency.fromMap(
                    data['price_change_percentage_30d_in_currency']
                        as Map<String, dynamic>),
        priceChangePercentage60dInCurrency:
            data['price_change_percentage_60d_in_currency'] == null
                ? null
                : PriceChangePercentageInCurrency.fromMap(
                    data['price_change_percentage_60d_in_currency']
                        as Map<String, dynamic>),
        priceChangePercentage200dInCurrency:
            data['price_change_percentage_200d_in_currency'] == null
                ? null
                : PriceChangePercentageInCurrency.fromMap(
                    data['price_change_percentage_200d_in_currency']
                        as Map<String, dynamic>),
        priceChangePercentage1yInCurrency:
            data['price_change_percentage_1y_in_currency'] == null
                ? null
                : PriceChangePercentageInCurrency.fromMap(
                    data['price_change_percentage_1y_in_currency']
                        as Map<String, dynamic>),
        marketCapChange24hInCurrency:
            data['market_cap_change_24h_in_currency'] == null
                ? null
                : PriceChangePercentageInCurrency.fromMap(
                    data['market_cap_change_24h_in_currency']
                        as Map<String, dynamic>),
        marketCapChangePercentage24hInCurrency:
            data['market_cap_change_percentage_24h_in_currency'] == null
                ? null
                : PriceChangePercentageInCurrency.fromMap(
                    data['market_cap_change_percentage_24h_in_currency']
                        as Map<String, dynamic>),
        totalSupply: (data['total_supply'] as num?)?.toDouble(),
        maxSupply: (data['max_supply'] as num?)?.toDouble(),
        circulatingSupply: (data['circulating_supply'] as num?)?.toDouble(),
        sparkline7d: data['sparkline_7d'] == null
            ? null
            : SparklineIn7dModel.fromJson(
                data['sparkline_7d'] as Map<String, dynamic>),
        lastUpdated: data['last_updated'] == null
            ? null
            : DateTime.parse(data['last_updated'] as String),
      );

  Map<String, dynamic> toMap() => {
        'current_price': currentPrice?.toMap(),
        'roi': roi?.toJson(),
        'ath': ath?.toMap(),
        'ath_change_percentage': athChangePercentage?.toMap(),
        'ath_date': athDate?.toMap(),
        'atl': atl?.toMap(),
        'atl_change_percentage': atlChangePercentage?.toMap(),
        'atl_date': atlDate?.toMap(),
        'market_cap': marketCap?.toMap(),
        'market_cap_rank': marketCapRank,
        'total_volume': totalVolume?.toMap(),
        'high_24h': high24h?.toMap(),
        'low_24h': low24h?.toMap(),
        'price_change_24h': priceChange24h,
        'price_change_percentage_24h': priceChangePercentage24h,
        'price_change_percentage_7d': priceChangePercentage7d,
        'price_change_percentage_14d': priceChangePercentage14d,
        'price_change_percentage_30d': priceChangePercentage30d,
        'price_change_percentage_60d': priceChangePercentage60d,
        'price_change_percentage_200d': priceChangePercentage200d,
        'price_change_percentage_1y': priceChangePercentage1y,
        'market_cap_change_24h': marketCapChange24h,
        'market_cap_change_percentage_24h': marketCapChangePercentage24h,
        'price_change_24h_in_currency': priceChange24hInCurrency?.toMap(),
        'price_change_percentage_1h_in_currency':
            priceChangePercentage1hInCurrency?.toMap(),
        'price_change_percentage_24h_in_currency':
            priceChangePercentage24hInCurrency?.toMap(),
        'price_change_percentage_7d_in_currency':
            priceChangePercentage7dInCurrency?.toMap(),
        'price_change_percentage_14d_in_currency':
            priceChangePercentage14dInCurrency?.toMap(),
        'price_change_percentage_30d_in_currency':
            priceChangePercentage30dInCurrency?.toMap(),
        'price_change_percentage_60d_in_currency':
            priceChangePercentage60dInCurrency?.toMap(),
        'price_change_percentage_200d_in_currency':
            priceChangePercentage200dInCurrency?.toMap(),
        'price_change_percentage_1y_in_currency':
            priceChangePercentage1yInCurrency?.toMap(),
        'market_cap_change_24h_in_currency':
            marketCapChange24hInCurrency?.toMap(),
        'market_cap_change_percentage_24h_in_currency':
            marketCapChangePercentage24hInCurrency?.toMap(),
        'total_supply': totalSupply,
        'max_supply': maxSupply,
        'circulating_supply': circulatingSupply,
        'sparkline_7d': sparkline7d?.toJson(),
        'last_updated': lastUpdated?.toIso8601String(),
      };

  factory MarketData.fromJson(String data) {
    return MarketData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
