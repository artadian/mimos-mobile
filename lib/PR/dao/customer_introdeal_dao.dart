
import 'package:mimos/PR/model/customer_introdeal.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class CustomerIntrodealDao extends BaseDao {
  CustomerIntrodealDao()
      : super(
    table: "customer_introdeal",
    primaryKey: "custintroid",
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
    return CustomerIntrodeal.fromJson(await super.queryGetById(id));
  }
}
