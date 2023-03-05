import 'dart:convert';

enum OperationHistoricEnum {
  add,
  remove,
  update,
}

extension OperationHistoricEnumExtension on OperationHistoricEnum {
  String get value {
    switch (this) {
      case OperationHistoricEnum.add:
        return 'Adicionado';
      case OperationHistoricEnum.remove:
        return 'Removido';
      case OperationHistoricEnum.update:
        return 'Atualizado';
      default:
        return toString();
    }
  }

  Map<String, dynamic> toMap() {
    switch (this) {
      case OperationHistoricEnum.add:
        return {'value': 'add'};
      case OperationHistoricEnum.remove:
        return {'value': 'remove'};
      case OperationHistoricEnum.update:
        return {'value': 'update'};
      default:
        return {'value': toString()};
    }
  }

  static OperationHistoricEnum fromMap(Map<String, dynamic> map) {
    switch (map['value']) {
      case 'add':
        return OperationHistoricEnum.add;
      case 'remove':
        return OperationHistoricEnum.remove;
      case 'update':
        return OperationHistoricEnum.update;
      default:
        return OperationHistoricEnum.add;
    }
  }

  String toJson() => json.encode(toMap());
}
