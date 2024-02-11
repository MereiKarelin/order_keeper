import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:order_keeper/data/models/response/products_respinse_model.dart';
import 'package:order_keeper/data/models/response/tables_response_model.dart';
import 'package:order_keeper/domain/use_cases/base_use_case.dart';
import 'package:order_keeper/domain/use_cases/get_all_products_use_case.dart';
import 'package:order_keeper/domain/use_cases/get_table_by_id_use_case.dart';

part 'add_order_event.dart';
part 'add_order_state.dart';

@injectable
class AddOrderBloc extends Bloc<AddOrderEvent, AddOrderState> {
  GetAllProductsUseCase getAllProductsUseCase;
  GetTableByIdUseCase getTableByIdUseCase;
  AddOrderBloc(
      {required this.getAllProductsUseCase, required this.getTableByIdUseCase})
      : super(AddOrderInitial()) {
    on<AddOrderEvent>((event, emit) async {
      if (event is AddOrderStartEvent) {
        emit(AddOrderLoadingState());
        final products = await getAllProductsUseCase(NoParams());
        final table = await getTableByIdUseCase(
            GetTableByIdUseCaseParams(tableId: event.tableId));
        emit(AddOrderLoadedState(data: products, table: table));
      }
    });
  }
}
