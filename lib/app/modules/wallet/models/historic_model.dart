import 'dart:convert';

import 'package:mycrypto/app/core/enums/operation_historic_enum.dart';

class HistoricModel {
  String? id;
  String? name;
  String? amount;
  OperationHistoricEnum? operation;
  String? date;

  HistoricModel({
    this.id,
    this.name,
    this.amount,
    this.operation,
    this.date,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (amount != null) {
      result.addAll({'amount': amount});
    }
    if (operation != null) {
      result.addAll({'operation': operation!.toMap()});
    }
    if (date != null) {
      result.addAll({'date': date});
    }

    return result;
  }

  factory HistoricModel.fromMap(Map<String, dynamic> map) {
    return HistoricModel(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
      operation: map['operation'] != null
          ? OperationHistoricEnumExtension.fromMap(map['operation'])
          : null,
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoricModel.fromJson(String source) =>
      HistoricModel.fromMap(json.decode(source));
}
