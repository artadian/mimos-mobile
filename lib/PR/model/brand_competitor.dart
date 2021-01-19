import 'package:mimos/helper/extension.dart';

class BrandCompetitor {
  int id;
  int competitorbrandid;
  int materialgroupid;
  String materialgroup;
  String competitorbrandname;

  BrandCompetitor.fromJson(Map<String, dynamic> map)
      : id = map["id"].toString().toInt(),
        competitorbrandid = map["competitorbrandid"].toString().toInt(),
        materialgroupid = map["materialgroupid"].toString().toInt(),
        materialgroup = map["materialgroup"].toString().clean(),
        competitorbrandname = map["competitorbrandname"].toString().clean();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['competitorbrandid'] = competitorbrandid;
    data['materialgroupid'] = materialgroupid;
    data['materialgroup'] = materialgroup;
    data['competitorbrandname'] = competitorbrandname;
    return data;
  }
}
