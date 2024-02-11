import 'package:flutter/material.dart';
import 'package:order_keeper/data/models/response/products_respinse_model.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 227, 245, 236),
            border: Border.all(color: const Color.fromARGB(66, 123, 122, 122)),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(product.id.toString()),
              Text(product.name.toString()),
              Text("Цена: ${product.price}"),
            ],
          ),
        ),
      ),
    );
  }
}
