import 'package:flutter/foundation.dart';
import 'package:mimos/PR/model/posm.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class PosmDao extends BaseDao {
  PosmDao()
      : super(
    table: "posm",
    primaryKey: "id",
  );

  Future<int> insert(Posm data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(Posm data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<Posm> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<Posm> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(Posm data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<Posm> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<Posm>> getAll() async {
    var maps = await super.queryAllData();
    List<Posm> list = maps.isNotEmpty
        ? maps.map((item) => Posm.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<Posm> getById(int id) async {
    return Posm.fromJson(await super.queryGetById(id));
  }

  Future<Posm> getByVisit({
    @required String userid,
    @required String customerno,
    @required String posmdate,
  }) async {
    var db = await instance.database;
    var query = '''
      SELECT * FROM $table 
      WHERE customerno = '$customerno'
        AND userid = '$userid'
        AND posmdate = '$posmdate'
    ''';

    var maps = await db.rawQuery(query);
    if(maps.length > 0) {
      return Posm.fromJson(maps.first);
    }else{
      return null;
    }
  }
}
