import 'dart:async';
import 'package:mimos/FL/Model/brandCompetitorModelFL.dart';
import 'package:mimos/db/database.dart';
// import 'package:mimos/TF/Model/lookupmodel.dart';
import 'package:sqflite/sqflite.dart';

class BrandCompetitorDao {
  final _dbProvider = DatabaseProvider.dbProvider;

  Future<int> countDataCompetitor() async {
    final db = await _dbProvider.database;
    //var result = await db.rawQuery("SELECT COUNT(*) FROM customer");
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*)  FROM competitor'));
    //print(count);
    return count;
  }

  //Searches if query string was passed
  Future<List<BrandCompetitorModelFL>> getSelectBrandCompetitor(
      {List<String> columns, String query}) async {
    final db = await _dbProvider.database;
    var strSQL;
    List<Map<String, dynamic>> result;
    strSQL =
        "Select Distinct sobid, salesofficeid, materialgroupid, competitorbrand  from competitor";
    result = await db.rawQuery(strSQL);
    List<BrandCompetitorModelFL> material = result.isNotEmpty
        ? result.map((item) => BrandCompetitorModelFL.fromJson(item)).toList()
        : [];
    return material;
  }
}
