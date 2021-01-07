import 'package:mimos/PR/dao/posm_dao.dart';
import 'package:mimos/PR/dao/posm_detail_dao.dart';
import 'package:mimos/PR/repo/upload/upload_posm.dart';

class UploadPosmRes {
  var _dao = PosmDao();
  var _detailDao = PosmDetailDao();
  var _repo = UploadPosmRepo();

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
          var res = await _repo.pushPosm(row);

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
