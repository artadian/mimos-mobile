import 'package:flutter/foundation.dart';
import 'package:mimos/PR/model/posm_detail.dart';
import 'package:mimos/PR/model/view/posm_detail_view.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class PosmDetailDao extends BaseDao {
  PosmDetailDao()
      : super(
    table: "posm_detail",
    primaryKey: "id",
  );

  Future<int> insert(PosmDetail data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(PosmDetail data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<PosmDetail> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<PosmDetail> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(PosmDetail data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<PosmDetail> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<PosmDetail>> getAll() async {
    var maps = await super.queryAllData();
    List<PosmDetail> list = maps.isNotEmpty
        ? maps.map((item) => PosmDetail.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<PosmDetail> getById(int id) async {
    var res = await super.queryGetById(id);
    if (res != null) {
      return PosmDetail.fromJson(res);
    } else {
      return null;
    }
  }

  Future<int> updateIdParent({@required int id, @required int newId}) async {
    var db = await instance.database;
    return await db.update(table, {"posmid": newId},
        where: "posmid == $id");
  }

  Future<PosmDetailView> getByIdForm(int id) async {
    var db = await instance.database;
    var query = '''
      SELECT pd.id, pd.posmid, pd.posmtypeid, pd.materialgroupid, pd.status, pd.qty, pd.condition, pd.notes, 
        m.materialgroupname, m.materialgroupdesc,
        t.lookupdesc as typedesc, 
        s.lookupdesc as statusdesc, 
        c.lookupdesc as conditiondesc
      FROM $table as pd
      JOIN (SELECT * FROM material_price GROUP BY materialgroupid) m ON pd.materialgroupid = m.materialgroupid
      LEFT JOIN lookup t ON t.lookupvalue = pd.posmtypeid AND t.lookupkey = 'posm_type'
      LEFT JOIN lookup s ON s.lookupvalue = pd.status AND s.lookupkey = 'posm_status'
      LEFT JOIN lookup c ON c.lookupvalue = pd.condition AND c.lookupkey = 'posm_condition'
      WHERE pd.id = $id
      AND pd.isDelete = 0
    ''';

    var maps = await db.rawQuery(query);
    if(maps.length > 0) {
      return PosmDetailView.fromJson(maps.first);
    }else{
      return null;
    }
  }

  Future<List<PosmDetailView>> getByParent({@required int posmid}) async {
    var db = await instance.database;
    var query = '''
      SELECT pd.id, pd.posmid, pd.posmtypeid, pd.materialgroupid, pd.status, pd.qty, pd.condition, pd.notes, 
        m.materialgroupname, m.materialgroupdesc,
        t.lookupdesc as typedesc, 
        s.lookupdesc as statusdesc, 
        c.lookupdesc as conditiondesc
      FROM $table as pd
      JOIN (SELECT * FROM material_price GROUP BY materialgroupid) m ON pd.materialgroupid = m.materialgroupid
      LEFT JOIN lookup t ON t.lookupvalue = pd.posmtypeid AND t.lookupkey = 'posm_type'
      LEFT JOIN lookup s ON s.lookupvalue = pd.status AND s.lookupkey = 'posm_status'
      LEFT JOIN lookup c ON c.lookupvalue = pd.condition AND c.lookupkey = 'posm_condition'
      WHERE posmid = $posmid
      AND pd.isDelete = 0
    ''';

    var maps = await db.rawQuery(query);
    List<PosmDetailView> list = maps.isNotEmpty
        ? maps.map((item) => PosmDetailView.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<List<PosmDetail>> getByParentAndMaterial(
      {@required int posmid, @required String materialgroupid, String type}) async {
    var db = await instance.database;
    var query = """
      SELECT * FROM $table
      WHERE posmid = $posmid
      AND materialgroupid = '$materialgroupid'
      AND status = '$type'
      AND isDelete = 0
    """;

    var maps = await db.rawQuery(query);
    List<PosmDetail> list = maps.isNotEmpty
        ? maps.map((item) => PosmDetail.fromJson(item)).toList()
        : [];
    return list;
  }

  Future<List<int>> deleteByPosm(String posmid) async {
    var res = await super.deleteBy(column: "posmid", value: posmid);
    return res;
  }

}
