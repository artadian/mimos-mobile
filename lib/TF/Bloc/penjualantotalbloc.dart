import 'package:mimos/TF/Model/penjualanmodeltf.dart';
import 'dart:async';
import 'package:mimos/db/database.dart';

class PenjualanTotalBloc{
  final _dbProvider = DatabaseProvider.dbProvider;
  StreamController<List<PenjualanModelTF>> _penjualanTotalController = StreamController<List<PenjualanModelTF>>()   ;
  get penjualanTotalByMaterialID => _penjualanTotalController.stream;

  PenjualanTotalBloc(){
    getPenjualanTotalByMaterialID();
  }
  getPenjualanTotalByMaterialID({String query}) async {
        _penjualanTotalController.sink.add(await getRingkasanTotalPenjualanByMaterialID(query: query));

  }
   Future<List<PenjualanModelTF>> getRingkasanTotalPenjualanByMaterialID(
      {List<String> columns, String query}) async {
    final db = await _dbProvider.database;
    var strSQL;
    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        strSQL =
            "SELECT SUM(((s.bal *( m.bal / m.pac)) + (s.slof * (m.slof / m.pac)) + s.pac) * s.harga)  as amountnota,  s.materialid, m.materialname, sum(s.bal) as bal, sum(s.slof) as slof, sum(s.pac) as pac, Sum(s.introdeal) as introdeal,s.harga FROM visittf v INNER JOIN penjualan s ON v.customerno = s.customerno AND v.tglkunjungan = s.tglkunjungan AND v.userid = s.userid INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN materialtf m ON s.materialid = m.materialid where m.materialid is not null and v.nonota <>'-1' and m.materialid ='" +
                query +
                "' GROUP BY s.materialid, m.materialname,  s.harga ORDER BY s.materialid ASC,v.visittrxid ASC ";
    } else {
      strSQL =
          "SELECT SUM(((s.bal *( m.bal / m.pac)) + (s.slof * (m.slof / m.pac)) + s.pac) * s.harga)  as amountnota,  s.materialid, m.materialname, sum(s.bal) as bal, sum(s.slof) as slof, sum(s.pac) as pac, Sum(s.introdeal) as introdeal,s.harga FROM visittf v INNER JOIN penjualan s ON v.customerno = s.customerno AND v.tglkunjungan = s.tglkunjungan AND v.userid = s.userid INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN materialtf m ON s.materialid = m.materialid where m.materialid is not null and v.nonota <>'-1'  GROUP BY s.materialid, m.materialname, s.harga ORDER BY s.materialid ASC,v.visittrxid ASC ";
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
    _penjualanTotalController.close();
  }
}