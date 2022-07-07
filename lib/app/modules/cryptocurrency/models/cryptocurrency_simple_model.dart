import 'package:mycrypto/app/modules/cryptocurrency/models/roi_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/sparkline_in_7d_model.dart';

class CryptocurrencySimpleModel {
  String? id;
  String? symbol;
  String? name;
  String? image;
  num? currentPrice;
  num? marketCap;
  num? marketCapRank;
  num? fullyDilutedValuation;
  num? totalVolume;
  num? high24h;
  num? low24h;
  num? priceChange24h;
  num? priceChangePercentage24h;
  num? marketCapChange24h;
  num? marketCapChangePercentage24h;
  num? circulatingSupply;
  num? totalSupply;
  num? maxSupply;
  num? ath;
  num? athChangePercentage;
  String? athDate;
  num? atl;
  num? atlChangePercentage;
  String? atlDate;
  RoiModel? roi;
  String? lastUpdated;
  SparklineIn7dModel? sparklineIn7d;
  num? priceChangePercentage1hInCurrency;
  num? priceChangePercentage24hInCurrency;
  num? priceChangePercentage7dInCurrency;
  num? priceChangePercentage14dInCurrency;
  num? priceChangePercentage30dInCurrency;
  num? priceChangePercentage200dInCurrency;
  num? priceChangePercentage1yInCurrency;

  CryptocurrencySimpleModel({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.fullyDilutedValuation,
    this.totalVolume,
    this.high24h,
    this.low24h,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.marketCapChange24h,
    this.marketCapChangePercentage24h,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.ath,
    this.athChangePercentage,
    this.athDate,
    this.atl,
    this.atlChangePercentage,
    this.atlDate,
    this.roi,
    this.lastUpdated,
    this.sparklineIn7d,
    this.priceChangePercentage1hInCurrency,
    this.priceChangePercentage24hInCurrency,
    this.priceChangePercentage7dInCurrency,
    this.priceChangePercentage14dInCurrency,
    this.priceChangePercentage30dInCurrency,
    this.priceChangePercentage200dInCurrency,
    this.priceChangePercentage1yInCurrency,
  });

  CryptocurrencySimpleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    currentPrice = json['current_price'];
    marketCap = json['market_cap'];
    marketCapRank = json['market_cap_rank'];
    fullyDilutedValuation = json['fully_diluted_valuation'];
    totalVolume = json['total_volume'];
    high24h = json['high_24h'];
    low24h = json['low_24h'];
    priceChange24h = json['price_change_24h'];
    priceChangePercentage24h = json['price_change_percentage_24h'];
    marketCapChange24h = json['market_cap_change_24h'];
    marketCapChangePercentage24h = json['market_cap_change_percentage_24h'];
    circulatingSupply = json['circulating_supply'];
    totalSupply = json['total_supply'];
    maxSupply = json['max_supply'];
    ath = json['ath'];
    athChangePercentage = json['ath_change_percentage'];
    athDate = json['ath_date'];
    atl = json['atl'];
    atlChangePercentage = json['atl_change_percentage'];
    atlDate = json['atl_date'];
    if (json['roi'] != null) {
      roi = RoiModel.fromJson(json['roi']);
    }
    lastUpdated = json['last_updated'];
    sparklineIn7d = SparklineIn7dModel.fromJson(json['sparkline_in_7d']);
    priceChangePercentage1hInCurrency =
        json['price_change_percentage_1h_in_currency'];
    priceChangePercentage24hInCurrency =
        json['price_change_percentage_24h_in_currency'];
    priceChangePercentage7dInCurrency =
        json['price_change_percentage_7d_in_currency'];
    priceChangePercentage14dInCurrency =
        json['price_change_percentage_14d_in_currency'];
    priceChangePercentage30dInCurrency =
        json['price_change_percentage_30d_in_currency'];
    priceChangePercentage200dInCurrency =
        json['price_change_percentage_200d_in_currency'];
    priceChangePercentage1yInCurrency =
        json['price_change_percentage_1y_in_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    data['image'] = this.image;
    data['current_price'] = this.currentPrice;
    data['market_cap'] = this.marketCap;
    data['market_cap_rank'] = this.marketCapRank;
    data['fully_diluted_valuation'] = this.fullyDilutedValuation;
    data['total_volume'] = this.totalVolume;
    data['high_24h'] = this.high24h;
    data['low_24h'] = this.low24h;
    data['price_change_24h'] = this.priceChange24h;
    data['price_change_percentage_24h'] = this.priceChangePercentage24h;
    data['market_cap_change_24h'] = this.marketCapChange24h;
    data['market_cap_change_percentage_24h'] =
        this.marketCapChangePercentage24h;
    data['circulating_supply'] = this.circulatingSupply;
    data['total_supply'] = this.totalSupply;
    data['max_supply'] = this.maxSupply;
    data['ath'] = this.ath;
    data['ath_change_percentage'] = this.athChangePercentage;
    data['ath_date'] = this.athDate;
    data['atl'] = this.atl;
    data['atl_change_percentage'] = this.atlChangePercentage;
    data['atl_date'] = this.atlDate;
    data['roi'] = this.roi;
    data['last_updated'] = this.lastUpdated;
    data['sparkline_in_7d'] = this.sparklineIn7d;
    data['price_change_percentage_1h_in_currency'] =
        this.priceChangePercentage1hInCurrency;
    data['price_change_percentage_24h_in_currency'] =
        this.priceChangePercentage24hInCurrency;
    data['price_change_percentage_7d_in_currency'] =
        this.priceChangePercentage7dInCurrency;
    data['price_change_percentage_14d_in_currency'] =
        this.priceChangePercentage14dInCurrency;
    data['price_change_percentage_30d_in_currency'] =
        this.priceChangePercentage30dInCurrency;
    data['price_change_percentage_200d_in_currency'] =
        this.priceChangePercentage200dInCurrency;
    data['price_change_percentage_1y_in_currency'] =
        this.priceChangePercentage1yInCurrency;

    return data;
  }
}
