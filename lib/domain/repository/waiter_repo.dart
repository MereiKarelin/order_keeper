import 'package:order_keeper/data/models/response/products_respinse_model.dart';
import 'package:order_keeper/data/models/response/tables_response_model.dart';

abstract class WaiterRepo {
  Future<List<TableModel>> getAllTables();
  Future<TableModel> getTableById(int tableId);

  Future<ProductsResponseModel> getAllProducts();
}
