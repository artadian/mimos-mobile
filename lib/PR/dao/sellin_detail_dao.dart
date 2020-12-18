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
}
