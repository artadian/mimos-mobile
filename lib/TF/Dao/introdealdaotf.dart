import 'dart:async';
import 'package:mimos/db/database.dart';
import 'package:mimos/TF/Model/introdealmodeltf.dart';
import 'package:sqflite/sqflite.dart';

class IntrodealDaoTF {
  final _dbProvider = DatabaseProvider.dbProvider;
  //Adds new Todo records
  Future<int> insertIntrodealTF(IntrodealModelTF _introdeal) async {
    final db = await _dbProvider.database;
    var result = db.insert("introdeal", _introdeal.toDatabaseJson());
    return result;
  }

  //Get All Todo items
  //Searches if query string was passed
  Future<List<IntrodealModelTF>> getSelectIntrodealTF(
      {List<String> columns, String query}) async {
    final db = await _dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query("introdeal",
            columns: columns,
            where: 'materialname LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query("introdeal", columns: columns);
    }

    List<IntrodealModelTF> todos = result.isNotEmpty
        ? result
            .map((item) => IntrodealModelTF.cretaeIntrodealTFFromJson(item))
            .toList()
        : [];
    return todos;
  }

  //Update Todo record
  Future<int> updateIntrodealTF(IntrodealModelTF _price) async {
    final db = await _dbProvider.database;
    var result = await db.update("introdel", _price.toDatabaseJson(),
        where: "materialid = ?", whereArgs: [_price.materialid]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteIntrodealTF(String id) async {
    final db = await _dbProvider.database;
    var result =
        await db.delete("introdeal", where: 'intromfid = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllIntrodealTF() async {
    final db = await _dbProvider.database;
    var result = await db.delete(
      "introdeal",
    );
    return result;
  }

  Future<int> countDataIntrodealTF() async {
    final db = await _dbProvider.database;
    //var result = await db.rawQuery("SELECT COUNT(*) FROM customer");
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*)  FROM introdeal'));
    //print(count);
    return count;
  }
}
