import 'package:mimos/helper/extension.dart';

class VisibilityDetail {
  int id;
  int visibilityid;
  String materialid;
  String materialname;
  int pac;
  bool needSync;
  bool isDelete;
  bool isLocal;

  VisibilityDetail({
    this.id,
    this.visibilityid,
    this.materialid,
    this.materialname,
    this.pac,
    this.needSync,
    this.isDelete,
    this.isLocal,
  });

  VisibilityDetail.fromJson(Map<String, dynamic> map)
      : id = map["id"].toString().toInt(),
        visibilityid = map["visibilityid"].toString().toInt(),
        materialid = map["materialid"].toString().clean(),
        materialname = map["materialname"].toString().clean(),
        pac = map["pac"].toString().toInt(),
        needSync = map["needSync"].toString().toBool(),
        isDelete = map["isDelete"].toString().toBool(),
        isLocal = map["isLocal"].toString().toBool();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['visibilityid'] = visibilityid;
    data['materialid'] = materialid;
    data['materialname'] = materialname;
    data['pac'] = pac;
    data['needSync'] = needSync;
    data['isDelete'] = isDelete;
    data['isLocal'] = isLocal;
    return data;
  }
}
