part of 'tables_bloc.dart';

sealed class TablesState extends Equatable {
  const TablesState();
  
  @override
  List<Object> get props => [];
}

final class TablesInitial extends TablesState {}
