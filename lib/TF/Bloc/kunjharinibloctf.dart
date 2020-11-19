
import 'dart:async';
import 'package:mimos/TF/Model/konsumenmodelsqllite.dart';
import 'package:mimos/db/database.dart';
import 'package:intl/intl.dart';
class KunjunganHariIniBlocTF{
  final _dbProvider = DatabaseProvider.dbProvider;
  
   final _penjualanHariIniBynNamaCustControler =StreamController<List<KonsumenModelSQLite>>.broadcast();
  get ringkasanPenjualanHariIni => _penjualanHariIniBynNamaCustControler.stream;
  KunjunganHariIniBlocTF(){
    getRingkasanPenjualanHariIniByNamaCust();
  }
  getRingkasanPenjualanHariIniByNamaCust({String query})async{
//_penjualanHariIniBynNamaCustControler.sink.add(await _ringkasanKunjunganHariIniRepoTF.getRingkasanKunjunganHariIniByNamaCust(query:query));
_penjualanHariIniBynNamaCustControler.sink.add(await getRingkasanKunjunganHariIniByNamaCust(query:query));
}
 Future<List<KonsumenModelSQLite>> getRingkasanKunjunganHariIniByNamaCust(
      {List<String> columns, String query}) async {
    final db = await _dbProvider.database;
    var strSQL;
    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        strSQL =
          // "SELECT DISTINCT c.priceid,c.address,c.city,c.customerno, c.tanggalkunjungan, c.name,v.visittrxid,v.nonota,v.notvisitreason,v.notbuyreason,vl.lookupdesc as lookupdescvisitreason,bl.lookupdesc as lookupdescbuyreason FROM customer AS c LEFT JOIN visittf as v ON c.customerno = v.customerno AND c.tanggalkunjungan = v.tglkunjungan AND c.userid = v.userid LEFT JOIN lookup AS vl ON v.notvisitreason = vl.lookupvalue AND vl.lookupkey = 'not_visit_reason' LEFT JOIN lookup AS bl ON v.notbuyreason = bl.lookupvalue AND bl.lookupkey = 'not_buy_reason' where c.tanggalkunjungan ='2019-01-12' and c.name like '%" +
             //  query +
             //  "%' order by c.nourut";
                  "SELECT DISTINCT c.priceid,c.address,c.city,c.customerno, c.tanggalkunjungan, c.name,v.visittrxid,v.nonota,v.notvisitreason,v.notbuyreason,vl.lookupdesc as lookupdescvisitreason,bl.lookupdesc as lookupdescbuyreason, c.wspclass FROM customer AS c LEFT JOIN visittf as v ON c.customerno = v.customerno AND c.tanggalkunjungan = v.tglkunjungan AND c.userid = v.userid LEFT JOIN lookup AS vl ON v.notvisitreason = vl.lookupvalue AND vl.lookupkey = 'not_visit_reason' LEFT JOIN lookup AS bl ON v.notbuyreason = bl.lookupvalue AND bl.lookupkey = 'not_buy_reason' where c.tanggalkunjungan ='"+ DateFormat("yyyy-MM-dd").format(DateTime.now()).toString()+"' and c.name like '%" +
                query +
                 "%' order by c.name";
    } else {
      //result = await db.query("customer", columns: columns);
      strSQL =
         // "SELECT DISTINCT c.priceid,c.address,c.city,c.customerno, c.tanggalkunjungan, c.name,v.visittrxid,v.nonota,v.notvisitreason,v.notbuyreason,vl.lookupdesc as lookupdescvisitreason,bl.lookupdesc as lookupdescbuyreason, c.wspclass FROM customer AS c LEFT JOIN visittf as v ON c.customerno = v.customerno AND c.tanggalkunjungan = v.tglkunjungan AND c.userid = v.userid LEFT JOIN lookup AS vl ON v.notvisitreason = vl.lookupvalue AND vl.lookupkey = 'not_visit_reason' LEFT JOIN lookup AS bl ON v.notbuyreason = bl.lookupvalue AND bl.lookupkey = 'not_buy_reason' where c.tanggalkunjungan ='2020-08-03' order by c.nourut";
          "SELECT DISTINCT c.priceid,c.address,c.city,c.customerno, c.tanggalkunjungan, c.name,v.visittrxid,v.nonota,v.notvisitreason,v.notbuyreason,vl.lookupdesc as lookupdescvisitreason,bl.lookupdesc as lookupdescbuyreason, c.wspclass FROM customer AS c LEFT JOIN visittf as v ON c.customerno = v.customerno AND c.tanggalkunjungan = v.tglkunjungan AND c.userid = v.userid LEFT JOIN lookup AS vl ON v.notvisitreason = vl.lookupvalue AND vl.lookupkey = 'not_visit_reason' LEFT JOIN lookup AS bl ON v.notbuyreason = bl.lookupvalue AND bl.lookupkey = 'not_buy_reason' where c.tanggalkunjungan ='"+ DateFormat("yyyy-MM-dd").format(DateTime.now()).toString() +"' order by c.name";
    }
   // print(strSQL);
    result = await db.rawQuery(strSQL);
    List<KonsumenModelSQLite> todos = result.isNotEmpty
        ? result
            .map((item) => KonsumenModelSQLite.createCustomerFromJson(item))
            .toList()
        : [];
       // print("data kunjungan " +todos.length.toString());
    return todos;
  }
 dispose() {
    _penjualanHariIniBynNamaCustControler.close();
  }
}