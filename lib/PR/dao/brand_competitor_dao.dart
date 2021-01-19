import 'package:mimos/PR/model/brand_competitor.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class BrandCompetitorDao extends BaseDao {
  BrandCompetitorDao()
      : super(
    table: "brand_competitor",
    primaryKey: "id",
  );

  Future<int> insert(BrandCompetitor data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(BrandCompetitor data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<BrandCompetitor> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<BrandCompetitor> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(BrandCompetitor data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<BrandCompetitor> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<BrandCompetitor>> getAll() async {
    var maps = await super.queryAllData();
    List<BrandCompetitor> list = maps.isNotEmpty
        ? maps.map((item) => BrandCompetitor.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<BrandCompetitor> getById(int id) async {
    var res = await super.queryGetById(id);
    if (res != null) {
      return BrandCompetitor.fromJson(res);
    } else {
      return null;
    }
  }
}
