import 'dart:async';
import 'package:mimos/FL/Model/materialModelFL.dart';
import 'package:mimos/db/database.dart';
// import 'package:mimos/TF/Model/lookupmodel.dart';
import 'package:sqflite/sqflite.dart';

class MaterialFLDao {
  final _dbProvider = DatabaseProvider.dbProvider;

  Future<int> countDataMaterial() async {
    final db = await _dbProvider.database;
    //var result = await db.rawQuery("SELECT COUNT(*) FROM customer");
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*)  FROM materialfl'));
    //print(count);
    return count;
  }

  //Searches if query string was passed
  Future<List<MaterialModelFL>> getSelectMaterialFL(
      {List<String> columns, String query}) async {
    final db = await _dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query("materialtf",
            columns: columns,
            where: 'materialname LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query("materialtf", columns: columns);
    }

    List<MaterialModelFL> banyakMaterial = result.isNotEmpty
        ? result.map((item) => MaterialModelFL.fromJson(item)).toList()
        : [];
    return banyakMaterial;
  }

  Future<List<MaterialModelFL>> getSelectMaterial(
      {List<String> columns, String query}) async {
    final db = await _dbProvider.database;
    var strSQL;
    List<Map<String, dynamic>> result;
    strSQL =
        "Select Distinct materialid, materialname, materialgroupid, priceid, price  from materialfl";
    result = await db.rawQuery(strSQL);
    List<MaterialModelFL> material = result.isNotEmpty
        ? result.map((item) => MaterialModelFL.fromJson(item)).toList()
        : [];
    return material;
  }
}
