import 'package:mimos/PR/model/material_pr.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class MaterialPRDao extends BaseDao {
  MaterialPRDao()
      : super(
    table: "materialfl",
    primaryKey: "matid",
  );

  Future<int> insert(MaterialPR data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(MaterialPR data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<MaterialPR> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<MaterialPR> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(MaterialPR data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<MaterialPR> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<MaterialPR>> getAll() async {
    var maps = await super.queryAllData();
    List<MaterialPR> list = maps.isNotEmpty
        ? maps.map((item) => MaterialPR.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<MaterialPR> getById(int id) async {
    var res = await super.queryGetById(id);
    if (res != null) {
      return MaterialPR.fromJson(res);
    } else {
      return null;
    }
  }
}
