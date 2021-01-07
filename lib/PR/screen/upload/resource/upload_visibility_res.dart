import 'package:mimos/PR/dao/visibility_dao.dart';
import 'package:mimos/PR/dao/visibility_detail_dao.dart';
import 'package:mimos/PR/repo/upload/upload_visibility.dart';

class UploadVisibilityRes {
  var _dao = VisibilityDao();
  var _detailDao = VisibilityDetailDao();
  var _repo = UploadVisibilityRepo();

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
          var res = await _repo.pushVisibility(row);

          if (res.status) {
            await _detailDao.updateIdParent(id: row["id"], newId: res.data.id);
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
