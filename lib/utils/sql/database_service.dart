import 'package:sqflite/sqflite.dart';

abstract class DatabaseService {
  Future<Database> get database;

  Future<Database> initialize();

  Future<void> create(Database database, int version);

  Future<void> insertInitialData(Database database);

  void upgrade(Database database, int oldVersion, int newVersion);
}
