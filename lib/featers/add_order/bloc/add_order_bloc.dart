import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_order_event.dart';
part 'add_order_state.dart';

class AddOrderBloc extends Bloc<AddOrderEvent, AddOrderState> {
  AddOrderBloc() : super(AddOrderInitial()) {
    on<AddOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
