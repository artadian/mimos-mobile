import 'package:flutter/foundation.dart';
import 'package:mimos/PR/model/stock.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class StockDao extends BaseDao {
  StockDao()
      : super(
          table: "stock",
          primaryKey: "id",
        );

  Future<int> insert(Stock data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(Stock data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<Stock> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<Stock> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(Stock data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<Stock> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<Stock>> getAll() async {
    var maps = await super.queryAllData();
    List<Stock> list = maps.isNotEmpty
        ? maps.map((item) => Stock.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<Stock> getById(int id) async {
    return Stock.fromJson(await super.queryGetById(id));
  }

  Future<Stock> getByVisit({
    @required String userid,
    @required String customerno,
    @required String stockdate,
  }) async {
    var db = await instance.database;
    var query = '''
      SELECT * FROM $table 
      WHERE customerno = '$customerno'
        AND userid = '$userid'
        AND stockdate = '$stockdate'
    ''';

    var maps = await db.rawQuery(query);
    if(maps.length > 0) {
      return Stock.fromJson(maps.first);
    }else{
      return null;
    }
  }
}
