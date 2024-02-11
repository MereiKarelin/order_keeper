part of 'add_order_bloc.dart';

sealed class AddOrderEvent extends Equatable {
  const AddOrderEvent();

  @override
  List<Object> get props => [];
}

class AddOrderStartEvent extends AddOrderEvent {
  final int tableId;
  const AddOrderStartEvent({required this.tableId});
}
