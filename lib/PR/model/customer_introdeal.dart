import 'package:mimos/helper/extension.dart';

class CustomerIntrodeal {
  int custintroid;
  String materialid;
  String introdealid;
  String customerno;

  CustomerIntrodeal.fromJson(Map<String, dynamic> map)
      : custintroid = map["materialid"].toString().toInt(),
        materialid = map["materialid"].toString().clean(),
        introdealid = map["introdealid"].toString().clean(),
        customerno = map["customerno"].toString().clean();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custintroid'] = custintroid;
    data['materialid'] = materialid;
    data['introdealid'] = introdealid;
    data['customerno'] = customerno;
    return data;
  }
}
