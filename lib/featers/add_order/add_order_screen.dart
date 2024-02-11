import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:order_keeper/featers/add_order/bloc/add_order_bloc.dart';
import 'package:order_keeper/featers/add_order/widgets/bottom_app_bar_widget.dart';
import 'package:order_keeper/featers/add_order/widgets/order_products_widget.dart';
import 'package:order_keeper/featers/add_order/widgets/product_widget.dart';
import 'package:order_keeper/utils/injectable/configurator.dart';

class AddOrderScreen extends StatelessWidget {
  final int tableId;

  AddOrderScreen({super.key, required this.tableId});

  final _addOrderBloc = getIt<AddOrderBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add order"),
        ),
        bottomNavigationBar: BottomAppBarWidget(
          onTap: () => _addOrderBloc.add(AddOrderConfirmEvent()),
        ),
        body: BlocProvider(
            create: (context) =>
                _addOrderBloc..add(AddOrderStartEvent(tableId: tableId)),
            child: BlocListener<AddOrderBloc, AddOrderState>(
                listener: (context, state) {
                  // В этом блоке вы можете выполнить любые действия, зависящие от состояния вашего Bloc
                  if (state is AddOrderErrorState) {
                    showDialog(
                        context: context,
                        builder: (context) => const Dialog(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Error'),
                              ),
                            ));
                  } else if (state is AddOrderSuccessState) {
                    Navigator.pop(context);
                  }
                },
                child: BlocBuilder<AddOrderBloc, AddOrderState>(
                    builder: (context, state) => state is AddOrderLoadedState
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                state.table.orderResponses!.isNotEmpty
                                    ? SizedBox(
                                        height: (state.table.orderResponses
                                                    ?.length ??
                                                0) *
                                            100,
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: state
                                                .table.orderResponses?.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              log(state.data.products.length
                                                  .toString());
                                              return OrderProductWidget(
                                                  addOrderBloc: _addOrderBloc,
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
                                        height:
                                            state.data.products.length * 100,
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                state.data.products.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return ProductWidget(
                                                  addOrderBloc: _addOrderBloc,
                                                  tableId: tableId,
                                                  product: state
                                                      .data.products[index]);
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
                        : const CircularProgressIndicator()))));
  }
}
