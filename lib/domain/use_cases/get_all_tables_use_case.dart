import 'package:injectable/injectable.dart';
import 'package:order_keeper/data/models/response/tables_response_model.dart';
import 'package:order_keeper/domain/repository/waiter_repo.dart';
import 'package:order_keeper/domain/use_cases/base_use_case.dart';

@lazySingleton
class GetAllTablesUseCase implements UseCase<List<TableModel>, NoParams> {
  final WaiterRepo repository;

  const GetAllTablesUseCase({
    required this.repository,
  });

  @override
  Future<List<TableModel>> call(NoParams params) async {
    return await repository.getAllTables();
  }
}
