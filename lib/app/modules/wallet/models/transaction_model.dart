import 'dart:convert';

import 'package:mycrypto/app/core/enums/operation_historic_enum.dart';

class TransactionHistoryModel {
  String? id;
  String? name;
  num? value;
  num? purchasePrice;
  OperationHistoricEnum? operation;
  DateTime? date;
  TransactionHistoryModel({
    this.id,
    this.name,
    this.value,
    this.purchasePrice,
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
    if (value != null) {
      result.addAll({'value': value});
    }
    if (purchasePrice != null) {
      result.addAll({'purchase_price': purchasePrice});
    }
    if (operation != null) {
      result.addAll({'operation': operation!.toMap()});
    }
    if (date != null) {
      result.addAll({'date': date!.toIso8601String()});
    }

    return result;
  }

  factory TransactionHistoryModel.fromMap(Map<String, dynamic> map) {
    return TransactionHistoryModel(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      purchasePrice: map['purchase_price'],
      operation: map['operation'] != null ? fromMap(map['operation']) : null,
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionHistoryModel.fromJson(String source) =>
      TransactionHistoryModel.fromMap(json.decode(source));
}
