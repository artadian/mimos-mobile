import 'package:mimos/helper/extension.dart';

class CustomerIntrodeal {
  int id;
  String customerno;
  int introdealid;
  String materialid;
  int sellindetailid;
  bool needSync;
  bool isDelete;
  bool isLocal;

  CustomerIntrodeal.fromJson(Map<String, dynamic> map)
      : this.id = map["id"].toString().toInt(),
        this.customerno = map["customerno"].toString().clean(),
        this.introdealid = map["introdealid"].toString().toInt(),
        this.materialid = map["materialid"].toString().clean(),
        this.sellindetailid = map["sellindetailid"].toString().toInt(),
        this.needSync = map["needSync"].toString().toBool(),
        this.isDelete = map["isDelete"].toString().toBool(),
        this.isLocal = map["isLocal"].toString().toBool();

  CustomerIntrodeal.createFromJson(Map<String, dynamic> map)
      : this.id = map["id"].toString().toInt(),
        this.customerno = map["customerno"].toString().clean(),
        this.introdealid = map["introdealid"].toString().toInt(),
        this.materialid = map["materialid"].toString().clean(),
        this.sellindetailid = map["sellindetailid"].toString().toInt(),
        this.needSync = false,
        this.isDelete = false,
        this.isLocal = true;

  CustomerIntrodeal.create({String customerno, int introdealid, String materialid, int sellindetailid})
      : this.id = null,
        this.customerno = customerno,
        this.introdealid = introdealid,
        this.materialid = materialid,
        this.sellindetailid = sellindetailid,
        this.needSync = false,
        this.isDelete = false,
        this.isLocal = true;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerno'] = this.customerno;
    data['introdealid'] = this.introdealid;
    data['materialid'] = this.materialid;
    data['sellindetailid'] = this.sellindetailid;
    data['needSync'] = this.needSync;
    data['isDelete'] = this.isDelete;
    data['isLocal'] = this.isLocal;
    return data;
  }
}
