class CryptoData {
  List<List<num>>? price;
  List<List<num>>? marketCaps;
  List<List<num>>? totalVolume;

  CryptoData({this.price, this.marketCaps, this.totalVolume});

  factory CryptoData.fromJson(Map<String, dynamic> json) {
    return CryptoData(
      price: _parseData(json['prices']),
      marketCaps: _parseData(json['market_caps']),
      totalVolume: _parseData(json['total_volumes']),
    );
  }

  factory CryptoData.fromMap(Map<String, dynamic> map) {
    return CryptoData(
      price: _parseData(map['prices']),
      marketCaps: _parseData(map['market_caps']),
      totalVolume: _parseData(map['total_volumes']),
    );
  }

  static List<List<num>> _parseData(dynamic jsonData) {
    if (jsonData == null) {
      return [];
    }

    return List<List<num>>.from(jsonData.map<List<num>>((item) {
      return List<num>.from(item.map<num>((value) {
        if (value is num) {
          return value;
        } else if (value is String) {
          return num.tryParse(value) ?? 0;
        } else {
          return 0;
        }
      }));
    }));
  }
}
