import 'package:flutter/foundation.dart';
import 'package:mimos/PR/model/sellin_detail.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class SellinDetailDao extends BaseDao {
  SellinDetailDao()
      : super(
          table: "sellin_detail",
          primaryKey: "id",
        );

  Future<int> insert(SellinDetail data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(SellinDetail data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<SellinDetail> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<SellinDetail> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(SellinDetail data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<SellinDetail> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<SellinDetail>> getAll() async {
    var maps = await super.queryAllData();
    List<SellinDetail> list = maps.isNotEmpty
        ? maps.map((item) => SellinDetail.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<SellinDetail> getById(int id) async {
    return SellinDetail.fromJson(await super.queryGetById(id));
  }

  Future<int> updateIdParent({@required int id, @required int newId}) async {
    var db = await instance.database;
    return await db.update(table, {"sellinid": newId},
        where: "sellinid == $id");
  }

  Future<List<SellinDetail>> getByParent({@required int sellinid}) async {
    var db = await instance.database;
    var query = '''
      SELECT * FROM $table
      WHERE sellinid = $sellinid
    ''';

    var maps = await db.rawQuery(query);
    List<SellinDetail> list = maps.isNotEmpty
        ? maps.map((item) => SellinDetail.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<List<SellinDetail>> getByParentAndMaterial(
      {@required int sellinid, @required String materialid}) async {
    var db = await instance.database;
    var query = """
      SELECT * FROM $table
      WHERE sellinid = $sellinid
      AND materialid = '$materialid'
      AND isDelete = 0
    """;

    var maps = await db.rawQuery(query);
    List<SellinDetail> list = maps.isNotEmpty
        ? maps.map((item) => SellinDetail.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<List<int>> deleteBySellin(String sellinid) async {
    var res = await super.deleteBy(column: "sellinid", value: sellinid);
    return res;
  }

  Future<List<SellinDetail>> getByManyParent(
      {@required List<int> sellinids}) async {
    var db = await instance.database;
    var ids = sellinids.toString().replaceAll("[", "").replaceAll("]", "");
    var query = '''
      SELECT * FROM $table
      WHERE sellinid IN ($ids)
    ''';

    var maps = await db.rawQuery(query);
    List<SellinDetail> list = maps.isNotEmpty
        ? maps.map((item) => SellinDetail.fromJson(item)).toList()
        : [];
    return list;
  }
}
