import 'dart:async';
import 'package:mimos/db/database.dart';
import 'package:mimos/TF/Model/lookupmodel.dart';
import 'package:sqflite/sqflite.dart';

class LookupDao {
  final _dbProvider = DatabaseProvider.dbProvider;
  //Adds new Todo records
  Future<int> insertLookup(LookupModel _lookup) async {
    final db = await _dbProvider.database;
    var result = db.insert("lookup", _lookup.toDatabaseJson());
    return result;
  }

  //Get All Todo items
  //Searches if query string was passed
  Future<List<LookupModel>> getSelectLookup(
      {List<String> columns, String query}) async {
    final db = await _dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query("lookup",
            columns: columns,
            //where: 'lookupkey LIKE ?',
            //whereArgs: ["%$query%"]);
            where: 'lookupkey = ?',
            whereArgs: [query]);
    } else {
      result = await db.query("lookup", columns: columns);
    }

    List<LookupModel> todos = result.isNotEmpty
        ? result
            .map((item) => LookupModel.cretaeLookupFromJson(item))
            .toList()
        : [];
    return todos;
  }

  //Update Todo record
  Future<int> updateLookup(LookupModel _price) async {
    final db = await _dbProvider.database;
    var result = await db.update("lookup", _price.toDatabaseJson(),
        where: "lookupid = ?", whereArgs: [_price.lookupid]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteLookup(String id) async {
    final db = await _dbProvider.database;
    var result =
        await db.delete("lookup", where: 'lookupid = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllLookup() async {
    final db = await _dbProvider.database;
    var result = await db.delete(
      "lookup",
    );
    return result;
  }

  Future<int> countDataLookup() async {
    final db = await _dbProvider.database;
    //var result = await db.rawQuery("SELECT COUNT(*) FROM customer");
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*)  FROM lookup'));
    //print(count);
    return count;
  }
}
