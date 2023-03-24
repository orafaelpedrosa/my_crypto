class MarketsParamsModel {
  String? vsCurrency;
  List<String>? ids;
  String? category;
  String? order;
  int? perPage;
  int? page;
  String? sparkline;
  String? priceChangePercentage;

  MarketsParamsModel({
    this.vsCurrency,
    this.ids = const [],
    this.category,
    this.order,
    this.perPage,
    this.page,
    this.sparkline,
    this.priceChangePercentage,
  });

  MarketsParamsModel.fromJson(Map<String, dynamic> json) {
    vsCurrency = json['vs_currency'] as String?;
    ids = json['ids'] as List<String>?;
    category = json['category'] as String?;
    order = json['order'] as String?;
    perPage = json['per_page'] as int?;
    page = json['page'] as int?;
    sparkline = json['sparkline'] as String?;
    priceChangePercentage = json['price_change_percentage'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vs_currency'] = vsCurrency;
    data['ids'] = ids!.join(',');
    data['category'] = category;
    data['order'] = order;
    data['per_page'] = perPage;
    data['page'] = page;
    data['sparkline'] = sparkline;
    data['price_change_percentage'] = priceChangePercentage;
    return data;
  }
}
