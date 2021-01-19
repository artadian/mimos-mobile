import 'package:flutter/foundation.dart';
import 'package:mimos/PR/model/customer_introdeal.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class CustomerIntrodealDao extends BaseDao {
  CustomerIntrodealDao()
      : super(
          table: "customer_introdeal_tr",
          primaryKey: "id",
        );

  Future<int> insert(CustomerIntrodeal data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(CustomerIntrodeal data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<CustomerIntrodeal> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<CustomerIntrodeal> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(CustomerIntrodeal data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<CustomerIntrodeal> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<CustomerIntrodeal>> getAll() async {
    var maps = await super.queryAllData();
    List<CustomerIntrodeal> list = maps.isNotEmpty
        ? maps.map((item) => CustomerIntrodeal.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<CustomerIntrodeal> getById(int id) async {
    var res = await super.queryGetById(id);
    if (res != null) {
      return CustomerIntrodeal.fromJson(res);
    } else {
      return null;
    }
  }

  Future<CustomerIntrodeal> getByIntrodealCustMaterial({
    @required String materialid,
    @required String customerno,
    @required int introdealid,
  }) async {
    var db = await instance.database;
    var query = '''
          SELECT *
          FROM $table
          WHERE materialid = '$materialid'
          AND customerno = '$customerno'
          AND introdealid = '$introdealid'
        ''';

    var maps = await db.rawQuery(query);
    print("introdeal: $maps");
    List<CustomerIntrodeal> list = maps.isNotEmpty
        ? maps.map((item) => CustomerIntrodeal.fromJson(item)).toList()
        : [];
    if (maps.isNotEmpty) {
      return list.first;
    } else {
      return null;
    }
  }
}
