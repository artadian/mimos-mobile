import 'package:mimos/helper/extension.dart';

class PosmDetailView {
  int id;
  int posmid;
  String posmtypeid;
  String materialgroupid;
  String status;
  int qty;
  int condition;
  String notes;
  String materialgroupname;
  String materialgroupdesc;
  String typedesc;
  String statusdesc;
  String conditiondesc;
  bool needSync;
  bool isDelete;
  bool isLocal;

  PosmDetailView({
    this.id,
    this.posmid,
    this.posmtypeid,
    this.materialgroupid,
    this.status,
    this.qty,
    this.condition,
    this.notes,
    this.materialgroupname,
    this.materialgroupdesc,
    this.typedesc,
    this.statusdesc,
    this.conditiondesc,
    this.needSync,
    this.isDelete,
    this.isLocal,
  });

  PosmDetailView.fromJson(Map<String, dynamic> map)
      : id = map["id"].toString().toInt(),
        posmid = map["posmid"].toString().toInt(),
        posmtypeid = map["posmtypeid"].toString().clean(),
        materialgroupid = map["materialgroupid"].toString().clean(),
        status = map["status"].toString().clean(),
        qty = map["qty"].toString().toInt(),
        condition = map["condition"].toString().toInt(),
        notes = map["notes"].toString().clean(),
        materialgroupname = map["materialgroupname"].toString().clean(),
        materialgroupdesc = map["materialgroupdesc"].toString().clean(),
        typedesc = map["typedesc"].toString().clean(),
        statusdesc = map["statusdesc"].toString().clean(),
        conditiondesc = map["conditiondesc"].toString().clean(),
        needSync = map["needSync"].toString().toBool(),
        isDelete = map["isDelete"].toString().toBool(),
        isLocal = map["isLocal"].toString().toBool();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['posmid'] = posmid;
    data['posmtypeid'] = posmtypeid;
    data['materialgroupid'] = materialgroupid;
    data['status'] = status;
    data['qty'] = qty;
    data['condition'] = condition;
    data['notes'] = notes;
    data['materialgroupname'] = materialgroupname;
    data['materialgroupdesc'] = materialgroupdesc;
    data['typedesc'] = typedesc;
    data['statusdesc'] = statusdesc;
    data['conditiondesc'] = conditiondesc;
    data['needSync'] = needSync;
    data['isDelete'] = isDelete;
    data['isLocal'] = isLocal;
    return data;
  }
}
