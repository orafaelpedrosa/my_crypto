class SparklineIn7dModel {
  List<double>? price;

  SparklineIn7dModel({
    this.price,
  });

  SparklineIn7dModel.fromJson(Map<String, dynamic> json) {
    price = json['price']?.cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    return data;
  }
}
