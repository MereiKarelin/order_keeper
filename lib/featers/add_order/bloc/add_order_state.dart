part of 'add_order_bloc.dart';

sealed class AddOrderState extends Equatable {
  const AddOrderState();

  @override
  List<Object> get props => [];
}

final class AddOrderInitial extends AddOrderState {}

class AddOrderLoadingState extends AddOrderState {}

class AddOrderLoadedState extends AddOrderState {
  final ProductsResponseModel data;
  final TableModel table;
  const AddOrderLoadedState({required this.data, required this.table});
}

class AddOrderErrorState extends AddOrderState {}
