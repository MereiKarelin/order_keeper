import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_keeper/featers/add_order/bloc/add_order_bloc.dart';
import 'package:order_keeper/featers/add_order/widgets/order_products_widget.dart';
import 'package:order_keeper/featers/add_order/widgets/product_widget.dart';
import 'package:order_keeper/utils/injectable/configurator.dart';

class AddOrderScreen extends StatelessWidget {
  final _addOrderBloc = getIt<AddOrderBloc>();
  final int tableId;

  AddOrderScreen({super.key, required this.tableId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add order"),
        ),
        body: BlocProvider(
            create: (context) =>
                _addOrderBloc..add(AddOrderStartEvent(tableId: tableId)),
            child: BlocBuilder<AddOrderBloc, AddOrderState>(
                builder: (context, state) => state is AddOrderLoadedState
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            state.table.orderResponses!.isNotEmpty
                                ? SizedBox(
                                    height:
                                        (state.table.orderResponses?.length ??
                                                0) *
                                            100,
                                    child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            state.table.orderResponses?.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          log(state.data.products.length
                                              .toString());
                                          return OrderProductWidget(
                                              order: state.table
                                                  .orderResponses![index]);
                                        }),
                                  )
                                : const SizedBox(
                                    height: 100,
                                    child: Center(
                                      child: Text("Нету продуктов"),
                                    )),
                            const Text("Добавить продукт"),
                            state.data.products.isNotEmpty
                                ? SizedBox(
                                    height: state.data.products.length * 100,
                                    child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: state.data.products.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ProductWidget(
                                              product:
                                                  state.data.products[index]);
                                        }),
                                  )
                                : const SizedBox(
                                    height: 100,
                                    child: Center(
                                      child: Text("Нету продуктов"),
                                    )),
                          ],
                        ),
                      )
                    : const CircularProgressIndicator())));
  }
}
