import 'package:intl/intl.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

class CustomerPRDao extends BaseDao {
  CustomerPRDao()
      : super(
    table: "customer",
    primaryKey: "id",
  );

  Future<int> insert(CustomerPR data) async {
    var row = data.toJson();
    return await super.queryInsert(row);
  }

  Future<int> insertIgnore(CustomerPR data) async {
    var row = data.toJson();
    return await super
        .queryInsert(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> insertAll(List<CustomerPR> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryInsertAll(row);
  }

  Future<List<int>> insertIgnoreAll(List<CustomerPR> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super
        .queryInsertAll(row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(CustomerPR data) async {
    var row = data.toJson();
    return await super.queryUpdate(row);
  }

  Future<List<int>> updateAll(List<CustomerPR> data) async {
    var row = data.map((v) => v.toJson()).toList();
    return await super.queryUpdateAll(row);
  }

  Future<List<CustomerPR>> getAll() async {
    var maps = await super.queryAllData();
    List<CustomerPR> list = maps.isNotEmpty
        ? maps.map((item) => CustomerPR.fromTable(item)).toList()
        : [];
    return list;
  }

  Future<List<CustomerPR>> getCustomerVisit({String search}) async {
    var db = await instance.database;
    String where = "";
    if(search != null)
      where = "AND c.name LIKE '%$search%'";

    var query = '''
      SELECT DISTINCT c.priceid, c.address, c.city, c.customerno, c.tanggalkunjungan, c.name,
        v.visittrxid, v.nonota, v.notvisitreason, v.notbuyreason, vl.lookupdesc as lookupdescvisitreason,
        bl.lookupdesc as lookupdescbuyreason, c.wspclass 
      FROM customer AS c 
      LEFT JOIN visittf as v ON c.customerno = v.customerno 
        AND c.tanggalkunjungan = v.tglkunjungan 
        AND c.userid = v.userid 
      LEFT JOIN lookup AS vl ON v.notvisitreason = vl.lookupvalue AND vl.lookupkey = 'not_visit_reason' 
      LEFT JOIN lookup AS bl ON v.notbuyreason = bl.lookupvalue AND bl.lookupkey = 'not_buy_reason' 
        WHERE c.tanggalkunjungan = '${DateFormat("yyyy-MM-dd").format(DateTime.now()).toString()}' 
      $where
      ORDER BY c.name 
    ''';

    var maps = await db.rawQuery(query);
    List<CustomerPR> list = maps.isNotEmpty
        ? maps.map((item) => CustomerPR.fromTable(item)).toList()
        : [];
    return list;
  }

  Future<CustomerPR> getById(int id) async {
    return CustomerPR.fromTable(await super.queryGetById(id));
  }
}
