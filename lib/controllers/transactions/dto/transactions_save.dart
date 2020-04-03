import 'package:dart_week_api/dart_week_api.dart';

class TransactionsSave extends Serializable {

  int category;
  DateTime dateTransaction;
  String description;
  double value;

  @override
  Map<String, dynamic> asMap() {
    return {
      'category': category,
      'description': description,
      'dateTransaction': dateTransaction,
      'value': value
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    category = object['category'] as int;
    description = object['description'] as String;
    final dateTransString = object['dateTransaction'] as String;
    dateTransaction = dateTransString != null ? DateTime.parse(dateTransString) : null;
    value = object['value'] as double;
  }

  @override
  Map<String, String> validate() {
    final Map<String, String> validateResult = {};

    if(category == null) {
      validateResult['category'] = 'Categoria não informada.';
    }

    if(value == null) {
      validateResult['value'] = 'Valor não informado.';
    }

    if(dateTransaction == null) {
      validateResult['dateTransaction'] = 'Data não informada.';
    }

    return validateResult;
  }
}