import 'package:mimos/TF/Model/posmmodeltf.dart';
import 'dart:async';
import 'package:mimos/db/database.dart';

class PosmNotUploadBloc{
  final _dbProvider = DatabaseProvider.dbProvider;
StreamController<List<POSMModelTF>> _posmController = StreamController<List<POSMModelTF>>();
get posmNotUploadByMaterialID => _posmController.stream;
PosmNotUploadBloc() {
    getPosmNotUploadByMaterialID();
  }
   getPosmNotUploadByMaterialID({String query}) async {
        _posmController.sink.add(await getDataPOSMNotUploadByMaterialID(query: query));
  }
  Future<List<POSMModelTF>> getDataPOSMNotUploadByMaterialID(
      {List<String> columns, String query}) async {
    final db = await _dbProvider.database;
    var strSQL;
    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        strSQL =
            //"SELECT v.userid,s.posmtrxid, v.customerno,v.tglkunjungan, s.materialid, m.materialgroupdescription as materialname, s.type, lt.lookupdesc as typedescription,s.qty,s.note, c.name as rownumber FROM visittf v INNER JOIN posmtf s ON v.customerno = s.customerno AND v.tglkunjungan = s.tglkunjungan AND v.userid = s.userid INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN materialtf m ON s.materialid = m.materialgroupid INNER JOIN lookup lt on s.type = lt.lookupvalue and lt.lookupkey ='posm_type' where m.materialgroupid is not null and v.getidposm <>'-1' and s.getidposmdetail = '-1' and v.isupdateposm='Y' and m.materialgroupdescription  like'%" +
                //query +
                //" %'  ORDER BY s.posmtrxid ASC ";
                "SELECT distinct v.userid, v.visittrxid, v.customerno,v.tglkunjungan,c.name as materialname,c.address as typedescription,c.city as statusdescription FROM visittf v INNER JOIN posmtf s ON v.customerno = s.customerno AND v.tglkunjungan = s.tglkunjungan AND v.userid = s.userid INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN materialtf m ON s.materialid = m.materialgroupid INNER JOIN lookup lt on s.type = lt.lookupvalue and lt.lookupkey ='posm_type' where m.materialgroupid is not null and v.getidposm <>'-1' and (s.getidposmdetail = '-1' or v.iseditposm='Y') and m.materialgroupdescription  like'%" +
                query +
                " %'  ORDER BY v.visittrxid ASC ";
    } else {
      strSQL =
          //"SELECT v.userid, s.posmtrxid, v.customerno,v.tglkunjungan, s.materialid, m.materialgroupdescription as materialname, s.type, lt.lookupdesc as typedescription,s.qty,s.note,c.name as rownumber FROM visittf v INNER JOIN posmtf s ON v.customerno = s.customerno AND v.tglkunjungan = s.tglkunjungan AND v.userid = s.userid INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN materialtf m ON s.materialid = m.materialgroupid INNER JOIN lookup lt on s.type = lt.lookupvalue and lt.lookupkey ='posm_type' where m.materialgroupid is not null and v.getidposm <>'-1' and s.getidposmdetail = '-1' and v.isupdateposm='Y' ORDER BY s.posmtrxid ASC ";
          "SELECT distinct v.userid, v.visittrxid, v.customerno,v.tglkunjungan,c.name as materialname,c.address as typedescription,c.city as statusdescription FROM visittf v INNER JOIN posmtf s ON v.customerno = s.customerno AND v.tglkunjungan = s.tglkunjungan AND v.userid = s.userid INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN materialtf m ON s.materialid = m.materialgroupid INNER JOIN lookup lt on s.type = lt.lookupvalue and lt.lookupkey ='posm_type' where m.materialgroupid is not null and v.getidposm <>'-1' and (s.getidposmdetail = '-1' or v.iseditposm='Y') ORDER BY s.posmtrxid ASC ";
    }
   // print(strSQL);
    result = await db.rawQuery(strSQL);
    List<POSMModelTF> todos = result.isNotEmpty
        ? result
            .map((item) => POSMModelTF.createPOSMFromJson(item))
            .toList()
        : [];
        //print("data dao penjualan " +todos.length.toString());
    return todos;
  }
  

  dispose() {
    //_penjualanByMaterialIDController.close();
    _posmController.close();
  }
}