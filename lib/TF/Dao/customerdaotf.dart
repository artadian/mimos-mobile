import 'dart:async';
import 'package:mimos/TF/Model/konsumenmodelsqllite.dart';
import 'package:mimos/db/database.dart';
import 'package:sqflite/sqflite.dart';
class CustomerDaoTF {
  final _dbProvider = DatabaseProvider.dbProvider;
  //Adds new Todo records
  Future<int> insertCustomer(KonsumenModelSQLite _customer) async {
    final db = await _dbProvider.database;
    var result = db.insert("customer", _customer.toDatabaseJson());
    return result;
  }
  //Get All Todo items
  //Searches if query string was passed
  Future<List<KonsumenModelSQLite>> getSelectCustomer(
      {List<String> columns, String query}) async {
    final db = await _dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query("customer",
            columns: columns,
            where: 'name LIKE ?',
            whereArgs: ["%$query%"],
            orderBy: 'tanggalkunjungan');
    } else {
      //result = await db.query("customer", columns: columns);
      result = await db.rawQuery(
          "select * from customer ORDER BY tanggalkunjungan ASC,name ASC");
         // print("getselectcustome");
    }
    List<KonsumenModelSQLite> todos = result.isNotEmpty
        ? result
            .map((item) => KonsumenModelSQLite.createCustomerFromJson(item))
            .toList()
        : [];
        print("data customer " +todos.length.toString());
    return todos;
  }

  //Update Todo record
  Future<int> updateCustomer(KonsumenModelSQLite _customer) async {
    final db = await _dbProvider.database;
    var result = await db.update("customer", _customer.toDatabaseJson(),
        where: "customerno = ?", whereArgs: [_customer.customerno]);
    return result;
  }

  //Delete Todo records
  Future<int> deleteCustomer(String id) async {
    final db = await _dbProvider.database;
    var result =
        await db.delete("customer", where: 'customerno = ?', whereArgs: [id]);
    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllCustomer() async {
    final db = await _dbProvider.database;
    var result = await db.delete(
      "customer",
    );
    return result;
  }

  Future<int> countData() async {
    final db = await _dbProvider.database;
    //var result = await db.rawQuery("SELECT COUNT(*) FROM customer");
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(id)  FROM customer'));
    //print(count);
    return count;
  }

  Future <int> countKonsumenTerkunjungi() async{
    final db = await _dbProvider.database;
    //var result = await db.rawQuery("SELECT COUNT(*) FROM customer");
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(v.visittrxid)  FROM visittf as v inner join customer as c on v.customerno = c.customerno and c.tanggalkunjungan = v.tglkunjungan and c.userid = v.userid  where v.notvisitreason = 0 '));
    //print(count);
    return count;
  }

  Future <int> countNotaKonsumen() async{
    final db = await _dbProvider.database;
    //var result = await db.rawQuery("SELECT COUNT(*) FROM customer");
    int count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT  COUNT(DISTINCT v.visittrxid)  FROM visittf as v inner join customer as c on v.customerno = c.customerno and c.tanggalkunjungan = v.tglkunjungan and c.userid = v.userid inner join penjualan as p on v.customerno = p.customerno and p.tglkunjungan = v.tglkunjungan and p.userid = v.userid  where v.notvisitreason = 0 and v.notbuyreason = 0 and v.nonota <>'-1'  "));
    //print(count);
    return count;
  }

}
