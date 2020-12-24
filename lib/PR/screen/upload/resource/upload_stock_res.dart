import 'package:mimos/PR/dao/stock_dao.dart';
import 'package:mimos/PR/repo/upload/upload_stock_repo.dart';

class UploadStockRes {
  var _dao = StockDao();
  var _repo = UploadStockRepo();

  Future<bool> needSync() async {
    return await _dao.countNeedSyncIns() > 0;
  }

  Future<List<bool>> insert() async {
    var listData = await _dao.needSync();

    if (listData.isEmpty) {
      return [];
    } else {
      var result = List<bool>();
      await Future.wait(listData.map((row) async {
        try {
          var res = await _repo.pushStock(row);

          if (res.status) {
            await _dao.delete(row["id"], local: true);
            await _dao.insert(res.data);

            result.add(true);
          } else {
            result.add(false);
          }
        } catch (e) {
          result.add(false);
          print("$runtimeType uploadInsert ERROR: $e");
        }
      }));
      return result;
    }
  }
}
