import 'package:injectable/injectable.dart';
import 'package:order_keeper/utils/sql/database_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

@LazySingleton(as: DatabaseService)
class DatabaseServiceImpl implements DatabaseService {
  late Database _database;

  @override
  Future<Database> get database async {
    // if (_database.isOpen) {
    //   return _database;
    // } else {
    _database = await initialize();
    return _database;
    // }
  }

  Future<String> get fullPath async {
    const name = 'order_keeper.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  @override
  Future<Database> initialize() async {
    final path = await fullPath;
    print('Database path: $path');

    try {
      var database = await openDatabase(path,
          version: 1, onCreate: create, onUpgrade: upgrade);
      print('Database created successfully');
      return database;
    } catch (e) {
      print('Error creating database: $e');
      rethrow;
    }
  }

  @override
  Future<void> create(Database database, int version) async {
    print('Creating tables...');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `tables` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT)');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `products` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `price` TEXT)');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `orders` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `table_id` INTEGER, `product_id` INTEGER, `quantity` INTEGER)');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `OrderResponse` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `table_id` INTEGER, `quantity` INTEGER, `product_name` TEXT, `product_price` TEXT)');

    print('Tables created successfully');

    // Добавляем начальные данные
    await insertInitialData(database);
  }

  @override
  void upgrade(Database database, int oldVersion, int newVersion) async {
    // Логика обновления базы данных, если когда-то потребуется
  }

  @override
  Future<void> insertInitialData(Database db) async {
    // Заполнение таблицы "tables" начальными данными, если она пуста
    List<Map<String, dynamic>> tables = await db.query('tables');
    if (tables.isEmpty) {
      await db.insert('tables', {'name': 'Table 1'});
      await db.insert('tables', {'name': 'Table 2'});
      await db.insert('tables', {'name': 'Table 3'});
      await db.insert('tables', {'name': 'Table 4'});
      await db.insert('tables', {'name': 'Table 5'});
      // Добавьте здесь другие записи, если необходимо
    }

    // Заполнение таблицы "products" начальными данными, если она пуста
    List<Map<String, dynamic>> products = await db.query('products');
    if (products.isEmpty) {
      await db.insert('products', {'name': 'Product 1', 'price': '10.99'});
      await db.insert('products', {'name': 'Product 2', 'price': '5.99'});
      // Добавьте здесь другие записи, если необходимо
    }

    // Заполнение таблицы "orders" начальными данными, если она пуста
    List<Map<String, dynamic>> orders = await db.query('orders');
    if (orders.isEmpty) {
      // В данном примере просто добавим несколько заказов для каждого стола
      // Вы можете адаптировать этот код под ваши нужды
      for (int i = 1; i <= 2; i++) {
        await db
            .insert('orders', {'table_id': i, 'product_id': 1, 'quantity': 2});
        await db
            .insert('orders', {'table_id': i, 'product_id': 2, 'quantity': 1});
      }
    }

    // Заполнение таблицы "OrderResponse" начальными данными, если она пуста
    List<Map<String, dynamic>> orderResponses = await db.query('OrderResponse');
    if (orderResponses.isEmpty) {
      // Просто примеры для демонстрации
      await db.insert('OrderResponse', {
        'table_id': 1,
        'quantity': 2,
        'product_name': 'Product 1',
        'product_price': '10.99'
      });
      await db.insert('OrderResponse', {
        'table_id': 1,
        'quantity': 1,
        'product_name': 'Product 2',
        'product_price': '5.99'
      });
      await db.insert('OrderResponse', {
        'table_id': 2,
        'quantity': 1,
        'product_name': 'Product 1',
        'product_price': '10.99'
      });
      // Добавьте здесь другие записи, если необходимо
    }
  }
}
