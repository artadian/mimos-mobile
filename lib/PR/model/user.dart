import 'package:mimos/helper/extension.dart';

class User {
  String userid;
  String username;
  String userroleid;
  String regionid;
  String salesofficeid;
  String salesgroupid;
  String salesdistrictid;
  String rolename;
  String salesofficetype;
  String salesofficetypename;
  String salesofficename;

  User.fromJson(Map<String, dynamic> map)
      : userid = map["userid"].toString().clean(),
        username = map["username"].toString().clean(),
        userroleid = map["userroleid"].toString().clean(),
        regionid = map["regionid"].toString().clean(),
        salesofficeid = map["salesofficeid"].toString().clean(),
        salesgroupid = map["salesgroupid"].toString().clean(),
        salesdistrictid = map["salesdistrictid"].toString().clean(),
        rolename = map["rolename"].toString().clean(),
        salesofficetype = map["salesofficetype"].toString().clean(),
        salesofficetypename = map["salesofficetypename"].toString().clean(),
        salesofficename = map["salesofficename"].toString().clean();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = userid;
    data['username'] = username;
    data['userroleid'] = userroleid;
    data['regionid'] = regionid;
    data['salesofficeid'] = salesofficeid;
    data['salesgroupid'] = salesgroupid;
    data['salesdistrictid'] = salesdistrictid;
    data['rolename'] = rolename;
    data['salesofficetype'] = salesofficetype;
    data['salesofficetypename'] = salesofficetypename;
    data['salesofficename'] = salesofficename;
    return data;
  }
}
