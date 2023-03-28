class SearchModel {
  List<Coins>? coins;

  SearchModel({this.coins});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['coins'] != null) {
      coins = <Coins>[];
      json['coins'].forEach((v) {
        coins!.add(new Coins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coins != null) {
      data['coins'] = this.coins!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coins {
  String? id;
  String? name;
  String? apiSymbol;
  String? symbol;
  int? marketCapRank;
  String? thumb;
  String? large;

  Coins(
      {this.id,
      this.name,
      this.apiSymbol,
      this.symbol,
      this.marketCapRank,
      this.thumb,
      this.large});

  Coins.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    apiSymbol = json['api_symbol'];
    symbol = json['symbol'];
    marketCapRank = json['market_cap_rank'];
    thumb = json['thumb'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['api_symbol'] = this.apiSymbol;
    data['symbol'] = this.symbol;
    data['market_cap_rank'] = this.marketCapRank;
    data['thumb'] = this.thumb;
    data['large'] = this.large;
    return data;
  }
}
