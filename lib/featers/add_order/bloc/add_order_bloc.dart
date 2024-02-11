import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:order_keeper/data/models/response/orders_response_model.dart';
import 'package:order_keeper/data/models/response/products_respinse_model.dart';
import 'package:order_keeper/data/models/response/tables_response_model.dart';
import 'package:order_keeper/domain/use_cases/add_order_use_case.dart';
import 'package:order_keeper/domain/use_cases/base_use_case.dart';
import 'package:order_keeper/domain/use_cases/get_all_products_use_case.dart';
import 'package:order_keeper/domain/use_cases/get_table_by_id_use_case.dart';

part 'add_order_event.dart';
part 'add_order_state.dart';

@injectable
class AddOrderBloc extends Bloc<AddOrderEvent, AddOrderState> {
  GetAllProductsUseCase getAllProductsUseCase;
  GetTableByIdUseCase getTableByIdUseCase;
  AddOrderUseCase addOrderUseCase;
  List<OrderResponseModel> orders = List.empty();
  List<OrderResponseModel> newOrders = [];
  TableModel table = TableModel();
  ProductsResponseModel products =
      ProductsResponseModel(products: List.empty());
  AddOrderBloc(
      {required this.getAllProductsUseCase,
      required this.getTableByIdUseCase,
      required this.addOrderUseCase})
      : super(AddOrderInitial()) {
    on<AddOrderEvent>((event, emit) async {
      if (event is AddOrderStartEvent) {
        emit(AddOrderLoadingState());
        products = await getAllProductsUseCase(NoParams());
        table = await getTableByIdUseCase(
            GetTableByIdUseCaseParams(tableId: event.tableId));
        orders = table.orderResponses ?? List.empty();
        emit(AddOrderLoadedState(data: products, table: table));
      } else if (event is AddOrderProductEvent) {
        emit(AddOrderLoadingState());
        orders.add(event.order);
        newOrders.add(event.order);
        emit(AddOrderLoadedState(
            data: products,
            table: TableModel(
                id: table.id, name: table.name, orderResponses: orders)));
      } else if (event is AddOrderConfirmEvent) {
        emit(AddOrderLoadingState());
        for (int i = 0; i < newOrders.length; i++) {
          await addOrderUseCase(newOrders[i]);
        }
        emit(AddOrderSuccessState());
      }
    });
  }
}
