import 'package:injectable/injectable.dart';
import 'package:order_keeper/data/models/response/orders_response_model.dart';
import 'package:order_keeper/data/models/response/products_respinse_model.dart';
import 'package:order_keeper/data/models/response/tables_response_model.dart';
import 'package:order_keeper/utils/sql/database_service.dart';

abstract class WatersLocalDataSource {
  WatersLocalDataSource(DatabaseService databaseService);

  Future<List<TableModel>> getAllTables();
  Future<TableModel> getTableById(int tableId);
  Future<ProductsResponseModel> getAllProducts();
}

@LazySingleton(as: WatersLocalDataSource)
class WatersLocalDataSourceImpl implements WatersLocalDataSource {
  final DatabaseService _databaseService;

  WatersLocalDataSourceImpl(this._databaseService);

  @override
  Future<List<TableModel>> getAllTables() async {
    final db = await _databaseService.database;
    List<Map<String, dynamic>> tableMaps = await db.query('tables');
    List<Map<String, dynamic>> orderResponseMaps =
        await db.query('OrderResponse');

    List<TableModel> tables = [];

    for (var tableMap in tableMaps) {
      List<OrderResponseModel> orderResponses = [];
      int tableId = tableMap['id'];

      // Находим все OrderResponseModel, связанные с текущим столом
      for (var orderResponseMap in orderResponseMaps) {
        if (orderResponseMap['table_id'] == tableId) {
          orderResponses.add(OrderResponseModel.fromMap(orderResponseMap));
        }
      }

      // Создаем экземпляр TableModel с соответствующими OrderResponseModel
      TableModel table = TableModel.fromMap(tableMap);
      table.orderResponses = orderResponses;
      tables.add(table);
    }

    return tables;
  }

  Future<TableModel> getTableById(int tableId) async {
    final db = await _databaseService.database;
    List<Map<String, dynamic>> tableMaps =
        await db.query('tables', where: 'id = ?', whereArgs: [tableId]);

    List<OrderResponseModel> orderResponses =
        await getOrderResponsesByTableId(tableId);
    TableModel table = TableModel.fromMap(tableMaps.first);
    table.orderResponses = orderResponses;
    return table;
  }

  @override
  Future<ProductsResponseModel> getAllProducts() async {
    final db = await _databaseService.database;
    List<Map<String, dynamic>> maps = await db.query('products');
    final List<Product> products = List.generate(maps.length, (i) {
      return Product.fromJson(maps[i]);
    });

    return ProductsResponseModel(products: products);
  }

  Future<List<OrderResponseModel>> getOrderResponsesByTableId(
      int tableId) async {
    final db = await _databaseService.database;
    List<Map<String, dynamic>> orderResponseMaps = await db
        .query('OrderResponse', where: 'table_id = ?', whereArgs: [tableId]);
    return List.generate(orderResponseMaps.length, (i) {
      return OrderResponseModel.fromMap(orderResponseMaps[i]);
    });
  }
}
