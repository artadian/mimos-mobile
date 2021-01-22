import 'package:mimos/helper/extension.dart';

class Trial {
  int id;
  String userid;
  String trialdate;
  String trialtype;
  String lookupdesc;
  String location;
  String name;
  String phone;
  int age;
  String materialid;
  String materialname;
  int qty;
  double price;
  double amount;
  int competitorbrandid;
  String competitorbrandname;
  String knowing;
  String taste;
  String packaging;
  String outletname;
  String outletaddress;
  String notes;
  bool needSync;
  bool isDelete;
  bool isLocal;

  Trial({
    this.id,
    this.userid,
    this.trialdate,
    this.trialtype,
    this.location,
    this.name,
    this.phone,
    this.age,
    this.materialid,
    this.materialname,
    this.qty,
    this.price,
    this.amount,
    this.competitorbrandid,
    this.competitorbrandname,
    this.knowing,
    this.taste,
    this.packaging,
    this.outletname,
    this.outletaddress,
    this.notes,
    this.needSync,
    this.isDelete,
    this.isLocal,
  });

  Trial.fromJson(Map<String, dynamic> map)
      : id = map["id"].toString().toInt(),
        userid = map["userid"].toString().clean(),
        trialdate = map["trialdate"].toString().clean(),
        trialtype = map["trialtype"].toString().clean(),
        location = map["location"].toString().clean(),
        name = map["name"].toString().clean(),
        phone = map["phone"].toString().clean(),
        age = map["age"].toString().toInt(),
        materialid = map["materialid"].toString().clean(),
        materialname = map["materialname"].toString().clean(),
        qty = map["qty"].toString().toInt(),
        price = map["price"].toString().toDouble(),
        amount = map["amount"].toString().toDouble(),
        competitorbrandid = map["competitorbrandid"].toString().toInt(),
        competitorbrandname = map["competitorbrandname"].toString().clean(),
        knowing = map["knowing"].toString().clean(),
        taste = map["taste"].toString().clean(),
        packaging = map["packaging"].toString().clean(),
        outletname = map["outletname"].toString().clean(),
        outletaddress = map["outletaddress"].toString().clean(),
        notes = map["notes"].toString().clean(),
        needSync = map["needSync"].toString().toBool(),
        isDelete = map["isDelete"].toString().toBool(),
        isLocal = map["isLocal"].toString().toBool(),
        // view
        lookupdesc = map["lookupdesc"].toString().clean();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['userid'] = userid;
    data['trialdate'] = trialdate;
    data['trialtype'] = trialtype;
    data['location'] = location;
    data['name'] = name;
    data['phone'] = phone;
    data['age'] = age;
    data['materialid'] = materialid;
    data['materialname'] = materialname;
    data['qty'] = qty;
    data['price'] = price;
    data['amount'] = amount;
    data['competitorbrandid'] = competitorbrandid;
    data['competitorbrandname'] = competitorbrandname;
    data['knowing'] = knowing;
    data['taste'] = taste;
    data['packaging'] = packaging;
    data['outletname'] = outletname;
    data['outletaddress'] = outletaddress;
    data['notes'] = notes;
    data['needSync'] = needSync;
    data['isDelete'] = isDelete;
    data['isLocal'] = isLocal;
    return data;
  }
}
