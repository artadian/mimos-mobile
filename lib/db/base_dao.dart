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
    if (data.isNotEmpty) {
      return data.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllData() async {
    var db = await instance.database;
    return await db.query(table);
  }

  Future<List<int>> getAllPrimaryKey() async {
    var db = await instance.database;
    var maps = await db.rawQuery("SELECT $primaryKey FROM $table");
    List<int> list = maps.isNotEmpty
        ? maps.map((item) => item[primaryKey] as int).toList()
        : [];
    return list;
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

  Future<List<Map<String, dynamic>>> needSync() async {
    var db = await instance.database;
    var args = [1, 0, 1];
    var data = await db.query(table,
        where: 'needSync = ? AND isDelete = ? AND isLocal = ?',
        whereArgs: args,
        orderBy: '$primaryKey');
    return data;
  }

  Future<List<Map<String, dynamic>>> needUpdate() async {
    var db = await instance.database;
    var args = [1, 0, 0];
    var data = await db.query(table,
        where: 'needSync = ? AND isDelete = ? AND isLocal = ?',
        whereArgs: args,
        orderBy: '$primaryKey');
    return data;
  }

  Future<List<Map<String, dynamic>>> needDelete() async {
    var db = await instance.database;
    var args = [1, 1, 0];
    var data = await db.query(table,
        where: 'needSync = ? AND isDelete = ? AND isLocal = ?',
        whereArgs: args,
        orderBy: '$primaryKey');
    return data;
  }

  Future<List<int>> needDeleteId() async {
    var db = await instance.database;
    var maps = await db.rawQuery("""
      SELECT $primaryKey FROM $table
      WHERE needSync = 1 AND isDelete = 1 AND isLocal = 0
    """);

    List<int> list = maps.isNotEmpty
        ? maps.map((item) => item[primaryKey] as int).toList()
        : [];
    return list;
  }

  Future<List<Map<String, dynamic>>> needSyncOnly() async {
    var db = await instance.database;
    var data = await db.query(table, where: 'needSync = 1');
    return data;
  }

  Future<int> setNeedSync(int id) async {
    var db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $table SET needSync = 1 WHERE $primaryKey = ?", ['$id']);
  }

  Future<int> resetNeedUpdate(int id) async {
    var db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $table SET needSync = 0 WHERE $primaryKey = ?", ['$id']);
  }

  Future<int> countNeedSync() async {
    var db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table WHERE needSync = 1'));
  }

  Future<int> countNeedSyncIns() async {
    var db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM $table WHERE needSync = 1 AND isLocal = 1'));
  }

  Future<bool> isNeedSync() async {
    var db = await instance.database;
    var res = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM $table WHERE needSync = 1 AND isLocal = 1'));
    return res > 0;
  }

  Future<bool> isNeedSyncOnly() async {
    var db = await instance.database;
    var res = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM $table WHERE needSync = 1'));
    return res > 0;
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

  Future<int> _deleteLocal(int id) async {
    var db = await instance.database;
    return await db.delete(table, where: '$primaryKey = ?', whereArgs: ['$id']);
  }

  Future<int> _deleteServer(int id) async {
    var db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $table SET isDelete = 1, needSync = 1 WHERE $primaryKey = ?",
        ['$id']);
  }

  Future<int> delete(int id, {local = false}) async {
    var db = await instance.database;
    if (local) return await _deleteLocal(id);
    var select = await db.query(table,
        where: '$primaryKey = ? AND isLocal = 1', whereArgs: ['$id']);
    if (select.isNotEmpty)
      return await _deleteLocal(id);
    else
      return await _deleteServer(id);
  }

  Future<List<int>> deleteBy(
      {@required String column, @required String value}) async {
    var db = await instance.database;

    var rows =
        await db.query(table, where: '$column = ?', whereArgs: ['$value']);

    var result = List<int>();
    await Future.wait(rows.map((row) async {
      try {
        if (row["isLocal"] == 1)
          await _deleteLocal(row['$primaryKey']);
        else
          await _deleteServer(row['$primaryKey']);

        result.add(1);
      } catch (e) {
        result.add(0);
        print("$runtimeType deleteBy ERROR: $e");
      }
    }));
    return result;
  }

  Future truncateSync() async {
    final db = await instance.database;
    return await db.delete(table, where: "needSync = 0");
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
