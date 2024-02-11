import 'package:flutter/material.dart';
import 'package:order_keeper/data/models/response/tables_response_model.dart';

class CategoryWidget extends StatelessWidget {
  final TableModel table;
  const CategoryWidget({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 227, 245, 236),
            border: Border.all(color: const Color.fromARGB(66, 123, 122, 122))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '${table.id}.',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    table.name ?? '',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  )
                ],
              ),
              Text(
                table.orderResponses!.isNotEmpty ? "Есть заказ" : "Нет заказа",
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
