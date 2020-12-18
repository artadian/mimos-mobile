import 'package:flutter/foundation.dart';
import 'package:mimos/db/database.dart';
import 'package:mimos/helper/extension.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDao {
  final DatabaseProvider instance = DatabaseProvider.dbProvider;
  final String table;
  final String primaryKey;

  BaseDao({@required this.table, @required this.primaryKey});

  Future<Database> db() async => await instance.database;

  Future<int> queryInsert(Map<String, dynamic> row,
      {ConflictAlgorithm conflictAlgorithm}) async {
    var db = await instance.database;
    return await db.insert(
      table,
      row,
      conflictAlgorithm: conflictAlgorithm ?? ConflictAlgorithm.replace,
    );
  }

  Future<List<int>> queryInsertAll(List<Map<String, dynamic>> rows,
      {ConflictAlgorithm conflictAlgorithm}) async {
    var db = await instance.database;
    var result = List<int>();
    await Future.wait(rows.map((row) async {
      try {
        var res = await db.insert(
          table,
          row,
          conflictAlgorithm: conflictAlgorithm ?? ConflictAlgorithm.replace,
        );
        result.add(res);
      } catch (e) {
        result.add(0);
        print("$runtimeType queryInsertAll ERROR: $e");
      }
    }));
    return result;
  }

  Future<int> queryUpdate(Map<String, dynamic> row) async {
    var db = await instance.database;
    int id = row[primaryKey];
    return await db
        .update(table, row, where: '$primaryKey = ?', whereArgs: ['$id']);
  }

  Future<List<int>> queryUpdateAll(List<Map<String, dynamic>> rows) async {
    var db = await instance.database;
    var result = List<int>();
    await Future.wait(rows.map((row) async {
      try {
        int id = row[primaryKey];
        var res = await db
            .update(table, row, where: '$primaryKey = ?', whereArgs: ['$id']);
        result.add(res);
      } catch (e) {
        result.add(0);
        print("$runtimeType queryUpdateAll ERROR: $e");
      }
    }));
    return result;
  }

  Future<Map<String, dynamic>> queryGetById(int id) async {
    var db = await instance.database;
    var data =
    await db.query(table, where: '$primaryKey = ?', whereArgs: ['$id']);
    return data.first;
  }

  Future<List<Map<String, dynamic>>> queryAllData() async {
    var db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> rawSelect(
      {List<String> selectedColumn,
        String whereQuery,
        List<dynamic> args,
        String groupByColumn,
        String orderBy,
        String having,
        int limitData,
        int offsetData,
        bool distinct}) async {
    var db = await instance.database;
    return await db.query(table,
        columns: selectedColumn ?? null,
        where: whereQuery ?? null,
        whereArgs: args ?? null,
        groupBy: groupByColumn ?? null,
        limit: limitData ?? 9999,
        offset: offsetData ?? 0,
        having: having ?? null,
        orderBy: orderBy ?? null,
        distinct: distinct ?? false);
  }

  Future<int> rawInsert(String query, List<dynamic> args) async {
    final db = await instance.database;
    return await db.rawInsert(query, args);
  }

  Future<int> rawUpdate(String query, List<dynamic> args) async {
    final db = await instance.database;
    return await db.rawUpdate(query, args);
  }

  Future<int> countBy({String column, String value}) async {
    var db = await instance.database;
    return Sqflite.firstIntValue(await db
        .rawQuery("SELECT COUNT(*) FROM $table WHERE $column = '$value'"));
  }

  Future<int> count() async {
    var db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> delete(int id) async {
    var db = await instance.database;
    return await db.delete(table, where: '$primaryKey = ?', whereArgs: ['$id']);
  }

  Future truncate() async {
    final db = await instance.database;
    return await db.delete(table);
  }

  Future close() async {
    final db = await instance.database;
    return db.close();
  }
}
