import 'package:injectable/injectable.dart';
import 'package:order_keeper/data/datasource/waiters_local_datasourse.dart';
import 'package:order_keeper/data/models/response/tables_response_model.dart';
import 'package:order_keeper/domain/repository/waiter_repo.dart';

@LazySingleton(as: WaiterRepo)
class WaiterRepoImpl implements WaiterRepo {
  final WatersLocalDataSource waiterLocalDataSource;

  const WaiterRepoImpl({
    required this.waiterLocalDataSource,
  });

  @override
  Future<TablesResponseModel> getAllTables() async =>
      await waiterLocalDataSource.getAllTables();
}
