import 'package:flutter/material.dart';
import 'package:order_keeper/data/models/response/tables_response_model.dart';

class CategoryWidget extends StatelessWidget {
  final OTable table;
  const CategoryWidget({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 227, 245, 236),
          border: Border.all(color: const Color.fromARGB(255, 242, 241, 241))),
    );
  }
}
