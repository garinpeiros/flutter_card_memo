import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final _databaseVersion = 1;
  static final _databaseName = "memo.db";
  static final memoTableName = "memo";
  static final DatabaseService dbProvider = DatabaseService();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    var database = await openDatabase(path,
        version: _databaseVersion, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute('''
      CREATE TABLE $memoTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        d_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        c_id INTEGER NOT NULL
    )''');
  }
}
