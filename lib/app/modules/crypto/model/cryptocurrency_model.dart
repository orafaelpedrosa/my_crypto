class CryptocurrencyModel {
  String? id;
  String? currency;
  String? symbol;
  String? name;
  String? logoUrl;
  String? status;
  String? price;
  String? priceDate;
  String? priceTimestamp;
  String? circulatingSupply;
  String? maxSupply;
  String? marketCap;
  String? marketCapDominance;
  String? numExchanges;
  String? numPairs;
  String? numPairsUnmapped;
  String? firstCandle;
  String? firstTrade;
  String? firstOrderBook;
  String? rank;
  String? rankDelta;
  String? high;
  String? highTimestamp;

  CryptocurrencyModel(
    this.id,
    this.currency,
    this.symbol,
    this.name,
    this.logoUrl,
    this.status,
    this.price,
    this.priceDate,
    this.priceTimestamp,
    this.circulatingSupply,
    this.maxSupply,
    this.marketCap,
    this.marketCapDominance,
    this.numExchanges,
    this.numPairs,
    this.numPairsUnmapped,
    this.firstCandle,
    this.firstTrade,
    this.firstOrderBook,
    this.rank,
    this.rankDelta,
    this.high,
    this.highTimestamp,
  );

  CryptocurrencyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currency = json['currency'];
    symbol = json['symbol'];
    name = json['name'];
    logoUrl = json['logo_url'];
    status = json['status'];
    price = json['price'];
    priceDate = json['price_date'];
    priceTimestamp = json['price_timestamp'];
    circulatingSupply = json['circulating_supply'];
    maxSupply = json['max_supply'];
    marketCap = json['market_cap'];
    marketCapDominance = json['market_cap_dominance'];
    numExchanges = json['num_exchanges'];
    numPairs = json['num_pairs'];
    numPairsUnmapped = json['num_pairs_unmapped'];
    firstCandle = json['first_candle'];
    firstTrade = json['first_trade'];
    firstOrderBook = json['first_order_book'];
    rank = json['rank'];
    rankDelta = json['rank_delta'];
    high = json['high'];
    highTimestamp = json['high_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['currency'] = currency;
    data['symbol'] = symbol;
    data['name'] = name;
    data['logo_url'] = logoUrl;
    data['status'] = status;
    data['price'] = price;
    data['price_date'] = priceDate;
    data['price_timestamp'] = priceTimestamp;
    data['circulating_supply'] = circulatingSupply;
    data['max_supply'] = maxSupply;
    data['market_cap'] = marketCap;
    data['market_cap_dominance'] = marketCapDominance;
    data['num_exchanges'] = numExchanges;
    data['num_pairs'] = numPairs;
    data['num_pairs_unmapped'] = numPairsUnmapped;
    data['first_candle'] = firstCandle;
    data['first_trade'] = firstTrade;
    data['first_order_book'] = firstOrderBook;
    data['rank'] = rank;
    data['rank_delta'] = rankDelta;
    data['high'] = high;
    data['high_timestamp'] = highTimestamp;
    return data;
  }
}
