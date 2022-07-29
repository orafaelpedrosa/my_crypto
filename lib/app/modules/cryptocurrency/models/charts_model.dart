
class ChartModel {
  List<List<num>>? prices;
  List<List<num>>? marketCaps;
  List<List<num>>? totalVolumes;

  ChartModel({
    this.prices,
    this.marketCaps,
    this.totalVolumes,
  });

  ChartModel.fromJson(Map<String, dynamic> json) {
    prices = json['prices'] as List<List<num>>?;
    marketCaps = json['market_caps'] as List<List<num>>?;
    totalVolumes = json['total_volumes'] as List<List<num>>?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prices'] = prices ?? [];
    data['market_caps'] = marketCaps ?? [];
    data['total_volumes'] = totalVolumes ?? [];

    return data;
  }
}
