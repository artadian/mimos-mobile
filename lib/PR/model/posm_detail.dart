import 'package:mimos/helper/extension.dart';

class PosmDetail {
  int id;
  int posmid;
  String posmtypeid;
  String materialgroupid;
  String status;
  int qty;
  int condition;
  String notes;
  bool needSync;
  bool isDelete;
  bool isLocal;

  PosmDetail({
    this.id,
    this.posmid,
    this.posmtypeid,
    this.materialgroupid,
    this.status,
    this.qty,
    this.condition,
    this.notes,
    this.needSync,
    this.isDelete,
    this.isLocal,
  });

  PosmDetail.fromJson(Map<String, dynamic> map)
      : id = map["id"].toString().toInt(),
        posmid = map["posmid"].toString().toInt(),
        posmtypeid = map["posmtypeid"].toString().clean(),
        materialgroupid = map["materialgroupid"].toString().clean(),
        status = map["status"].toString().clean(),
        qty = map["qty"].toString().toInt(),
        condition = map["condition"].toString().toInt(),
        notes = map["notes"].toString().clean(),
				needSync = map["needSync"].toString().toBool(),
				isDelete = map["isDelete"].toString().toBool(),
				isLocal = map["isLocal"].toString().toBool();

	PosmDetail.createFromJson(Map<String, dynamic> map)
			: this.id = map["id"].toString().toInt(),
				posmid = map["posmid"].toString().toInt(),
				posmtypeid = map["posmtypeid"].toString().clean(),
				materialgroupid = map["materialgroupid"].toString().clean(),
				status = map["status"].toString().clean(),
				qty = map["qty"].toString().toInt(),
				condition = map["condition"].toString().toInt(),
				notes = map["notes"].toString().clean(),
				needSync = true,
				isDelete = false,
				isLocal = true;

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
		data['needSync'] = needSync;
		data['isDelete'] = isDelete;
		data['isLocal'] = isLocal;
    return data;
  }
}
