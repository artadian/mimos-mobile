import 'package:mimos/PR/model/lookup.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class LookupDao extends BaseDao {
  LookupDao()
      : super(
    table: "lookup",
    primaryKey: "lookupid",
  );

  Future<int> insert(Lookup data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(Lookup data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<Lookup> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<Lookup> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(Lookup data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<Lookup> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<Lookup>> getAll() async {
    var maps = await super.queryAllData();
    List<Lookup> list = maps.isNotEmpty
        ? maps.map((item) => Lookup.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<List<Lookup>> getReasonNotVisit() async {
    var db = await instance.database;
    var maps = await db.query(this.table, where: "lookupkey = 'not_visit_reason'");
    List<Lookup> list = maps.isNotEmpty
        ? maps.map((item) => Lookup.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<Lookup> getById(int id) async {
    return Lookup.fromJson(await super.queryGetById(id));
  }
}
