import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class DatabaseHelper {
  static const String _databaseName = "notes.db";
  static const int _databaseVersion = 1;
  static const String _tableName = "notes";

  static String columnId = "id";
  static String columnTitle = "title";
  static String columnDescription = "description";
  static String columnCreatedAt = "created_at";
  static String columnUpdatedAt = "updated_at";

  static Database? _db;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDatabase();
      return _db;
    }
  }

  Future<Database> initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, _databaseName);

    var db =
        openDatabase(path, version: _databaseVersion, onCreate: _createTable);
    return db;
  }

  FutureOr<void> _createTable(Database db, int version) async {
    await db.execute('''
       CREATE TABLE $_tableName (
       $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT,
         $columnDescription TEXT,
         $columnCreatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
         $columnUpdatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
         )
      ''');
  }

  Future<int?> insertData({required Map<String, dynamic> rowData}) async {
    Database? db = await instance.db;
    return await db?.insert(_tableName, rowData);
  }

  Future<int?> createEmptyRow() async {
    Database? db = await instance.db;
    return await db?.rawInsert("INSERT INTO $_tableName DEFAULT VALUES");
  }

  Future<List<Map<String, dynamic>>?> getAllData() async {
    Database? db = await instance.db;
    return await db?.query(_tableName);
  }

  Future<List<Map<String, dynamic>>?> getDataById({required int id}) async {
    Database? db = await instance.db;
    return await db?.query(_tableName, where: "$columnId = $id");
  }

  Future<int?> updateData({required Map<String, dynamic> rowData, required int id}) async {
    Database? db = await instance.db;
    return await db?.update(_tableName, rowData, where: "$columnId = $id");
  }

  Future<int?> deleteData({required int id}) async {
    Database? db = await instance.db;
    return await db?.delete(_tableName, where: "$columnId = $id");
  }
}
