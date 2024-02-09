import 'package:injectable/injectable.dart';
import 'package:order_keeper/data/models/response/tables_response_model.dart';
import 'package:order_keeper/utils/sql/database_service.dart';

abstract class WatersLocalDataSource {
  WatersLocalDataSource(DatabaseService databaseService);

  Future<TablesResponseModel> getAllTables();
}

@LazySingleton(as: WatersLocalDataSource)
class WatersLocalDataSourceImpl implements WatersLocalDataSource {
  final DatabaseService _databaseService;

  WatersLocalDataSourceImpl(this._databaseService);

  @override
  Future<TablesResponseModel> getAllTables() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> tablesList = await db.query('tables');

    final List<OTable> tables = tablesList.map((tableMap) {
      final int id = tableMap['id'];
      return OTable(
        id: id,
        order: null, // Change this according to your database structure
      );
    }).toList();

    return TablesResponseModel(tables: tables);
  }
}
