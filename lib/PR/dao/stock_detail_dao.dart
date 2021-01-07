import 'package:flutter/foundation.dart';
import 'package:mimos/PR/model/stock_detail.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class StockDetailDao extends BaseDao {
  StockDetailDao()
      : super(
          table: "stock_detail",
          primaryKey: "id",
        );

  Future<int> insert(StockDetail data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(StockDetail data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<StockDetail> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<StockDetail> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(StockDetail data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<StockDetail> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<StockDetail>> getAll() async {
    var maps = await super.queryAllData();
    List<StockDetail> list = maps.isNotEmpty
        ? maps.map((item) => StockDetail.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<StockDetail> getById(int id) async {
    return StockDetail.fromJson(await super.queryGetById(id));
  }

  Future<int> updateIdParent({@required int id, @required int newId}) async {
    var db = await instance.database;
    return await db.update(table, {"stockid": newId},
        where: "stockid == $id");
  }

  Future<List<StockDetail>> getByParent({@required int stockid}) async {
    var db = await instance.database;
    var query = '''
      SELECT * FROM $table
      WHERE stockid = $stockid
      AND isDelete = 0
    ''';

    var maps = await db.rawQuery(query);
    List<StockDetail> list = maps.isNotEmpty
        ? maps.map((item) => StockDetail.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<List<StockDetail>> getByParentAndMaterial(
      {@required int stockid, @required String materialid}) async {
    var db = await instance.database;
    var query = """
      SELECT * FROM $table
      WHERE stockid = $stockid
      AND materialid = '$materialid'
      AND isDelete = 0
    """;

    var maps = await db.rawQuery(query);
    List<StockDetail> list = maps.isNotEmpty
        ? maps.map((item) => StockDetail.fromJson(item)).toList()
        : [];
    return list;
  }
}
