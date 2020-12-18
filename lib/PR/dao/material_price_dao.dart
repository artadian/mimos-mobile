import 'package:mimos/PR/model/material_price_pr.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class MaterialPricePRDao extends BaseDao {
  MaterialPricePRDao()
      : super(
    table: "price",
    primaryKey: "pricemfid",
  );

  Future<int> insert(MaterialPricePR data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(MaterialPricePR data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<MaterialPricePR> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<MaterialPricePR> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(MaterialPricePR data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<MaterialPricePR> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<MaterialPricePR>> getAll() async {
    var maps = await super.queryAllData();
    List<MaterialPricePR> list = maps.isNotEmpty
        ? maps.map((item) => MaterialPricePR.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<MaterialPricePR> getById(int id) async {
    return MaterialPricePR.fromJson(await super.queryGetById(id));
  }
}
