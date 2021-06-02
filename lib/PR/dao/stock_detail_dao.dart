import 'package:flutter/foundation.dart';
import 'package:mimos/PR/model/stock_detail.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimos/helper/extension.dart';

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
    var res = await super.queryGetById(id);
    if (res != null) {
      return StockDetail.fromJson(res);
    } else {
      return null;
    }
  }

  Future<int> updateIdParent({@required int id, @required int newId}) async {
    var db = await instance.database;
    return await db.update(table, {"stockid": newId}, where: "stockid == $id");
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

  Future<int> getStockCustByMGroup({
    @required String customerno,
    @required String stockdate,
    @required String materialgroupid,
    @required String priceid,
  }) async {
    var db = await instance.database;
    var query = '''
      SELECT SUM(d.qty) as stock FROM stock_detail d
      JOIN stock s ON s.id = d.stockid
      JOIN material_price m ON m.materialid = d.materialid
      WHERE customerno = '$customerno'
        AND s.stockdate = '$stockdate'
        AND m.materialgroupid = '$materialgroupid'
        AND m.priceid = '$priceid'
        AND d.isDelete = 0
	    GROUP BY m.id
    ''';

    var res = await db.rawQuery(query);
    print("getStockCustByMGroup: $res");
    if (res.isNotEmpty) {
      if (res.first != null) {
        return res.first["stock"].toString().toInt();
      } else {
        return 0;
      }
    } else {
      return 0;
    }
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
