import 'package:injectable/injectable.dart';
import 'package:order_keeper/data/datasource/waiters_local_datasourse.dart';
import 'package:order_keeper/data/models/response/orders_response_model.dart';
import 'package:order_keeper/data/models/response/products_respinse_model.dart';
import 'package:order_keeper/data/models/response/tables_response_model.dart';
import 'package:order_keeper/domain/repository/waiter_repo.dart';

@LazySingleton(as: WaiterRepo)
class WaiterRepoImpl implements WaiterRepo {
  final WatersLocalDataSource waiterLocalDataSource;

  const WaiterRepoImpl({
    required this.waiterLocalDataSource,
  });

  @override
  Future<List<TableModel>> getAllTables() async =>
      await waiterLocalDataSource.getAllTables();

  @override
  Future<TableModel> getTableById(int tableId) async =>
      await waiterLocalDataSource.getTableById(tableId);

  @override
  Future<void> addOrder(OrderResponseModel order) async =>
      await waiterLocalDataSource.addOrder(order);

  @override
  Future<ProductsResponseModel> getAllProducts() async =>
      await waiterLocalDataSource.getAllProducts();
}
