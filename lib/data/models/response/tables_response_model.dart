// To parse this JSON data, do
//
//     final tablesResponseModel = tablesResponseModelFromJson(jsonString);

import 'dart:convert';

TablesResponseModel tablesResponseModelFromJson(String str) =>
    TablesResponseModel.fromJson(json.decode(str));

String tablesResponseModelToJson(TablesResponseModel data) =>
    json.encode(data.toJson());

class TablesResponseModel {
  List<Table> tables;

  TablesResponseModel({
    required this.tables,
  });

  factory TablesResponseModel.fromJson(Map<String, dynamic> json) =>
      TablesResponseModel(
        tables: List<Table>.from(json["tables"].map((x) => Table.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tables": List<dynamic>.from(tables.map((x) => x.toJson())),
      };
}

class Table {
  int id;
  List<Order> orders;

  Table({
    required this.id,
    required this.orders,
  });

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        id: json["id"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  int id;
  List<Product> products;

  Order({
    required this.id,
    required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  int id;
  String name;
  double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}
