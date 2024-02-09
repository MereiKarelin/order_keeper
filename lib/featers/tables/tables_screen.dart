import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_keeper/featers/tables/bloc/tables_bloc.dart';
import 'package:order_keeper/featers/tables/widgets/category_widget.dart';
import 'package:order_keeper/utils/injectable/configurator.dart';

class TablesScreen extends StatelessWidget {
  final _tableBloc = getIt<TablesBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tables"),
        ),
        body: BlocProvider(
            create: (context) => _tableBloc..add(TablesStartEvent()),
            child: BlocBuilder<TablesBloc, TablesState>(
              builder: (context, state) => state is TablesLoadedState
                  ? ListView.builder(
                      itemCount: state.data.tables.length,
                      itemBuilder: (BuildContext context, int index) =>
                          CategoryWidget(table: state.data.tables[index]))
                  : const CircularProgressIndicator(),
            )));
  }
}
