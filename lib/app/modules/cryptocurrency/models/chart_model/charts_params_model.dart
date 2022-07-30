class ChartsParamsModel {
  String? id;
  String? days;
  String? vsCurrency;

  ChartsParamsModel({
    this.id,
    this.days,
    this.vsCurrency,
  });

  ChartsParamsModel.fromJson(Map<String, dynamic> json) {
    id = json['prices'] as String?;
    days = json['days'] as String?;
    vsCurrency = json['vs_currency'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['days'] = days ?? '';
    data['vs_currency'] = vsCurrency ?? '';

    return data;
  }
}
