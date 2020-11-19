import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mimos/TF/Model/pricemodeltf.dart';
import 'package:mimos/Constant/Constant.dart';
class GetPriceTFResponse{
  bool status;
  String message;
  List<PriceModelTF> data;
  GetPriceTFResponse({this.status,this.message,this.data});
   factory GetPriceTFResponse.fromJson(Map<String, dynamic> json) {
    return GetPriceTFResponse(
      status: json["status"],
      message: json["message"],
      //data : User.fromJson(json["data"]),
      data: List<PriceModelTF>.from(json["data"].map((datajason) {
        return PriceModelTF.cretaePriceTFFromJson(datajason);
      })),
    );
  }
  Future<GetPriceTFResponse> getPriceTFFromAPI(String userid,tglakhir,tahun) async {
    Map data = {
      'userid': userid,
      'tgl':tglakhir,
      'tahunawal':tahun
      //'X-API-KEY': 'DIMAS'
    };
    var apiResult = await http.post(apiURL + "/Material/hargamaterialTFbyUseridbytgl", body: data);
    var jsonObject = json.decode(apiResult.body);
    return GetPriceTFResponse.fromJson(jsonObject);
  }
}
