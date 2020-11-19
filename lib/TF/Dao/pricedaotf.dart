import 'dart:async';
import 'package:mimos/db/database.dart';
import 'package:mimos/TF/Model/pricemodeltf.dart';
import 'package:sqflite/sqflite.dart';

class PriceDaoTF{
  final _dbProvider = DatabaseProvider.dbProvider;
   //Adds new Todo records
   Future<int>insertPriceTF(PriceModelTF _price) async{
     final db = await _dbProvider.database;
    var result = db.insert("price", _price.toDatabaseJson());
    return result;
   }

   //Get All Todo items
  //Searches if query string was passed
  Future<List<PriceModelTF>> getSelectPriceTF({List<String> columns, String query}) async {
    final db = await _dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query("price",
            columns: columns,
            where: 'materialname LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query("price", columns: columns);
    }

    List<PriceModelTF> todos = result.isNotEmpty
        ? result.map((item) => PriceModelTF.cretaePriceTFFromJson(item)).toList()
        : [];
    return todos;
  }

  //Update Todo record
  Future<int> updatePriceTF(PriceModelTF _price) async {
    final db = await _dbProvider.database;

    var result = await db.update("price", _price.toDatabaseJson(),
        where: "materialid = ?", whereArgs: [_price.materialid]);

    return result;
  }

  //Delete Todo records
  Future<int> deletePriceTF(String id) async {
    final db = await _dbProvider.database;
    var result = await db.delete("price", where: 'pricemfid = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllPriceTF() async {
    final db = await _dbProvider.database;
    var result = await db.delete(
      "price",
    );

    return result;
  }

  Future <int> countDataPriceTF() async{
    final db = await _dbProvider.database;
    //var result = await db.rawQuery("SELECT COUNT(*) FROM customer");
    int count =  Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*)  FROM price'));
    //print(count);
    return count;
  }

}