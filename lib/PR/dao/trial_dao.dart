import 'package:mimos/PR/model/trial.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class TrialDao extends BaseDao {
  TrialDao()
      : super(
    table: "trial",
    primaryKey: "id",
  );

  Future<int> insert(Trial data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(Trial data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<Trial> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<Trial> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(Trial data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<Trial> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<Trial>> getAll() async {
    var maps = await super.queryAllData();
    List<Trial> list = maps.isNotEmpty
        ? maps.map((item) => Trial.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<List<Trial>> getAllTrial() async {
    var db = await instance.database;
    var query = """
      SELECT t.*, l.lookupdesc
      FROM trial AS t 
      LEFT JOIN lookup AS l ON t.trialtype = l.lookupvalue AND l.lookupkey = 'trial_type'
      WHERE isDelete = 0
    """;

    var maps = await db.rawQuery(query);
    List<Trial> list = maps.isNotEmpty
        ? maps.map((item) => Trial.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<Trial> getById(int id) async {
    var res = await super.queryGetById(id);
    if (res != null) {
      return Trial.fromJson(res);
    } else {
      return null;
    }
  }

}
