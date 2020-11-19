import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mimos/TF/Model/lookupmodel.dart';
import 'package:mimos/Constant/Constant.dart';
class GetLookupResponse{
  bool status;
  String message;
  List<LookupModel> data;
  GetLookupResponse({this.status,this.message,this.data});
   factory GetLookupResponse.fromJson(Map<String, dynamic> json) {
    return GetLookupResponse(
      status: json["status"],
      message: json["message"],
      //data : User.fromJson(json["data"]),
      data: List<LookupModel>.from(json["data"].map((datajason) {
        return LookupModel.cretaeLookupFromJson(datajason);
      })),
    );
  }
  Future<GetLookupResponse> getLookupFromAPI() async {
    Map data = {
      // 'userid': userid,
      // 'tgl':tglakhir,
      // 'tahunawal':tahun
      //'X-API-KEY': 'DIMAS'
    };
    var apiResult = await http.post(apiURL + "/Umum/lookup", body: data);
    var jsonObject = json.decode(apiResult.body);
    return GetLookupResponse.fromJson(jsonObject);
  }
}
