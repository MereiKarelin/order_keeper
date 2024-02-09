// To parse this JSON data, do
//
//     final tablesResponseModel = tablesResponseModelFromJson(jsonString);

import 'dart:convert';

TablesResponseModel tablesResponseModelFromJson(String str) =>
    TablesResponseModel.fromJson(json.decode(str));

String tablesResponseModelToJson(TablesResponseModel data) =>
    json.encode(data.toJson());

class TablesResponseModel {
  List<OTable> tables;

  TablesResponseModel({
    required this.tables,
  });

  factory TablesResponseModel.fromJson(Map<String, dynamic> json) =>
      TablesResponseModel(
        tables:
            List<OTable>.from(json["tables"].map((x) => OTable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tables": List<dynamic>.from(tables.map((x) => x.toJson())),
      };
}

class OTable {
  int? id;
  ClientOrder? order;

  OTable({
    required this.id,
    required this.order,
  });

  factory OTable.fromJson(Map<String, dynamic> json) => OTable(
        id: json["id"],
        order: json["orders"] != null
            ? ClientOrder.fromJson(json["orders"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orders": order?.toJson(),
      };
}

class ClientOrder {
  int? id;
  List<Product>? products;

  ClientOrder({
    required this.id,
    required this.products,
  });

  factory ClientOrder.fromJson(Map<String, dynamic> json) => ClientOrder(
        id: json["id"],
        products: json["products"] != null
            ? List<Product>.from(
                json["products"].map((x) => Product.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "products": products != null
            ? List<dynamic>.from(products!.map((x) => x.toJson()))
            : null,
      };
}

class Product {
  int? id;
  String? name;
  double? price;
  int? quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"]?.toDouble(),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
      };
}
