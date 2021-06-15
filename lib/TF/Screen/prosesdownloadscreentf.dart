import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mimos/Constant/Constant.dart';
//import 'package:mimos/TF/Model/konsumenmodelsqllite.dart';
// import 'package:mimos/TF/Response/getintrodealtfresponse.dart';
// import 'package:mimos/TF/Response/getlookupresponse.dart';
// import 'package:mimos/TF/Response/getmaterialtfresponse.dart';
// import 'package:mimos/TF/Response/getpricetfresponse.dart';
import 'package:mimos/db/database.dart';
//import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:string_validator/string_validator.dart';
//import 'package:mimos/TF/Response/getcustmer_user_day_weekresponse.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProsesDownloadDataTF extends StatefulWidget {
  @override
  _ProsesDownloadDataTFState createState() => _ProsesDownloadDataTFState();
}

class _ProsesDownloadDataTFState extends State<ProsesDownloadDataTF> {
  DatabaseProvider _dbprovider = DatabaseProvider();
  // GetCustomerUserDayWeek _getCustomerUserDayWeek = new GetCustomerUserDayWeek();

  // GetMaterialTFResponse _getMaterialTFResponse = new GetMaterialTFResponse();
  // GetPriceTFResponse _getPriceTFResponse = new GetPriceTFResponse();
  // GetIntrodealTFResponse _getIntrodealTFResponse = new GetIntrodealTFResponse();
  // GetLookupResponse _getLookupResponse = new GetLookupResponse();

  final TextEditingController _tglAwal = new TextEditingController();
  //final TextEditingController _tglAkhir = new TextEditingController();

  Future<String> _getUserID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("userid") ?? "No UserID";
  }

  //String name = "";
  bool button = false;
  DateTime _initTgl = DateTime.now();
  DateTime _tglchache = DateTime.now();
  //DateTime _initTglAkhir = DateTime.now();
  //DateTime _tglChacheAkhir = DateTime.now();
