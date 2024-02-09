// To parse this JSON data, do
//
//     final ordersResponseModel = ordersResponseModelFromJson(jsonString);

import 'dart:convert';

OrdersResponseModel ordersResponseModelFromJson(String str) =>
    OrdersResponseModel.fromJson(json.decode(str));

String ordersResponseModelToJson(OrdersResponseModel data) =>
    json.encode(data.toJson());

class OrdersResponseModel {
  List<Order> orders;

  OrdersResponseModel({
    required this.orders,
  });

  factory OrdersResponseModel.fromJson(Map<String, dynamic> json) =>
      OrdersResponseModel(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
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
