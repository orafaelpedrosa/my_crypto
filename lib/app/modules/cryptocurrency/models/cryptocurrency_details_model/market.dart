import 'dart:convert';

class Market {
  String? name;
  String? identifier;
  bool? hasTradingIncentive;

  Market({this.name, this.identifier, this.hasTradingIncentive});

  factory Market.fromMap(Map<String, dynamic> data) => Market(
        name: data['name'] as String?,
        identifier: data['identifier'] as String?,
        hasTradingIncentive: data['has_trading_incentive'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'identifier': identifier,
        'has_trading_incentive': hasTradingIncentive,
      };

  factory Market.fromJson(String data) {
    return Market.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
