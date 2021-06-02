import 'package:flutter/foundation.dart';
import 'package:mimos/PR/model/customer_wsp.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class CustomerWspDao extends BaseDao {
  CustomerWspDao()
      : super(
    table: "customer_wsp",
    primaryKey: "id",
  );

  Future<int> insert(CustomerWsp data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(CustomerWsp data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<CustomerWsp> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<CustomerWsp> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(CustomerWsp data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<CustomerWsp> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<CustomerWsp>> getAll() async {
    var maps = await super.queryAllData();
    List<CustomerWsp> list = maps.isNotEmpty
        ? maps.map((item) => CustomerWsp.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<CustomerWsp> getById(int id) async {
    var res = await super.queryGetById(id);
    if (res != null) {
      return CustomerWsp.fromJson(res);
    } else {
      return null;
    }
  }

}
