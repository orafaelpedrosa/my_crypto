class CryptoPriceDateModel {
  String? volume;
  String? priceChange;
  String? priceChangePct;
  String? volumeChange;
  String? volumeChangePct;
  String? marketCapChange;
  String? marketCapChangePct;

  CryptoPriceDateModel({
    this.volume,
    this.priceChange,
    this.priceChangePct,
    this.volumeChange,
    this.volumeChangePct,
    this.marketCapChange,
    this.marketCapChangePct,
  });

  CryptoPriceDateModel.fromJson(Map<String, dynamic> json) {
    volume = json['volume'];
    priceChange = json['price_change'];
    priceChangePct = json['price_change_pct'];
    volumeChange = json['volume_change'];
    volumeChangePct = json['volume_change_pct'];
    marketCapChange = json['market_cap_change'];
    marketCapChangePct = json['market_cap_change_pct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['volume'] = this.volume;
    data['price_change'] = this.priceChange;
    data['price_change_pct'] = this.priceChangePct;
    data['volume_change'] = this.volumeChange;
    data['volume_change_pct'] = this.volumeChangePct;
    data['market_cap_change'] = this.marketCapChange;
    data['market_cap_change_pct'] = this.marketCapChangePct;
    return data;
  }
}
