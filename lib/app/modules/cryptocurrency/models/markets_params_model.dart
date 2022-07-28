class MarketsParamsModel {
  String? vsCurrency;
  String? ids;
  String? category;
  String? order;
  String? perPage;
  String? page;
  String? sparkline;
  String? priceChangePercentage;

  MarketsParamsModel({
    this.vsCurrency = 'usd',
    this.ids,
    this.category,
    this.order,
    this.perPage,
    this.page,
    this.sparkline,
    this.priceChangePercentage,
  });

  MarketsParamsModel.fromJson(Map<String, dynamic> json) {
    vsCurrency = json['vs_currency'] as String?;
    ids = json['ids'] as String?;
    category = json['category'] as String?;
    order = json['order'] as String?;
    perPage = json['per_page'] as String?;
    page = json['page'] as String?;
    sparkline = json['sparkline'] as String?;
    priceChangePercentage = json['price_change_percentage'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vs_currency'] = vsCurrency;
    data['ids'] = ids;
    data['category'] = category;
    data['order'] = order;
    data['per_page'] = perPage;
    data['page'] = page;
    data['sparkline'] = sparkline;
    data['price_change_percentage'] = priceChangePercentage;
    return data;
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'vsCurrency': vsCurrency ?? 'usd',
  //     'ids': ids ?? '',
  //     'category': category ?? '',
  //     'order': order ?? '',
  //     'perPage': perPage ?? '',
  //     'page': page ?? '',
  //     'sparkline': sparkline ?? '',
  //     'priceChangePercentage': priceChangePercentage ?? '',
  //   };
  // }

  // factory MarketsParamsModel.fromMap(Map<String, dynamic> map) {
  //   return MarketsParamsModel(
  //     vsCurrency: map['vsCurrency'] as String?,
  //     ids: map['ids'] as String?,
  //     category: map['category'] as String?,
  //     order: map['order'] as String?,
  //     perPage: map['perPage'] as String?,
  //     page: map['page'] as String?,
  //     sparkline: map['sparkline'],
  //     priceChangePercentage: map['priceChangePercentage'] as String?,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory MarketsParamsModel.fromJson(String source) => MarketsParamsModel.fromMap(json.decode(source));
}
