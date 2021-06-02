import 'package:mimos/helper/extension.dart';

class CustomerWsp {
  int id;
  String customerno;
  String startdate;
  String enddate;
  String wspclass;
  String materialgroupid;
  String wspcode;
  String reason;

  CustomerWsp.fromJson(Map<String, dynamic> map)
      : id = map["id"].toString().toInt(),
        customerno = map["customerno"].toString().clean(),
        startdate = map["startdate"].toString().clean(),
        enddate = map["enddate"].toString().clean(),
        wspclass = map["wspclass"].toString().clean(),
        materialgroupid = map["materialgroupid"].toString().clean(),
        wspcode = map["wspcode"].toString().clean(),
        reason = map["reason"].toString().clean();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['customerno'] = customerno;
    data['startdate'] = startdate;
    data['enddate'] = enddate;
    data['wspclass'] = wspclass;
    data['materialgroupid'] = materialgroupid;
    data['wspcode'] = wspcode;
    data['reason'] = reason;
    return data;
  }
}
