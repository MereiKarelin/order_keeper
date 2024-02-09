import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tables_event.dart';
part 'tables_state.dart';

class TablesBloc extends Bloc<TablesEvent, TablesState> {
  TablesBloc() : super(TablesInitial()) {
    on<TablesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
