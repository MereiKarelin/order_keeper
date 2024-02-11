// Модель данных для таблицы "tables" с полем для списка OrderResponseModel
import 'package:order_keeper/data/models/response/orders_response_model.dart';

class TableModel {
  int? id;
  String? name;
  List<OrderResponseModel>? orderResponses;

  TableModel({this.id, this.name, this.orderResponses});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  static TableModel fromMap(Map<String, dynamic> map) {
    return TableModel(
      id: map['id'],
      name: map['name'],
    );
  }
}
