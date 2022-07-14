class RoiModel {
  double? times;
  String? currency;
  double? percentage;

  RoiModel({
    this.times,
    this.currency,
    this.percentage,
  });

  RoiModel.fromJson(Map<String, dynamic> json) {
    times = json['times'];
    currency = json['currency'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['times'] = this.times;
    data['currency'] = this.currency;
    data['percentage'] = this.percentage;
    return data;
  }
}