String _statusDownload ="";
@override
  void initState() {
    super.initState();
    _tglAwal.text= DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
    //_tglAkhir.text= DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
    _statusDownload ="OK";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        //leading: new Container( child: IconButton(icon: Icon(Icons.keyboard_return), onPressed: (){}),),
        leading: new Container(),
        backgroundColor: Color(0xFF54C5F8),
        title: Text("PROSES DOWNLOAD"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(DOWNLOAD_SCREEN_TF);
              })
        ],
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [MyPalette.ijoMimos, MyPalette.ijoMimos],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight))),
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Expanded(
                    child: Text("Tgl Awal",
                        style: new TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                  //SizedBox(width: 10),
                  new Expanded(
                    child: new TextField(
                      controller: _tglAwal,
                      readOnly: true,
                      // autofocus: true,
                      // decoration: new InputDecoration(
                      //   labelText: "Tgl Awal",
                      // ),

                      onTap: () async {
                        DateTime _tanggal = await showDatePicker(
                          context: context,
                          initialDate:
                              (_initTgl != null) ? _initTgl : DateTime.now(),
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101),
                        );
                        setState(() {
                          // _tglchache = (_tglAwal.text != null && _tglAwal.text != "" )? DateTime.parse(_tglAwal.text):(_tanggal != null)?_tanggal:DateTime.now();
                          _tglchache = (isDate(_tglAwal.text))
                              ? DateTime.parse(_tglAwal.text)
                              : (_tanggal != null) ? _tanggal : DateTime.now();
                          //(_tanggal != null) ? _initTgl = _tanggal : _initTgl = _initTgl;
                          //DateFormat("yyyy-MM-dd").format(DateTime.parse(_tglAwal.text))
                          _initTgl = (_tanggal != null) ? _tanggal : _tglchache;
                          _tglAwal.text = (_tanggal != null)
                              ? DateFormat("yyyy-MM-dd")
                                  .format(_tanggal)
                                  .toString()
                              : DateFormat("yyyy-MM-dd")
                                  .format(_tglchache)
                                  .toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: Text("",
                        style: new TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new RaisedButton(
                        child: const Text("CANCEL"),
                         shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {
                          // Navigator.of(context).pop(false);
                          Navigator.of(context).pushNamed(DOWNLOAD_SCREEN_TF);
                        }),
                  ),
                  SizedBox(width: 10),
                  new Expanded(
                    child: new RaisedButton(
                        child: Text(_statusDownload),
                        color: Colors.green,
                          elevation: 5.0,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {
                          if (!(_tglAwal.value.text.trim().toString().length >
                              1)) {
                            Fluttertoast.showToast(
                                msg: "Tgl Awal Kosong",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                //backgroundColor: Colors.red,
                                textColor: Colors.red,
                                fontSize: 16.0,
                                timeInSecForIosWeb: 1);
                          } else if (!(isDate(_tglAwal.value.text))) {
                            Fluttertoast.showToast(
                                msg: "Format Tgl Awal Salah",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                //backgroundColor: Colors.red,
                                textColor: Colors.red,
                                fontSize: 16.0,
                                timeInSecForIosWeb: 1);
                          }  else {
                            var _tglAwalRange =
                                DateTime.parse(_tglAwal.value.text);
                            // var _tglAkhirRange =
                            //     DateTime.parse(_tglAkhir.value.text);
                            var _rangeValid = false;
                            // if (_tglAkhirRange.isAfter(_tglAwalRange)) {
                            //   _rangeValid = true;
                            // } else if (_tglAkhirRange == _tglAwalRange) {
                               _rangeValid = true;
                            // }

                            if (_rangeValid) {
// start download
                              _getUserID().then((prefUserid) {
                                //proses download customer
                                // for (int i = 0;
                                //     i <=
                                //         _tglAkhirRange
                                //             .difference(_tglAwalRange)
                                //             .inDays;
                                //     i++) {
                                //   var _tgl =
                                //       _tglAwalRange.add(Duration(days: i));
                                //   _downloadDataKonsumen(
                                //     prefUserid,
                                //     DateFormat("yyyy-MM-dd")
                                //         .format(_tgl)
                                //         .toString(),
                                //   );
                                // }
                                _downloadDataKonsumen(
                                    prefUserid,
                                    DateFormat("yyyy-MM-dd")
                                        .format(_tglAwalRange)
                                        .toString(),
                                  );
                                Fluttertoast.showToast(
                                    msg: "Download Customer Selesai",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    // backgroundColor: Colors.green,
                                    textColor: Colors.black,
                                    fontSize: 16.0,
                                    timeInSecForIosWeb: 1);
                                // proses download material
                                _downloadAPIMaterialTF(prefUserid);
                                Fluttertoast.showToast(
                                    msg: "Download Material Selesai",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    // backgroundColor: Colors.green,
                                    textColor: Colors.black,
                                    fontSize: 16.0,
                                    timeInSecForIosWeb: 1);
                                // proses download harga
                                _downloadDataPrice(
                                    prefUserid,
                                    // DateFormat("yyyy-MM-dd")
                                    //     .format(_tglAkhirRange)
                                    //     .toString(),
                                    DateFormat("yyyy-MM-dd")
                                        .format(_tglAwalRange)
                                        .toString());
                                Fluttertoast.showToast(
                                    msg: "Download Price Selesai",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    // backgroundColor: Colors.green,
                                    textColor: Colors.black,
                                    fontSize: 16.0,
                                    timeInSecForIosWeb: 1);

                                _downloadDataIntrodeal(
                                    prefUserid,
                                    // DateFormat("yyyy-MM-dd")
                                    //     .format(_tglAkhirRange)
                                    //     .toString(),
                                    DateFormat("yyyy-MM-dd")
                                        .format(_tglAwalRange)
                                        .toString());
                                Fluttertoast.showToast(
                                    msg: "Download Introdeal Selesai",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    // backgroundColor: Colors.green,
                                    textColor: Colors.black,
                                    fontSize: 16.0,
                                    timeInSecForIosWeb: 1);
// downloag customer_introdeal
                                _downloadDataCustomerIntrodeal(
                                    prefUserid,
                                    // DateFormat("yyyy-MM-dd")
                                    //     .format(_tglAkhirRange)
                                    //     .toString(),
                                    DateFormat("yyyy-MM-dd")
                                        .format(_tglAwalRange)
                                        .toString());
                                Fluttertoast.showToast(
                                    msg: "Download Customer Introdeal Selesai",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    // backgroundColor: Colors.green,
                                    textColor: Colors.black,
                                    fontSize: 16.0,
                                    timeInSecForIosWeb: 1);
                                // download lookup
                                _downloadDataLookup(prefUserid);
                                Fluttertoast.showToast(
                                    msg: "Download Lookup Selesai",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    // backgroundColor: Colors.green,
                                    textColor: Colors.black,
                                    fontSize: 16.0,
                                    timeInSecForIosWeb: 1);
                                    //  download data defalut visibility
                                //      _downloadDataVisibility(prefUserid,DateFormat("yyyy-MM-dd")
                                //         .format(_tglAwalRange)
                                //         .toString());
                                // Fluttertoast.showToast(
                                //     msg: "Download Default Visibility Selesai",
                                //     toastLength: Toast.LENGTH_SHORT,
                                //     gravity: ToastGravity.CENTER,
                                //     // backgroundColor: Colors.green,
                                //     textColor: Colors.black,
                                //     fontSize: 16.0,
                                //     timeInSecForIosWeb: 1);

                                // download visibility wsp
                                 _downloadDataVisibilityWSP(prefUserid,DateFormat("yyyy-MM-dd")
                                        .format(_tglAwalRange)
                                        .toString());
                                Fluttertoast.showToast(
                                    msg: "Download Visibility WSP Selesai",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    // backgroundColor: Colors.green,
                                    textColor: Colors.black,
                                    fontSize: 16.0,
                                    timeInSecForIosWeb: 1);

                                //
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "date period invalid",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  // backgroundColor: Colors.green,
                                  textColor: Colors.black,
                                  fontSize: 16.0,
                                  timeInSecForIosWeb: 1);
                            }
                          }
                        }),
                  )
                ],
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    super.dispose();
   // _tglAkhir.dispose();
    _tglAwal.dispose();
  }

  //============= proses download
  //============ customer
   _downloadDataKonsumen(String userid, tgl) async {
    Map data = {
      'userid': userid,
      'tgl': tgl
      //'X-API-KEY': 'DIMAS'
    };
    var apiResult = await http
        // .post("http://172.27.10.14/apimimos/index.php/api/Customer/customerbyvisitday", body: data);
        .post(apiURL + "/Customer/customerbyvisitday", body: data);
    var jsonObject = json.decode(apiResult.body);
    var getDataApi = jsonObject['data'];
    // var xmgs = jsonObject['message'];
    var xstatus = jsonObject['status'];
    if (xstatus) {
      //_deleteDataTglCust(tgl);
      _deleteDataTglCust();
      for (var item in getDataApi) {
        Database db = await _dbprovider.database;
        List<String> arr = item['ycw'].split(';');
        String _year = arr[0];
        String _cycle = arr[1];
        String _week = arr[2];
        await db.rawInsert(
            "INSERT INTO customer(customerno,userid,name,address,city,owner,phone,customergroupid,customergroupname,priceid,salesdistrictid,salesdistrictname,usersfaid,visitday,visitweek,userroleid,salesgroupid,salesgroupname,salesofficeid,salesofficename,tanggalkunjungan,nourut,regionid,year,cycle,week,wspclass) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
            [
              item['customerno'],
              userid,
              item['name'],
              item['address'],
              item['city'],
              item['owner'],
              item['phone'],
              item['customergroupid'],
              item['customergroupname'],
              item['priceid'],
              item['salesdistrictid'],
              item['salesdistrictname'],
              item['usersfaid'],
              item['visitday'],
              item['visitweek'],
              item['userroleid'],
              item['salesgroupid'],
              item['salesgroupname'],
              item['salesofficeid'],
              item['salesofficename'],
              tgl,
              item['nourut'],
              item['regionid'],
              _year,
              _cycle,
              _week,
              item['wspclass']
            ]);
      }
      //---------------- methode pakai toMap
      // for (var item in getDataApi) {
      //   Database db = await _dbprovider.database;
      //   await db.insert("customer", KonsumenModelSQLite.createCustomerFromJson(item).toDatabaseJson());
      // }
      //-----
    }
  }

  // _deleteAllDataCust() async {
  //   Database db = await _dbprovider.database;
  //   //var result = await db.rawDelete("DELETE FROM customer WHERE userid ='"+ userid +"' AND customerno ='"+ item.customerno +"' and visitday ='"+ item.visitday +"' and visitweek ='"+ item.visitweek +"' ");
  //   int result = await db.rawDelete("DELETE FROM customer ");
  //   return result;
  // }

  //_deleteDataTglCust(String tgl) async {
    _deleteDataTglCust() async {
    Database db = await _dbprovider.database;
    int result = await db.rawDelete(
        //"DELETE FROM customer WHERE  tanggalkunjungan ='" + tgl + "'  ");
        "DELETE FROM customer   ");
    //int result = await db.rawDelete("DELETE FROM customer ");
    return result;
  }

  ///---- end download Konsumen
  //=========== lookup

  _deleteAllDataLookup() async {
    Database db = await _dbprovider.database;
    var result = await db.rawDelete("DELETE FROM lookup ");
    return result;
  }

  _downloadDataLookup(userid) async {
    Map data = {
      'userid': userid,
      //'X-API-KEY': 'DIMAS'
    };

    var apiResult = await http
        //.post("http://172.27.11.41/apimimos/index.php/api/Umum/lookup", body: data);
        .post(apiURL + "/Umum/lookup", body: data);
    var jsonObject = json.decode(apiResult.body);
    var getDataApi = jsonObject['data'];
    // var xmgs = jsonObject['message'];
    var xstatus = jsonObject['status'];
    if (xstatus) {
      _deleteAllDataLookup();
      for (var item in getDataApi) {
        Database db = await _dbprovider.database;
        await db.rawInsert(
            "INSERT INTO lookup(lookupid,lookupkey,lookupvalue,lookupdesc) VALUES(?,?,?,?)",
            [
              item['lookupid'],
              item['lookupkey'],
              item['lookupvalue'],
              item['lookupdesc']
            ]);
      }
    }
  }
  //=========== end lookup
  //=========== visibilitywsp
  _deleteAllDataVisibilityWSP() async {
    Database db = await _dbprovider.database;
    var result = await db.rawDelete("DELETE FROM visibility_wsp ");
    return result;
  }
  _downloadDataVisibilityWSP(
      String userid,String tgl) async {
    Map data = {
      'UserID': userid,
      'tgl': tgl,
    };
    var apiResult = await http
        //.post("http://172.27.11.41/apimimos/index.php/api/Material/introDealTFbyUseridbyTgl", body: data);
        //.post(apiURL + "/Material/visibilitywspbyUserid",
        .post(apiURL + "/Material/customerWSPClassStockbyUseridbyTgl",
            body: data);
    var jsonObject = json.decode(apiResult.body);
    var getDataApi = jsonObject['data'];
    // var xmgs = jsonObject['message'];
    var xstatus = jsonObject['status'];
    if (xstatus) {
      _deleteAllDataVisibilityWSP();
       _deleteAllDataVisibility();
      _deleteAllDataStock();

      for (var item in getDataApi) {
        Database db = await _dbprovider.database;
        await db.rawInsert(
            "INSERT INTO visibility_wsp(materialid,materialgroupid,wspclass,customerno,tglkunjungan,pac) VALUES(?,?,?,?,?,?)",
            [item['materialid'], item['materialgroupid'], item['wspclass'], item['customerno'], item['tglkunjungan'], item['pac']]);
            //--- insert stock defult
        Database db2 = await _dbprovider.database;
         await db2.rawInsert(
            "INSERT INTO stocktf(customerno,userid,tglkunjungan,materialid,bal,slof,qtystock,getidstockdetail,ismaterialdefault,iscek,pac) VALUES(?,?,?,?,?,?,?,?,?,?,?)",
            [item['customerno'], userid, tgl, item['materialid'], 0,0,0, '-1','Y','N',0]);
            //-- insert visibility default
            Database db3 = await _dbprovider.database;
          await db3.rawInsert(
            "INSERT INTO visibility(customerno,userid,tglkunjungan,materialid,getidvisibilitydetail,ismaterialdefault,iscek,pac) VALUES(?,?,?,?,?,?,?,?)",
            [item['customerno'], userid, tgl, item['materialid'],  '-1','Y','N',0]);
      }
    }
    setState(() {
          _statusDownload = "Finish";
        });
  }
  //=========== end visibilitywsp
  // ====== download cutomer materialid
  _deleteAllDataVisibility() async {
    Database db = await _dbprovider.database;
    var result = await db.rawDelete("DELETE FROM visibility ");
    return result;
  }
  _deleteAllDataStock() async {
    Database db = await _dbprovider.database;
    var result = await db.rawDelete("DELETE FROM stocktf ");
    return result;
  }
  //  _downloadDataVisibility(
  //     String userid,String tgl) async {
  //   Map data = {
  //     'userid': userid,
  //     'tgl': tgl,
  //   };
  //   var apiResult = await http
  //       //.post("http://172.27.11.41/apimimos/index.php/api/Material/introDealTFbyUseridbyTgl", body: data);
  //       //.post(apiURL + "/Material/visibilitywspbyUserid",
  //       .post(apiURL + "/Customer/getcustomermaterialidbyuseridbytgl",
  //           body: data);
  //   var jsonObject = json.decode(apiResult.body);
  //   var getDataApi = jsonObject['data'];
  //   // var xmgs = jsonObject['message'];
  //   var xstatus = jsonObject['status'];
  //   if (xstatus) {
  //     _deleteAllDataVisibility();
  //     _deleteAllDataStock();
  //     for (var item in getDataApi) {
  //       var xwspclass = item['wspclass'];
  //       if (xwspclass != "-") {
  //         Database db = await _dbprovider.database;
  //         await db.rawInsert(
  //           "INSERT INTO visibility(customerno,userid,tglkunjungan,materialid,getidvisibilitydetail,ismaterialdefault,iscek,pac) VALUES(?,?,?,?,?,?,?,?)",
  //           [item['customerno'], userid, tgl, item['materialid'],  '-1','Y','N',0]);
  //       }
  //       //--- insert stock defult
  //       Database db2 = await _dbprovider.database;
  //        await db2.rawInsert(
  //           "INSERT INTO stocktf(customerno,userid,tglkunjungan,materialid,bal,slof,qtystock,getidstockdetail,ismaterialdefault,iscek,pac) VALUES(?,?,?,?,?,?,?,?,?,?,?)",
  //           [item['customerno'], userid, tgl, item['materialid'], 0,0,0, '-1','Y','N',0]);
  //     }
  //   }
  // }
  //====== end download customer materialid
  //---- customer_introdeal
  _deleteAllDataCustomerIntrodealTF() async {
    Database db = await _dbprovider.database;
    var result = await db.rawDelete("DELETE FROM customer_introdeal ");
    return result;
  }

  _downloadDataCustomerIntrodeal(
      String userid, tglawal) async {
    Map data = {
      'userid': userid,
      'tglawal': tglawal,
    };
    var apiResult = await http
        //.post("http://172.27.11.41/apimimos/index.php/api/Material/introDealTFbyUseridbyTgl", body: data);
        .post(apiURL + "/Material/customerIntroDealTFbyUseridbyTgl",
            body: data);
    var jsonObject = json.decode(apiResult.body);
    var getDataApi = jsonObject['data'];
    // var xmgs = jsonObject['message'];
    var xstatus = jsonObject['status'];
    if (xstatus) {
      _deleteAllDataCustomerIntrodealTF();
      for (var item in getDataApi) {
        Database db = await _dbprovider.database;
        await db.rawInsert(
            "INSERT INTO customer_introdeal(introdealid,materialid,customerno) VALUES(?,?,?)",
            [item['introdealid'], item['materialid'], item['customerno']]);
      }
    }
  }

  //---- end customer introdeal
  //=========== introdeal
  _deleteAllDataIntrodealTF() async {
    Database db = await _dbprovider.database;
    var result = await db.rawDelete("DELETE FROM introdeal ");
    return result;
  }

  _downloadDataIntrodeal(String userid,  tglawal) async {
    Map data = {
      'userid': userid,
      'tglawal': tglawal,
    };
    var apiResult = await http
        //.post("http://172.27.11.41/apimimos/index.php/api/Material/introDealTFbyUseridbyTgl", body: data);
        .post(apiURL + "/Material/introDealTFbyUseridbyTgl", body: data);
    var jsonObject = json.decode(apiResult.body);
    var getDataApi = jsonObject['data'];
    // var xmgs = jsonObject['message'];
    var xstatus = jsonObject['status'];
    if (xstatus) {
      _deleteAllDataIntrodealTF();
      for (var item in getDataApi) {
        Database db = await _dbprovider.database;
        await db.rawInsert(
            "INSERT INTO introdeal(materialid,materialname,qtyorder,qtybonus,tglmulaiberlaku,since,introdealid,tglakhirberlaku,expired) VALUES(?,?,?,?,?,?,?,?,?)",
            [
              item['materialid'],
              item['materialname'],
              item['qtyorder'],
              item['qtybonus'],
              item['tglmulaiberlaku'],
              item['since'],
              item['introdealid'],
              item['tglakhirberlaku'],
              item['expired']
            ]);
      }
    }
  }

  //=========== end introdeal
  // =========== Price
  _deleteAllDataPriceTF() async {
    Database db = await _dbprovider.database;
    var result = await db.rawDelete("DELETE FROM price ");
    return result;
  }

   _downloadDataPrice(String userid, tglawal) async {
    Map data = {'userid': userid,  'tglawal': tglawal};
    var apiResult = await http
        //.post("http://172.27.11.41/apimimos/index.php/api/Material/hargamaterialTFbyUseridbytgl", body: data);
        .post(apiURL + "/Material/hargamaterialTFbyUseridbytgl", body: data);
    var jsonObject = json.decode(apiResult.body);
    var getDataApi = jsonObject['data'];
    // var xmgs = jsonObject['message'];
    var xstatus = jsonObject['status'];
    if (xstatus) {
      _deleteAllDataPriceTF();
      for (var item in getDataApi) {
        Database db = await _dbprovider.database;
        await db.rawInsert(
            "INSERT INTO price(materialid,materialname,priceid,harga,since,tglmulaiberlaku) VALUES(?,?,?,?,?,?)",
            [
              item['materialid'],
              item['materialname'],
              item['priceid'],
              item['harga'],
              item['since'],
              item['tglmulaiberlaku']
            ]);
      }
    }
  }

  //============ end price
  // ============ material
  _deleteAllDataMaterialTF() async {
    Database db = await _dbprovider.database;
    var result = await db.rawDelete("DELETE FROM materialtf ");
    return result;
  }

 _downloadAPIMaterialTF(String userid) async {
    Map data = {'userid': userid};
    var apiResult = await http
        //.post("http://172.27.11.41/apimimos/index.php/api/Material/materialTFbyUserid", body: data);
        .post(apiURL + "/Material/materialTFbyUserid", body: data);
    var jsonObject = json.decode(apiResult.body);
    var getDataApi = jsonObject['data'];
    // var xmgs = jsonObject['message'];
    var xstatus = jsonObject['status'];
    if (xstatus) {
      _deleteAllDataMaterialTF();
      for (var item in getDataApi) {
        Database db = await _dbprovider.database;
        await db.rawInsert(
            "INSERT INTO materialtf(materialid,materialname,materialgroupid,bal,slof,pac,materialgroupdescription) VALUES(?,?,?,?,?,?,?)",
            [
              item['materialid'],
              item['materialname'],
              item['materialgroupid'],
              item['bal'],
              item['slof'],
              item['pac'],
              item['materialgroupdescription']
            ]);
      }
    }
  }
  //--- end download material

  //---- download material group

  //---- end download material group
  //======= end proses download
}
