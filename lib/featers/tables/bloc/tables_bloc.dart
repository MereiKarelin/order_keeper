import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:order_keeper/data/models/response/tables_response_model.dart';
import 'package:order_keeper/domain/use_cases/base_use_case.dart';
import 'package:order_keeper/domain/use_cases/get_all_tables_use_case.dart';

part 'tables_event.dart';
part 'tables_state.dart';

@injectable
class TablesBloc extends Bloc<TablesEvent, TablesState> {
  GetAllTablesUseCase getAllTablesUseCase;
  TablesBloc({required this.getAllTablesUseCase}) : super(TablesInitial()) {
    on<TablesEvent>((event, emit) async {
      if (event is TablesStartEvent) {
        emit(TablesLoadingState());
        final response = await getAllTablesUseCase(NoParams());
        emit(TablesLoadedState(data: response));
      }
    });
  }
}
