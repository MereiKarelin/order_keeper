import 'package:injectable/injectable.dart';
import 'package:order_keeper/data/models/response/tables_response_model.dart';
import 'package:order_keeper/domain/repository/waiter_repo.dart';
import 'package:order_keeper/domain/use_cases/base_use_case.dart';

class GetTableByIdUseCaseParams {
  final int tableId;
  const GetTableByIdUseCaseParams({required this.tableId});
}

@lazySingleton
class GetTableByIdUseCase
    implements UseCase<TableModel, GetTableByIdUseCaseParams> {
  final WaiterRepo repository;

  const GetTableByIdUseCase({
    required this.repository,
  });

  @override
  Future<TableModel> call(GetTableByIdUseCaseParams params) async {
    return await repository.getTableById(params.tableId);
  }
}
