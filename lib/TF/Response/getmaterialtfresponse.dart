import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mimos/TF/Model/materialmodeltf.dart';
import 'package:mimos/Constant/Constant.dart';
class GetMaterialTFResponse{
  bool status;
  String message;
  List<MaterialModelTF> data;
  GetMaterialTFResponse({this.status,this.message,this.data});
   factory GetMaterialTFResponse.fromJson(Map<String, dynamic> json) {
    return GetMaterialTFResponse(
      status: json["status"],
      message: json["message"],
      //data : User.fromJson(json["data"]),
      data: List<MaterialModelTF>.from(json["data"].map((datajason) {
        return MaterialModelTF.cretaeMaterialFromJson(datajason);
      })),
    );
  }
  Future<GetMaterialTFResponse> getMaterialTFFromAPI(String userid) async {
    Map data = {
      'userid': userid,
     // 'tgl':tgl
      //'X-API-KEY': 'DIMAS'
    };
    var apiResult = await http.post(apiURL + "/Material/materialTFbyUserid", body: data);
    var jsonObject = json.decode(apiResult.body);
    return GetMaterialTFResponse.fromJson(jsonObject);
  }
}
