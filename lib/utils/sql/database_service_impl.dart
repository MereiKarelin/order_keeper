import 'package:injectable/injectable.dart';
import 'package:order_keeper/data/models/response/tables_response_model.dart';
import 'package:order_keeper/utils/sql/database_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

@LazySingleton(as: DatabaseService)
class DatabaseServiceImpl implements DatabaseService {
  Database? _database;

  @override
  Future<Database> get database async {
    // if (_database != null) {
    // return _database!;
    // }
    _database = await initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'order_keeper.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  @override
  Future<Database> initialize() async {
    final path = await fullPath;
    var database = await openDatabase(path, version: 5, onUpgrade: upgrade,
        onCreate: (db, version) async {
      await create(db, version);

      // Добавляем начальные данные при создании базы данных
      final TablesResponseModel initialData = TablesResponseModel(
        tables: [
          OTable(
            id: 1,
            order: ClientOrder(
              id: 1,
              products: [
                Product(id: 1, name: "Пицца", price: 12.99, quantity: 1),
                Product(id: 3, name: "Паста", price: 10.99, quantity: 2),
              ],
            ),
          ),
          OTable(
            id: 2,
            order: ClientOrder(
              id: 2,
              products: [
                Product(id: 2, name: "Салат", price: 8.99, quantity: 2),
              ],
            ),
          ),
          OTable(
            id: 3,
            order: null,
          ),
        ],
      );

      await insertInitialData(db, initialData);
    }, singleInstance: true);
    return database;
  }

  @override
  void upgrade(Database database, int oldVersion, int newVersion) async {}

  @override
  Future<void> insertInitialData(
      Database database, TablesResponseModel initialData) async {
    // Вставляем начальные данные в таблицу "orders"
    for (OTable table in initialData.tables) {
      if (table.order != null) {
        for (Product product in table.order!.products!) {
          await database.insert('orders', {
            'table_id': table.id,
            'product_id': product.id,
            'quantity': product.quantity,
          });
        }
      }
    }
  }

  @override
  Future<void> create(Database database, int version) async {
    // Создаем таблицу для столов
    await database.execute('''
    CREATE TABLE tables (
      id INTEGER PRIMARY KEY,
      name TEXT
    )
  ''');

    // Создаем таблицу для продуктов
    await database.execute('''
    CREATE TABLE products (
      id INTEGER PRIMARY KEY,
      name TEXT,
      price REAL
    )
  ''');

    // Создаем таблицу для заказов
    await database.execute('''
    CREATE TABLE orders (
      id INTEGER PRIMARY KEY,
      table_id INTEGER,
      product_id INTEGER,
      quantity INTEGER,
      FOREIGN KEY (table_id) REFERENCES tables (id),
      FOREIGN KEY (product_id) REFERENCES products (id)
    )
  ''');
  }
}
