import 'dart:async';
import 'package:mimos/db/database.dart';
import 'package:mimos/TF/Model/materialmodeltf.dart';
import 'package:sqflite/sqflite.dart';

class MaterialDaoTF{
  final _dbProvider = DatabaseProvider.dbProvider;
   //Adds new Todo records
   Future<int>insertMaterialTD(MaterialModelTF _customer) async{
     final db = await _dbProvider.database;
    var result = db.insert("materialtf", _customer.toDatabaseJson());
    return result;
   }

   //Get All Todo items
  //Searches if query string was passed
  Future<List<MaterialModelTF>> getSelectMaterialTF({List<String> columns, String query}) async {
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

    List<MaterialModelTF> banyakMaterial = result.isNotEmpty
        ? result.map((item) => MaterialModelTF.cretaeMaterialFromJson(item)).toList()
        : [];
    return banyakMaterial;
  }

  Future<List<MaterialModelTF>> getSelectMaterialGroup({List<String> columns, String query}) async {
    final db = await _dbProvider.database;
var strSQL;
    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
      strSQL = "Select Distinct materialgroupid, materialgroupdescription from materialtf where materialgroupname like '%"+ query +"%' ";
    } else {
      strSQL = "Select Distinct materialgroupid, materialgroupdescription from materialtf ";
    }
result = await db.rawQuery(strSQL);
    List<MaterialModelTF> materialGroup = result.isNotEmpty
        ? result.map((item) => MaterialModelTF.cretaeMaterialFromJson(item)).toList()
        : [];
    return materialGroup;
  }

  //Update Todo record
  Future<int> updateMaterialTF(MaterialModelTF _materialtf) async {
    final db = await _dbProvider.database;

    var result = await db.update("materialtf", _materialtf.toDatabaseJson(),
        where: "materialid = ?", whereArgs: [_materialtf.materialid]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteMaterialTF(String id) async {
    final db = await _dbProvider.database;
    var result = await db.delete("materialtf", where: 'materialid = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllMaterialTF() async {
    final db = await _dbProvider.database;
    var result = await db.delete(
      "materialtf",
    );

    return result;
  }

  Future <int> countDataMaterialTF() async{
    final db = await _dbProvider.database;
    //var result = await db.rawQuery("SELECT COUNT(*) FROM customer");
    int count =  Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*)  FROM materialtf'));
    //print(count);
    return count;
  }

}