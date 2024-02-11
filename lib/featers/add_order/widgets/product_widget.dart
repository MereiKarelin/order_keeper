// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:order_keeper/data/models/response/orders_response_model.dart';
import 'package:order_keeper/data/models/response/products_respinse_model.dart';
import 'package:order_keeper/featers/add_order/bloc/add_order_bloc.dart';
import 'package:order_keeper/featers/add_order/widgets/number_input_dialog.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  final AddOrderBloc addOrderBloc;

  final int tableId;
  ProductWidget(
      {super.key,
      required this.product,
      required this.addOrderBloc,
      required this.tableId});

  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => NumberInputDialog(
                  initialValue: _value,
                  onAdd: () => _value++,
                  onRemove: () => _value = _value - 1,
                  onCon: () {
                    addOrderBloc.add(AddOrderProductEvent(
                        tableId: tableId,
                        order: OrderResponseModel(
                            id: product.id,
                            productName: product.name,
                            quantity: _value,
                            productPrice: product.price,
                            tableId: tableId)));
                    Navigator.pop(context);
                    _value = 0;
                  }));
        },
        child: Container(
          height: 70,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 227, 245, 236),
              border:
                  Border.all(color: const Color.fromARGB(66, 123, 122, 122)),
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
      ),
    );
  }
}
