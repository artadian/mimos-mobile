import 'package:mimos/TF/Model/penjualanmodeltf.dart';
import 'dart:async';
import 'package:mimos/db/database.dart';

class PenjualanNotUploadBloc{
   final _dbProvider = DatabaseProvider.dbProvider;
  //final _penjualanByMaterialIDController =
     // StreamController<List<PenjualanModelTF>>.broadcast();
   StreamController<List<PenjualanModelTF>> _penjualanController = StreamController<List<PenjualanModelTF>>()   ;
  //get penjualanByMaterialID => _penjualanByMaterialIDController.stream;
  get penjualanNotUploadByMaterialID => _penjualanController.stream;
  PenjualanNotUploadBloc() {
    getPenjualanNotUploadByMaterialID();
  }
  getPenjualanNotUploadByMaterialID({String query}) async {
        _penjualanController.sink.add(await getDataPenjualanNotUploadByMaterialID(query: query));
  }

   Future<List<PenjualanModelTF>> getDataPenjualanNotUploadByMaterialID(
      {List<String> columns, String query}) async {
    final db = await _dbProvider.database;
    var strSQL;
    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        strSQL =
            // "SELECT SUM(((s.bal *( m.bal / m.pac)) + (s.slof * (m.slof / m.pac)) + s.pac) * s.harga)  as amountnota, s.tglkunjungan, s.materialid, m.materialname, s.bal, s.slof, s.pac, s.introdeal, s.harga, c.name, c.address,v.nonota,c.userid,v.customerno FROM visittf v INNER JOIN penjualan s ON v.customerno = s.customerno AND v.tglkunjungan = s.tglkunjungan AND v.userid = s.userid INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN materialtf m ON s.materialid = m.materialid where v.iseditsellin ='Y' and m.materialid is not null and v.nonota <>'-1' and s.getidsellindetail = '-1' and m.materialid ='" +
            //     query +
            //     "' GROUP BY v.customerno,c.userid,s.tglkunjungan, s.materialid, m.materialname, s.bal, s.slof, s.pac, s.introdeal, s.harga,c.name,c.address,v.nonota ORDER BY s.materialid ASC,v.visittrxid ASC ";

                "SELECT distinct SUM(((s.bal *( m.bal / m.pac)) + (s.slof * (m.slof / m.pac)) + s.pac) * s.harga)  as amountnota, s.tglkunjungan, c.name, c.address,v.nonota,c.userid,v.customerno,c.wspclass FROM visittf v INNER JOIN penjualan s ON v.customerno = s.customerno AND v.tglkunjungan = s.tglkunjungan AND v.userid = s.userid INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN materialtf m ON s.materialid = m.materialid where  m.materialid is not null and v.getidsellin <>'-1' and (s.getidsellindetail = '-1' or v.iseditsellin ='Y') and m.materialid ='" +
                query +
                "' GROUP BY v.customerno,c.userid,s.tglkunjungan,c.name,c.address,v.nonota,c.wspclass ORDER BY v.visittrxid ASC ";
    } else {
      strSQL =
         // "SELECT SUM(((s.bal *( m.bal / m.pac)) + (s.slof * (m.slof / m.pac)) + s.pac) * s.harga)  as amountnota, s.tglkunjungan, s.materialid, m.materialname, s.bal, s.slof, s.pac, s.introdeal, s.harga, c.name, c.address,v.nonota,c.userid,v.customerno FROM visittf v INNER JOIN penjualan s ON v.customerno = s.customerno AND v.tglkunjungan = s.tglkunjungan AND v.userid = s.userid INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN materialtf m ON s.materialid = m.materialid where v.iseditsellin ='Y' and m.materialid is not null  and v.nonota <>'-1' and s.getidsellindetail = '-1'  GROUP BY v.customerno,c.userid,s.tglkunjungan, s.materialid, m.materialname, s.bal, s.slof, s.pac, s.introdeal, s.harga,c.name,c.address,v.nonota ORDER BY s.materialid ASC,v.visittrxid ASC ";
         "SELECT distinct SUM(((s.bal *( m.bal / m.pac)) + (s.slof * (m.slof / m.pac)) + s.pac) * s.harga)  as amountnota, s.tglkunjungan, c.name, c.address,v.nonota,c.userid,v.customerno,c.wspclass FROM visittf v INNER JOIN penjualan s ON v.customerno = s.customerno AND v.tglkunjungan = s.tglkunjungan AND v.userid = s.userid INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN materialtf m ON s.materialid = m.materialid where   m.materialid is not null  and v.getidsellin <>'-1' and (s.getidsellindetail = '-1' or v.iseditsellin ='Y') GROUP BY v.customerno,c.userid,s.tglkunjungan,c.name,c.address,v.nonota,c.wspclass ORDER BY s.materialid ASC,v.visittrxid ASC ";
    }
   // print(strSQL);
    result = await db.rawQuery(strSQL);
    List<PenjualanModelTF> todos = result.isNotEmpty
        ? result
            .map((item) => PenjualanModelTF.createPenjualanFromJson(item))
            .toList()
        : [];
        //print("data dao penjualan " +todos.length.toString());
    return todos;
  }
  

  dispose() {
    //_penjualanByMaterialIDController.close();
    _penjualanController.close();
  }
}