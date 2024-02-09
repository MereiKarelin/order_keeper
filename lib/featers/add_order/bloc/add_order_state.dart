part of 'add_order_bloc.dart';

sealed class AddOrderState extends Equatable {
  const AddOrderState();
  
  @override
  List<Object> get props => [];
}

final class AddOrderInitial extends AddOrderState {}
