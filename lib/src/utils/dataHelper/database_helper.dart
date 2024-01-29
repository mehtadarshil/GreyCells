import 'dart:io';

import 'package:greycell_app/src/config/core_config.dart';
import 'package:greycell_app/src/utils/dataHelper/table_columns.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? instance;
  static final _databaseName = "${Core.APPNAME}.db";
  static final _databaseVersion = 1;
  static Database? _database;

  DatabaseHelper._privateConstructor();

  DatabaseHelper() {
    instance == null
        ? instance = DatabaseHelper._privateConstructor()
        : instance;
  }

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE ${SchoolTable.tableName} (
            ${SchoolTable.colId} TEXT PRIMARY KEY,
            ${SchoolTable.colFullName} TEXT NOT NULL,
            ${SchoolTable.colName} TEXT NOT NULL,
            ${SchoolTable.colCode} TEXT ,
            ${SchoolTable.colServerAddress} TEXT NOT NULL,
            ${SchoolTable.colStatus} TEXT,            
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = (await instance!.database)!;
    print(row);
    return await db.insert(SchoolTable.tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = (await instance!.database)!;
    return await db.query(SchoolTable.tableName);
  }

  Future<int?> queryRowCount() async {
    Database db = (await instance!.database)!;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM ${SchoolTable.tableName}'));
  }

  Future<int> deleteDB() async {
    Database db = (await instance!.database)!;

    return db.delete(SchoolTable.tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = (await instance!.database)!;
    int? id = row[SchoolTable.colId];
    return await db.update(SchoolTable.tableName, row,
        where: '${SchoolTable.colId} = ?', whereArgs: [id]);
  }

  Future<int> updateNewUser(Map<String, dynamic> row) async {
    Database db = (await instance!.database)!;
    print(row);
    String? id = row[SchoolTable.colId];
    return await db.update(SchoolTable.tableName, row,
        where: '${SchoolTable.colId} = ?', whereArgs: [id]);
  }

  Future<int> delete(String id) async {
    Database db = (await instance!.database)!;
    print("Token From Database: $id");
    int result = await db.delete(SchoolTable.tableName,
        where: '${SchoolTable.colId} = ?', whereArgs: [id]);
    return result;
  }
}
