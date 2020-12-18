import 'package:mimos/PR/model/visit.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class VisitDao extends BaseDao {
  VisitDao()
      : super(
    table: "visit",
    primaryKey: "id",
  );

  Future<int> insert(Visit data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(Visit data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<Visit> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<Visit> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(Visit data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<Visit> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<Visit>> getAll() async {
    var maps = await super.queryAllData();
    List<Visit> list = maps.isNotEmpty
        ? maps.map((item) => Visit.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<Visit> getById(int id) async {
    return Visit.fromJson(await super.queryGetById(id));
  }
}
