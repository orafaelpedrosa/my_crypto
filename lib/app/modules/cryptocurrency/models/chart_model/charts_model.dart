class ChartModel {
  List<List<num>>? prices;
  List<List<num>>? marketCaps;
  List<List<num>>? totalVolumes;
  List<num>? pricesChart;

  ChartModel({
    this.prices,
    this.marketCaps,
    this.totalVolumes,
    this.pricesChart,
  });

  ChartModel.fromJson(Map<String, dynamic> json) {
    prices = json['prices'] != null
        ? (json['prices'] as List).map((e) => (e as List).cast<num>()).toList()
        : null;
    marketCaps = json['market_caps'] != null
        ? (json['market_caps'] as List)
            .map((e) => (e as List).cast<num>())
            .toList()
        : null;
    totalVolumes = json['total_volumes'] != null
        ? (json['total_volumes'] as List)
            .map((e) => (e as List).cast<num>())
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prices'] = this.prices;
    data['market_caps'] = this.marketCaps;
    data['total_volumes'] = this.totalVolumes;
    return data;
  }
}
