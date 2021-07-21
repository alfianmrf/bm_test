import 'dart:async';
import 'dart:io';

import 'package:bm_test/Data.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = 'Database.db';
  static final _dbVersion = 2;
  static final _tableName = 'mytable';

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initiateDatabase();

  Future<Database> _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onOpen: (db) {}, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $_tableName ("
        "date TEXT PRIMARY KEY,"
        "label TEXT,"
        "nb_visits INTEGER,"
        "nb_hits INTEGER,"
        "sum_time_spent INTEGER,"
        "nb_hits_with_time_generation INTEGER,"
        "min_time_generation TEXT,"
        "max_time_generation TEXT,"
        "sum_bandwidth INTEGER,"
        "nb_hits_with_bandwidth INTEGER,"
        "min_bandwidth INTEGER,"
        "max_bandwidth INTEGER,"
        "sum_daily_nb_uniq_visitors INTEGER,"
        "entry_nb_visits INTEGER,"
        "entry_nb_actions INTEGER,"
        "entry_sum_visit_length INTEGER,"
        "entry_bounce_count INTEGER,"
        "exit_nb_visits INTEGER,"
        "sum_daily_entry_nb_uniq_visitors INTEGER,"
        "sum_daily_exit_nb_uniq_visitors INTEGER,"
        "avg_bandwidth INTEGER,"
        "avg_time_on_page INTEGER,"
        "bounce_rate STRING,"
        "exit_rate STRING,"
        "avg_time_generation DOUBLE"
        ")");
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<DataModel>> getData(String? date) async {
    final db = await database;
    var res = await db.query(_tableName, where: "date = ?", whereArgs: [date]);
    List<DataModel> list = res.isNotEmpty ? res.map((c) => DataModel.fromJson(c, date)).toList() : [];
    return list;
  }

  Future<int> delete() async {
    Database db = await instance.database;
    return await db.delete(_tableName);
  }
}