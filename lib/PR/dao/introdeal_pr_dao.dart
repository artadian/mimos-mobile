import 'package:mimos/PR/model/introdeal_pr.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class IntrodealPRDao extends BaseDao {
  IntrodealPRDao()
      : super(
    table: "introdeal",
    primaryKey: "intromfid",
  );

  Future<int> insert(IntrodealPR data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(IntrodealPR data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<IntrodealPR> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<IntrodealPR> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(IntrodealPR data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<IntrodealPR> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<IntrodealPR>> getAll() async {
    var maps = await super.queryAllData();
    List<IntrodealPR> list = maps.isNotEmpty
        ? maps.map((item) => IntrodealPR.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<IntrodealPR> getById(int id) async {
    return IntrodealPR.fromJson(await super.queryGetById(id));
  }
}
