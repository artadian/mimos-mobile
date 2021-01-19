import 'package:mimos/PR/model/introdeal.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class IntrodealDao extends BaseDao {
  IntrodealDao()
      : super(
          table: "introdeal_master",
          primaryKey: "id",
        );

  Future<int> insert(Introdeal data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(Introdeal data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<Introdeal> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<Introdeal> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(Introdeal data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<Introdeal> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<Introdeal>> getAll() async {
    var maps = await super.queryAllData();
    List<Introdeal> list = maps.isNotEmpty
        ? maps.map((item) => Introdeal.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<Introdeal> getById(int id) async {
    var res = await super.queryGetById(id);
    if (res != null) {
      return Introdeal.fromJson(res);
    } else {
      return null;
    }
  }

  Future<Introdeal> getByMaterial(String materialid,
      {String customerno}) async {
    var db = await instance.database;
    var andCustomerno = "";
    if (customerno != null) {
      andCustomerno = '''
        AND (ci.customerno IS NULL
        OR ci.customerno != '$customerno')
      ''';
    }

    var query = '''
      SELECT i.*, ci.customerno 
      FROM introdeal_master i
      LEFT JOIN customer_introdeal_tr ci
      ON ci.introdealid = i.id
      WHERE i.materialid = '$materialid'
      $andCustomerno
    ''';

    var maps = await db.rawQuery(query);
    print("introdeal: $maps");
    List<Introdeal> list = maps.isNotEmpty
        ? maps.map((item) => Introdeal.fromJson(item)).toList()
        : [];
    if (maps.isNotEmpty) {
      return list.first;
    } else {
      return null;
    }
  }
}
