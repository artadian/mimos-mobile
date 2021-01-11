import 'package:mimos/helper/extension.dart';

class Trial {
  int id;
  String userid;
  String trialdate;
  String trialtype;
  String location;
  String name;
  String phone;
  int age;
  String materialid;
  int qty;
  double price;
  double amount;
  int competitorbrandid;
  String knowing;
  String taste;
  String packaging;
  String outletname;
  String outletaddress;
  String notes;

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
    this.qty,
    this.price,
    this.amount,
    this.competitorbrandid,
    this.knowing,
    this.taste,
    this.packaging,
    this.outletname,
    this.outletaddress,
    this.notes,
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
        qty = map["qty"].toString().toInt(),
        price = map["price"].toString().toDouble(),
        amount = map["amount"].toString().toDouble(),
        competitorbrandid = map["competitorbrandid"].toString().toInt(),
        knowing = map["knowing"].toString().clean(),
        taste = map["taste"].toString().clean(),
        packaging = map["packaging"].toString().clean(),
        outletname = map["outletname"].toString().clean(),
        outletaddress = map["outletaddress"].toString().clean(),
        notes = map["notes"].toString().clean();

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
    data['qty'] = qty;
    data['price'] = price;
    data['amount'] = amount;
    data['competitorbrandid'] = competitorbrandid;
    data['knowing'] = knowing;
    data['taste'] = taste;
    data['packaging'] = packaging;
    data['outletname'] = outletname;
    data['outletaddress'] = outletaddress;
    data['notes'] = notes;
    return data;
  }
}