import 'package:mimos/PR/model/material_price.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class MaterialPriceDao extends BaseDao {
  MaterialPriceDao()
      : super(
    table: "material_price",
    primaryKey: "id",
  );

  Future<int> insert(MaterialPrice data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(MaterialPrice data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<MaterialPrice> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<MaterialPrice> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(MaterialPrice data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<MaterialPrice> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<MaterialPrice>> getAll() async {
    var maps = await super.queryAllData();
    List<MaterialPrice> list = maps.isNotEmpty
        ? maps.map((item) => MaterialPrice.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<List<MaterialPrice>> getByPriceIdCust(String priceid) async {
    var db = await instance.database;
    var maps = await db.query(table, where: "priceid = '$priceid'");
    List<MaterialPrice> list = maps.isNotEmpty
        ? maps.map((item) => MaterialPrice.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<MaterialPrice> getById(int id) async {
    var maps = await super.queryGetById(id);
    return MaterialPrice.fromJson(maps);
  }

  Future<MaterialPrice> getByMaterialId(int id) async {
    var db = await instance.database;
    var maps =
    await db.query(table, where: 'materialid = ?', whereArgs: ['$id']);
    return MaterialPrice.fromJson(maps.first);
  }
}
