import 'package:flutter/foundation.dart';
import 'package:mimos/PR/model/visibility_model.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class VisibilityDao extends BaseDao {
  VisibilityDao()
      : super(
    table: "visibility_head",
    primaryKey: "id",
  );

  Future<int> insert(VisibilityModel data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(VisibilityModel data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<VisibilityModel> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<VisibilityModel> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(VisibilityModel data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<VisibilityModel> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<VisibilityModel>> getAll() async {
    var maps = await super.queryAllData();
    List<VisibilityModel> list = maps.isNotEmpty
        ? maps.map((item) => VisibilityModel.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<VisibilityModel> getById(int id) async {
    var res = await super.queryGetById(id);
    if (res != null) {
      return VisibilityModel.fromJson(res);
    } else {
      return null;
    }
  }

  Future<VisibilityModel> getByVisit({
    @required String userid,
    @required String customerno,
    @required String visibilitydate,
  }) async {
    var db = await instance.database;
    var query = '''
      SELECT * FROM $table 
      WHERE customerno = '$customerno'
        AND userid = '$userid'
        AND visibilitydate = '$visibilitydate'
    ''';

    var maps = await db.rawQuery(query);
    if(maps.length > 0) {
      return VisibilityModel.fromJson(maps.first);
    }else{
      return null;
    }
  }

}
