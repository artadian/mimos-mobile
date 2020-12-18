import 'package:mimos/PR/model/sellin.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class SellinDao extends BaseDao {
  SellinDao()
      : super(
    table: "sellin",
    primaryKey: "id",
  );

  Future<int> insert(Sellin data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(Sellin data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<Sellin> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<Sellin> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(Sellin data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<Sellin> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<Sellin>> getAll() async {
    var maps = await super.queryAllData();
    List<Sellin> list = maps.isNotEmpty
        ? maps.map((item) => Sellin.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<Sellin> getById(int id) async {
    return Sellin.fromJson(await super.queryGetById(id));
  }
}
