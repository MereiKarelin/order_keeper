import 'package:flutter/material.dart';
import 'package:order_keeper/data/models/response/orders_response_model.dart';
import 'package:order_keeper/featers/add_order/bloc/add_order_bloc.dart';

class OrderProductWidget extends StatelessWidget {
  final OrderResponseModel order;
  final AddOrderBloc addOrderBloc;
  const OrderProductWidget(
      {super.key, required this.addOrderBloc, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () => addOrderBloc,
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
                Text(order.id.toString()),
                Text(order.productName.toString()),
                Text("Цена: ${order.productPrice}"),
                Text("Количество: ${order.quantity}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
