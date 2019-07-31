import 'dart:async';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class SettingsDatabase {
  static final _dbFilename = "common_settings.db";
  static final _dbVersion = 1;
  static final _tableName = "common_settings";
  static final _id = "id";
  static final _value = "value";

  SettingsDatabase._privateConstructor();

  static final SettingsDatabase instance =
      SettingsDatabase._privateConstructor();

  Database _db;
  final _lock = Lock();

  Future<Database> _getDb() async {
    if (_db == null) {
      await _lock.synchronized(() async {
        if (_db == null) {
          final dbPath = path.join(await getDatabasesPath(), _dbFilename);
          _db = await openDatabase(dbPath,
              onCreate: _onCreate, version: _dbVersion);
        }
      });
    }
    return _db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $_tableName ($_id TEXT PRIMARY KEY, $_value TEXT)",
    );
  }

  Future<String> getValue(String key) async {
    final db = await _getDb();
    final List<Map<String, dynamic>> result =
        await db.query(_tableName, where: "$_id = ?", whereArgs: [key]);

    if (result.length > 0) {
      return result[0][_value];
    }
    return null;
  }

  void setValue(String key, String value) async {
    Map<String, String> values = Map();
    values[_id] = key;
    values[_value] = value;
    final db = await _getDb();
    db.insert(_tableName, values, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
