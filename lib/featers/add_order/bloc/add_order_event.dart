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

class AddOrderProductEvent extends AddOrderEvent {
  final OrderResponseModel order;
  final int tableId;
  const AddOrderProductEvent({required this.order, required this.tableId});
}

class AddOrderConfirmEvent extends AddOrderEvent {}
