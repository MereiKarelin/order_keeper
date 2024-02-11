// To parse this JSON data, do
//
//     final productsResponseModel = productsResponseModelFromJson(jsonString);

import 'dart:convert';

ProductsResponseModel productsResponseModelFromJson(String str) =>
    ProductsResponseModel.fromJson(json.decode(str));

String productsResponseModelToJson(ProductsResponseModel data) =>
    json.encode(data.toJson());

class ProductsResponseModel {
  List<Product> products;

  ProductsResponseModel({
    required this.products,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductsResponseModel(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  int? id;
  String? name;
  String? price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}
