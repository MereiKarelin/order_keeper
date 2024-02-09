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
    if (_database != null) {
      return _database!;
    }
    _database = await initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'message.db';
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
          Table(
            id: 1,
            orders: [
              ClientOrder(
                id: 1,
                products: [
                  Product(id: 1, name: "Пицца", price: 12.99),
                  Product(id: 3, name: "Паста", price: 10.99),
                ],
              ),
            ],
          ),
          Table(
            id: 2,
            orders: [
              ClientOrder(
                id: 2,
                products: [
                  Product(id: 2, name: "Салат", price: 8.99),
                ],
              ),
            ],
          ),
          Table(
            id: 3,
            orders: [],
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
    // Вставляем начальные данные в таблицу "tables"
    for (Table table in initialData.tables) {
      await database.insert('tables', table.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> create(Database database, int version) async {
    // Создаем таблицу для категорий сообщений (людей)
    await database.execute('''
          CREATE TABLE tables (
            id INTEGER PRIMARY KEY,
            name TEXT
          )
        ''');
    await database.execute('''
          CREATE TABLE orders (
            id INTEGER PRIMARY KEY,
            table_id INTEGER,
            FOREIGN KEY (table_id) REFERENCES products (id)
          )
        ''');
    await database.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY,
            order_id INTEGER,
            name TEXT,
            price REAL,
            FOREIGN KEY (order_id) REFERENCES products (id)
          )
        ''');
  }
}
