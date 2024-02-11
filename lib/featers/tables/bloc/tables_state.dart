part of 'tables_bloc.dart';

sealed class TablesState extends Equatable {
  const TablesState();

  @override
  List<Object> get props => [];
}

final class TablesInitial extends TablesState {}

class TablesLoadingState extends TablesState {}

class TablesLoadedState extends TablesState {
  final List<TableModel> data;
  const TablesLoadedState({required this.data});
}

class TablesErrorState extends TablesState {}
