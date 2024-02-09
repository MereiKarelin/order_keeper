import 'package:order_keeper/data/models/response/tables_response_model.dart';

abstract class WaiterRepo {
  Future<TablesResponseModel> getAllTables();
}
