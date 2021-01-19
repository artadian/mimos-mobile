import 'package:flutter/foundation.dart';
import 'package:mimos/PR/model/visibility_detail.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class VisibilityDetailDao extends BaseDao {
  VisibilityDetailDao()
      : super(
    table: "visibility_detail",
    primaryKey: "id",
  );

  Future<int> insert(VisibilityDetail data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(VisibilityDetail data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<VisibilityDetail> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<VisibilityDetail> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(VisibilityDetail data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<VisibilityDetail> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<VisibilityDetail>> getAll() async {
    var maps = await super.queryAllData();
    List<VisibilityDetail> list = maps.isNotEmpty
        ? maps.map((item) => VisibilityDetail.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<VisibilityDetail> getById(int id) async {
    var res = await super.queryGetById(id);
    if (res != null) {
      return VisibilityDetail.fromJson(res);
    } else {
      return null;
    }
  }

  Future<List<VisibilityDetail>> getByParent({@required int visibilityid}) async {
    var db = await instance.database;
    var query = '''
      SELECT * FROM $table
      WHERE visibilityid = $visibilityid
      AND isDelete = 0
    ''';

    var maps = await db.rawQuery(query);
    List<VisibilityDetail> list = maps.isNotEmpty
        ? maps.map((item) => VisibilityDetail.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<int> updateIdParent({@required int id, @required int newId}) async {
    var db = await instance.database;
    return await db.update(table, {"visibilityid": newId},
        where: "visibilityid == $id");
  }

  Future<List<VisibilityDetail>> getByParentAndMaterial(
      {@required int visibilityid, @required String materialid}) async {
    var db = await instance.database;
    var query = """
      SELECT * FROM $table
      WHERE visibilityid = $visibilityid
      AND materialid = '$materialid'
      AND isDelete = 0
    """;

    var maps = await db.rawQuery(query);
    List<VisibilityDetail> list = maps.isNotEmpty
        ? maps.map((item) => VisibilityDetail.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<List<int>> deleteByVisibility(String visibilityid) async {
    var res = await super.deleteBy(column: "visibilityid", value: visibilityid);
    return res;
  }

}
