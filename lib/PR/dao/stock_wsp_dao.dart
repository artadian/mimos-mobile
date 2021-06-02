import 'package:flutter/foundation.dart';
import 'package:mimos/PR/model/stock_wsp.dart';
import 'package:mimos/PR/model/view/material_price_view.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class StockWspDao extends BaseDao {
  StockWspDao()
      : super(
          table: "stock_wsp",
          primaryKey: "id",
        );

  Future<int> insert(StockWsp data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(StockWsp data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<StockWsp> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<StockWsp> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(StockWsp data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<StockWsp> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<StockWsp>> getAll() async {
    var maps = await super.queryAllData();
    List<StockWsp> list = maps.isNotEmpty
        ? maps.map((item) => StockWsp.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<StockWsp> getById(int id) async {
    var res = await super.queryGetById(id);
    if (res != null) {
      return StockWsp.fromJson(res);
    } else {
      return null;
    }
  }

  Future<StockWsp> getByMaterialGroup({
    @required String materialgroupid,
  }) async {
    var db = await instance.database;
    var query = '''
      SELECT stock_wsp
      WHERE materialgroupid = '$materialgroupid'
    ''';

    var res = await db.rawQuery(query);
    if (res != null) {
      return StockWsp.fromJson(res.first);
    } else {
      return null;
    }
  }

  Future<StockWsp> getByCustAndGroup({
    @required String materialgroupid,
    @required String customerno,
  }) async {
    var db = await instance.database;
    var query = '''
      SELECT * FROM stock_wsp s
      JOIN customer_wsp c
      ON c.materialgroupid = s.materialgroupid
      AND c.wspclass = s.wspclass
      WHERE customerno = '$customerno'
      AND s.materialgroupid = '$materialgroupid'
    ''';

    var res = await db.rawQuery(query);
    if (res.isNotEmpty) {
      return StockWsp.fromJson(res.first);
    } else {
      return null;
    }
  }

  Future<StockWsp> getByMaterial({
    @required String materialid,
    @required String priceid,
  }) async {
    var db = await instance.database;
    var query = '''
      SELECT sw.* FROM material_price as m
      JOIN stock_wsp as sw ON sw.materialgroupid = m.materialgroupid
      WHERE materialid = '$materialid'
      AND priceid = '$priceid'
    ''';

    var res = await db.rawQuery(query);
    if (res != null) {
      return StockWsp.fromJson(res.first);
    } else {
      return null;
    }
  }

  Future<List<MaterialPriceView>> getMaterialWspInCustomer({
    @required String materialid,
    @required String priceid,
  }) async {
    var db = await instance.database;
    var query = '''
      SELECT m.*, sw.pac as wsppac FROM material_price as m
      JOIN stock_wsp as sw ON sw.materialgroupid = m.materialgroupid
      WHERE m.priceid = '$priceid'
      AND sw.materialgroupid IN (
        SELECT materialgroupid 
        FROM stock_wsp
        WHERE materialgroupidwsp IN 
        (
          SELECT materialgroupid 
          FROM customer_wsp 
          WHERE customerno = '$materialid'
        )
      )
    ''';

    var maps = await db.rawQuery(query);
    List<MaterialPriceView> list = maps.isNotEmpty
        ? maps.map((item) => MaterialPriceView.fromJson(item)).toList()
        : [];
    return list;
  }
}
