import 'dart:convert';

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
  CryptocurrencyModel({
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
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'currency': currency,
      'symbol': symbol,
      'name': name,
      'logoUrl': logoUrl,
      'status': status,
      'price': price,
      'priceDate': priceDate,
      'priceTimestamp': priceTimestamp,
      'circulatingSupply': circulatingSupply,
      'maxSupply': maxSupply,
      'marketCap': marketCap,
      'marketCapDominance': marketCapDominance,
      'numExchanges': numExchanges,
      'numPairs': numPairs,
      'numPairsUnmapped': numPairsUnmapped,
      'firstCandle': firstCandle,
      'firstTrade': firstTrade,
      'firstOrderBook': firstOrderBook,
      'rank': rank,
      'rankDelta': rankDelta,
      'high': high,
      'highTimestamp': highTimestamp,
    };
  }

  factory CryptocurrencyModel.fromMap(Map<String, dynamic> map) {
    return CryptocurrencyModel(
      id: map['id'],
      currency: map['currency'],
      symbol: map['symbol'],
      name: map['name'],
      logoUrl: map['logoUrl'],
      status: map['status'],
      price: map['price'],
      priceDate: map['priceDate'],
      priceTimestamp: map['priceTimestamp'],
      circulatingSupply: map['circulatingSupply'],
      maxSupply: map['maxSupply'],
      marketCap: map['marketCap'],
      marketCapDominance: map['marketCapDominance'],
      numExchanges: map['numExchanges'],
      numPairs: map['numPairs'],
      numPairsUnmapped: map['numPairsUnmapped'],
      firstCandle: map['firstCandle'],
      firstTrade: map['firstTrade'],
      firstOrderBook: map['firstOrderBook'],
      rank: map['rank'],
      rankDelta: map['rankDelta'],
      high: map['high'],
      highTimestamp: map['highTimestamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CryptocurrencyModel.fromJson(String source) => CryptocurrencyModel.fromMap(json.decode(source));
}
