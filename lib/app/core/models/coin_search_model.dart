class CoinSearchModel {
  String? id;
  String? name;
  String? apiSymbol;
  String? symbol;
  int? marketCapRank;
  String? thumb;
  String? large;

  CoinSearchModel(
      {this.id,
      this.name,
      this.apiSymbol,
      this.symbol,
      this.marketCapRank,
      this.thumb,
      this.large});

  CoinSearchModel.fromJson(Map<String, dynamic> json) {
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
