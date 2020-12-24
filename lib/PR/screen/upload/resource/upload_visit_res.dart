import 'package:mimos/PR/dao/visit_dao.dart';
import 'package:mimos/PR/repo/upload/upload_visit_repo.dart';

class UploadVisitRes {
  var _dao = VisitDao();
  var _repo = UploadVisitRepo();

  Future<List<bool>> insert() async {
    var listData = await _dao.needSync();

    if (listData.isEmpty) {
      return [];
    } else {
      var result = List<bool>();
      await Future.wait(listData.map((row) async {
        try {
          var res = await _repo.pushVisit(row);

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
          var res = await _repo.updateVisit(row);

          if (res.status) {
            await _dao.resetNeedUpdate(row["id"]);

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
