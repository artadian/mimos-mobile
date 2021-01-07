import 'package:mimos/PR/dao/stock_detail_dao.dart';
import 'package:mimos/PR/repo/upload/upload_stock_repo.dart';

class UploadStockDetailRes {
  var _dao = StockDetailDao();
  var _repo = UploadStockRepo();

  Future<List<bool>> insert() async {
    var listData = await _dao.needSync();

    if (listData.isEmpty) {
      return [];
    } else {
      var result = List<bool>();
      await Future.wait(listData.map((row) async {
        try {
          var res = await _repo.pushStockDetail(row);

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

  Future<List<bool>> update() async {
    var listData = await _dao.needUpdate();

    if (listData.isEmpty) {
      return [];
    } else {
      var result = List<bool>();
      await Future.wait(listData.map((row) async {
        try {
          var res = await _repo.updateStockDetail(row);

          if (res.status) {
            await _dao.resetNeedUpdate(row["id"]);

            result.add(true);
          } else {
            result.add(false);
          }
        } catch (e) {
          result.add(false);
          print("$runtimeType uploadUpdate ERROR: $e");
        }
      }));
      return result;
    }
  }

  Future<List<bool>> delete() async {
    var listData = await _dao.needDeleteId();

    print(listData);
    if (listData.isEmpty) {
      return [];
    } else {
      var result = List<bool>();
      await Future.wait(listData.map((id) async {
        try {
          var res = await _repo.delStockDetail(id);

          if (res.status) {
//            await _dao.delete(id, local: true);

            result.add(true);
          } else {
            result.add(false);
          }
        } catch (e) {
          result.add(false);
          print("$runtimeType uploadDelete ERROR: $e");
        }
      }));
      return result;
    }
  }
}
