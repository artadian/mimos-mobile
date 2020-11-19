import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mimos/TF/Model/introdealmodeltf.dart';
import 'package:mimos/Constant/Constant.dart';
class GetIntrodealTFResponse{
  bool status;
  String message;
  List<IntrodealModelTF> data;
  GetIntrodealTFResponse({this.status,this.message,this.data});
   factory GetIntrodealTFResponse.fromJson(Map<String, dynamic> json) {
    return GetIntrodealTFResponse(
      status: json["status"],
      message: json["message"],
      //data : User.fromJson(json["data"]),
      data: List<IntrodealModelTF>.from(json["data"].map((datajason) {
        return IntrodealModelTF.cretaeIntrodealTFFromJson(datajason);
      })),
    );
  }
  Future<GetIntrodealTFResponse> getIntrodealTFFromAPI(String userid,tglakhir) async {
    Map data = {
      'userid': userid,
      'tgl':tglakhir,
      //'X-API-KEY': 'DIMAS'
    };
    var apiResult = await http.post(apiURL + "/Material/introDealTFbyUseridbyTgl", body: data);
    var jsonObject = json.decode(apiResult.body);
    return GetIntrodealTFResponse.fromJson(jsonObject);
  }
}
