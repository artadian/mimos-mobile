import 'package:mimos/TF/Model/posmmodeltf.dart';
import 'dart:async';
import 'package:mimos/db/database.dart';
class StockNotUploadBloc{
  final _dbProvider = DatabaseProvider.dbProvider;
StreamController<List<POSMModelTF>> _posmController = StreamController<List<POSMModelTF>>();
get posmNotUploadByMaterialID => _posmController.stream;
StockNotUploadBloc() {
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
                "SELECT distinct v.userid, v.visittrxid, v.customerno,v.tglkunjungan,c.name as materialname,c.address as typedescription,c.city as statusdescription FROM visittf v INNER JOIN stocktf s ON v.customerno = s.customerno AND v.tglkunjungan = s.tglkunjungan AND v.userid = s.userid INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN materialtf m ON s.materialid = m.materialid where m.materialgroupid is not null and v.getidstock <>'-1' and (s.getidstockdetail = '-1' or v.iseditstock='Y') and m.materialname  like'%" +
                query +
                " %'  ORDER BY v.visittrxid ASC ";
    } else {
      strSQL =
          "SELECT distinct v.userid, v.visittrxid, v.customerno,v.tglkunjungan,c.name as materialname,c.address as typedescription,c.city as statusdescription FROM visittf v INNER JOIN stocktf s ON v.customerno = s.customerno AND v.tglkunjungan = s.tglkunjungan AND v.userid = s.userid INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN materialtf m ON s.materialid = m.materialid where m.materialgroupid is not null and v.getidstock <>'-1' and (s.getidstockdetail = '-1' or v.iseditstock='Y') ORDER BY v.visittrxid ASC ";
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