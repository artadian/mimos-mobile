import 'package:flutter/foundation.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/visit.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class VisitDao extends BaseDao {
  VisitDao()
      : super(
          table: "visit",
          primaryKey: "id",
        );

  Future<int> insert(Visit data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(Visit data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<Visit> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<Visit> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(Visit data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<Visit> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<Visit>> getAll() async {
    var maps = await super.queryAllData();
    List<Visit> list = maps.isNotEmpty
        ? maps.map((item) => Visit.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<Visit> getById(int id) async {
    var res = await super.queryGetById(id);
    if (res != null) {
      return Visit.fromJson(res);
    } else {
      return null;
    }
  }

  Future<CustomerPR> getByIdVisit(int id) async {
    var db = await instance.database;
    var query = '''
      SELECT c.*, c.tanggalkunjungan as visitdate,
        v.id as idvisit, v.notvisitreason, v.notbuyreason,
        vl.lookupdesc as lookupdescvisitreason,
        bl.lookupdesc as lookupdescbuyreason
      FROM customer AS c 
      LEFT JOIN visit as v ON c.customerno = v.customerno 
        AND c.tanggalkunjungan = v.visitdate 
      LEFT JOIN lookup AS vl ON v.notvisitreason = vl.lookupvalue AND vl.lookupkey = 'not_visit_reason' 
      LEFT JOIN lookup AS bl ON v.notbuyreason = bl.lookupvalue AND bl.lookupkey = 'not_buy_reason' 
      WHERE v.id = $id
    ''';
    var maps = await db.rawQuery(query);
    if (maps.isNotEmpty) {
      return CustomerPR.fromTable(maps.first);
    } else {
      return null;
    }
  }

  Future<int> setNotVisitReason({
    @required int id,
    @required String notVisitReason,
  }) async {
    var db = await instance.database;
    return await db.update(table, {"notvisitreason": notVisitReason},
        where: "$primaryKey == $id");
  }

  Future<int> setNotBuyReason({
    @required int id,
    @required String notBuyReason,
  }) async {
    var db = await instance.database;
    return await db.update(table, {"notbuyreason": notBuyReason},
        where: "$primaryKey == $id");
  }

  Future<int> countVisited({@required String date}) async {
    var db = await instance.database;
    var query = '''
      SELECT COUNT(c.tanggalkunjungan) as visited
      FROM customer c
      LEFT JOIN visit v ON c.customerno = v.customerno
      WHERE v.id IS NOT NULL AND (notvisitreason = 0 OR notvisitreason IS NULL)
      AND tanggalkunjungan = '$date'
    ''';

    var maps = await db.rawQuery(query);
    return maps.first['visited'] as int;
  }

  Future<int> countNotVisited({@required String date}) async {
    var db = await instance.database;
    var query = '''
      SELECT c.tanggalkunjungan, COUNT(c.tanggalkunjungan) as not_visited
      FROM customer c
      LEFT JOIN visit v ON c.customerno = v.customerno
      WHERE v.id IS NULL OR (notvisitreason != 0 AND notvisitreason IS NOT NULL)
      AND tanggalkunjungan = '$date'
    ''';

    var maps = await db.rawQuery(query);
    return maps.first['not_visited'] as int;
  }
}
