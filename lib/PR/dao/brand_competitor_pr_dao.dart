import 'package:mimos/PR/model/brand_competitor_pr.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class BrandCompetitorPRDao extends BaseDao {
  BrandCompetitorPRDao()
      : super(
    table: "competitor",
    primaryKey: "id",
  );

  Future<int> insert(BrandCompetitorPR data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(BrandCompetitorPR data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<BrandCompetitorPR> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<BrandCompetitorPR> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(BrandCompetitorPR data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<BrandCompetitorPR> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<BrandCompetitorPR>> getAll() async {
    var maps = await super.queryAllData();
    List<BrandCompetitorPR> list = maps.isNotEmpty
        ? maps.map((item) => BrandCompetitorPR.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<BrandCompetitorPR> getById(int id) async {
    return BrandCompetitorPR.fromJson(await super.queryGetById(id));
  }
}
