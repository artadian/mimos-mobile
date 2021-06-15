import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Constant/listmenu.dart';
import 'package:mimos/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UploadScreenTF extends StatefulWidget {
  @override
  _UploadScreenTFState createState() => _UploadScreenTFState();
}

class _UploadScreenTFState extends State<UploadScreenTF> {
  Future<void> _dialogCall(BuildContext context) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "Clear Data",
      desc: "all data will be permanently deleted",
      buttons: [
        DialogButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(194, 194, 214, 1.0),
        ),
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            _deleteTablePenjualan();
            _deleteTablePosm();
            _deleteTableStock();
            _deleteTableVisibility();
            _deleteTableVisit();
            _deleteTablecustomer();
            _deleteTablecustomerintrodeal();
            _deleteTableintrodeal();
            _deleteTablelookup();
            _deleteTablematerialtf();
            _deleteTableprice();
            Navigator.pop(context);
          },
          color: Color.fromRGBO(255, 0, 0, 1.0),
        )
      ],
    ).show();
  }

  final _dbProvider = DatabaseProvider.dbProvider;
  var listMenuHome = listMenuItemUploadTF;
  Future<String> _getDataUserID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("userid") ?? "No UserID";
  }

  String _userID;
  @override
  void initState() {
    super.initState();
    _getDataUserID().then((val) => setState(() {
          _userID = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double appBarHeight = kToolbarHeight;
    final double paddingBottom = mediaQueryData.padding.bottom;
    final double heightScreen =
        mediaQueryData.size.height - paddingBottom - appBarHeight;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF54C5F8),
        title: Text("UPLOAD DATA"),
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [MyPalette.ijoMimos, MyPalette.ijoMimos],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight))),
      ),
      body: SafeArea(
          child: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.only(top: 10),
        childAspectRatio: widthScreen / (heightScreen / 1.2),
        children: listMenuHome
            // children :  (userRoleID == "1" )? listMenuItemTF:listMenuItemFL
            .map((data) => GestureDetector(
                onTap: () {
                  //Navigator.push(context,
                  // MaterialPageRoute(builder: (context) {
                  if (data.tampilan.toString() == "111") {
                    _uploadDataVisit();
                    Fluttertoast.showToast(
                        msg: "Upload Data Visit Selesai",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        // backgroundColor: Colors.green,
                        textColor: Colors.black,
                        fontSize: 16.0,
                        timeInSecForIosWeb: 1);
                    _uploadHeadPenjualan();
                    Fluttertoast.showToast(
                        msg: "Upload Data Sellin Selesai",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        // backgroundColor: Colors.green,
                        textColor: Colors.black,
                        fontSize: 16.0,
                        timeInSecForIosWeb: 1);
                    _uploadHeadPosm();
                    Fluttertoast.showToast(
                        msg: "Upload Data Posm Selesai",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        // backgroundColor: Colors.green,
                        textColor: Colors.black,
                        fontSize: 16.0,
                        timeInSecForIosWeb: 1);
                    _uploadHeadStock();
                    Fluttertoast.showToast(
                        msg: "Upload Data Stock Selesai",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        // backgroundColor: Colors.green,
                        textColor: Colors.black,
                        fontSize: 16.0,
                        timeInSecForIosWeb: 1);
                    _uploadHeadVisibility();
                    Fluttertoast.showToast(
                        msg: "Upload Data Cek Display Selesai",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        // backgroundColor: Colors.green,
                        textColor: Colors.black,
                        fontSize: 16.0,
                        timeInSecForIosWeb: 1);

                        Fluttertoast.showToast(
                        msg: "Upload Selesai",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        // backgroundColor: Colors.green,
                        textColor: Colors.black,
                        fontSize: 16.0,
                        timeInSecForIosWeb: 1);
                  } else if (data.tampilan.toString() == "121") {
                    Navigator.of(context).pushNamed(CHECK_SELLIN_UPLOAD_SCREEN);
                  } else if (data.tampilan.toString() == "122") {
                    Navigator.of(context).pushNamed(CHECK_POSM_UPLOAD_SCREEN);
                  } else if (data.tampilan.toString() == "123") {
                    Navigator.of(context).pushNamed(CHECK_STOCK_UPLOAD_SCREEN);
                  } else if (data.tampilan.toString() == "124") {
                    Navigator.of(context)
                        .pushNamed(CHECK_VISIBILITY_UPLOAD_SCREEN);
                  } else if (data.tampilan.toString() == "131") {
                    _dialogCall(context);
                  } else {
                    // return LogInScreen();
                    //_logOut();
                  }
                  //}));
                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    // color: Colors.transparent,
                    // decoration: BoxDecoration(
                    //   shape : BoxShape.rectangle,
                    //   borderRadius : BorderRadius.all(Radius.elliptical(10.0, 12.0))
                    // ),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: data.lambang,
                          ),
                          Text(data.judul,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    ))))
            .toList(),
      )),
    );
  }

  _deleteTablePosm() async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " Delete from posmtf ";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _deleteTableStock() async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " Delete from stocktf ";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _deleteTableVisibility() async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " Delete from visibility ";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _deleteTablePenjualan() async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " Delete from penjualan ";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _deleteTableVisit() async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " Delete from visittf ";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _deleteTablecustomer() async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " Delete from customer ";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _deleteTablematerialtf() async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " Delete from materialtf ";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _deleteTableprice() async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " Delete from price ";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _deleteTablelookup() async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " Delete from lookup ";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _deleteTableintrodeal() async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " Delete from introdeal ";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _deleteTablecustomerintrodeal() async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " Delete from customer_introdeal ";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _updateGetIDRestServerTableVisit(visittrxid, trx, getidrest) async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " UPDATE visittf set ";
    if (trx == "visit") {
      strSQL = strSQL + " getidvisit ='" + getidrest.toString() + "'";
    } else if (trx == "penjualan") {
      strSQL = strSQL + " getidsellin ='" + getidrest.toString() + "'";
      strSQL = strSQL + " ,iseditsellin ='N'";
    } else if (trx == "posm") {
      strSQL = strSQL + " getidposm ='" + getidrest.toString() + "'";
      strSQL = strSQL + " ,iseditposm ='N'";
    } else if (trx == "stock") {
      strSQL = strSQL + " getidstock ='" + getidrest.toString() + "'";
      strSQL = strSQL + " ,iseditstock ='N'";
    } else if (trx == "visibility") {
      strSQL = strSQL + " getidvisibility ='" + getidrest.toString() + "'";
      strSQL = strSQL + " ,iseditvisibility ='N'";
    }
    strSQL = strSQL + " where visittrxid =" + visittrxid + "";
    //print(strSQL);
    int result = await db.rawInsert(strSQL);
    return result;
  }

//--- upload data penjualan
  _updateGetIDRestServerDetailPenjualan(trxid, getid) async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL =
        " UPDATE penjualan set getidsellindetail = '" + getid.toString() + "' ";
    strSQL = strSQL + " where penjualantrxid =" + trxid + "";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _uploadDetailPenjualan(xcustomerno, xtglkunjungan, xIDHead) async {
    Database db = await _dbProvider.database;
    String strSQL;
    strSQL =
        // "SELECT p.materialid, p.qtypenjualan, p.bal,p.slof,p.pac, p.introdeal, p.harga, p.harga * p.qtypenjualan as sellinvalue FROM visit v INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN penjualan p ON v.customerno = p.customerno AND v.tglkunjungan = p.tglkunjungan AND v.userid = p.userid where v.userid = '"+ _userID +"' and v.tglkunjungan ='"+ xtglkunjungan +"' and v.customerno ='"+ xcustomerno +"' and v.nonota <>'-1'";
        "SELECT p.penjualantrxid,p.materialid, p.qtypenjualan, p.bal,p.slof,p.pac, p.introdeal, p.harga, p.harga * p.qtypenjualan as sellinvalue FROM penjualan p where p.userid = '" +
            _userID +
            "' and p.tglkunjungan ='" +
            xtglkunjungan +
            "' and p.customerno ='" +
            xcustomerno +
            "' ";
    List<Map> resultd = await db.rawQuery(strSQL);
    // print(strSQL.toString());
    //return result;
    if (resultd.isNotEmpty) {
      var n = 0;
      for (n = 0; n < resultd.length; n++) {
        //print(resultd[n]["materialid"].toString() + " Qty " + resultd[n]["qtypenjualan"].toString());
        Map data = {
          'trxid': xIDHead.toString(),
          'userid': _userID.toString(),
          'materialid': resultd[n]["materialid"].toString(),
          'bal': resultd[n]["bal"].toString(),
          'slof': resultd[n]["slof"].toString(),
          'pac': resultd[n]["pac"].toString(),
          'qtypenjualan': resultd[n]["qtypenjualan"].toString(),
          'introdeal': resultd[n]["introdeal"].toString(),
          'harga': resultd[n]["harga"].toString(),
          'sellinvalue': resultd[n]["sellinvalue"].toString(),
        };
        var apiResult = await http
            //.post("http://172.27.11.41/apimimos/index.php/api/Material/hargamaterialTFbyUseridbytgl", body: data);
            .post(apiURL + "/InjectDB/injectSellingDetail", body: data);
        var jsonObject = json.decode(apiResult.body);
        var getDataApi = jsonObject['data'];
        // var xmgs = jsonObject['message'];
        //print(xmgs.toString());
        var xstatus = jsonObject['status'];
        if (xstatus) {
          _updateGetIDRestServerDetailPenjualan(
              resultd[n]["penjualantrxid"].toString(), getDataApi);
        }
      }
    }
  }

  //  List<Map<String,dynamic>> dataDetail =[
  //    {"materialid":"1","qtypenjualan":1,"bal":0,"slof":1,"pac":5,"introdeal":2,"harga":1000,"sellinvalue":25000},
  //    {"materialid":"2","qtypenjualan":1,"bal":0,"slof":1,"pac":5,"introdeal":2,"harga":1000,"sellinvalue":25000},
  //  ];

  _uploadHeadPenjualan() async {
    Database db = await _dbProvider.database;
    String strSQL;
    // amount diambil dari sum table penjualan
    //from visittf v INNER JOIN penjualan s ON s.customerno = v.customerno AND v.userid = s.userid AND v.tglkunjungan = s.tglkunjungan INNER JOIN materialtf m ON s.materialid = m.materialid
    strSQL =
        "SELECT v.visittrxid, v.getidsellin, v.customerno, v.tglkunjungan,v.nonota,c.regionid,c.salesofficeid,c.salesgroupid,c.salesdistrictid,SUM (((p.bal *( m.bal / m.pac)) + (p.slof * (m.slof / m.pac)) + p.pac) * p.harga) as amount,c.cycle,c.week,c.year FROM visittf v INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN penjualan p ON v.customerno = p.customerno AND v.tglkunjungan = p.tglkunjungan AND v.userid = p.userid INNER JOIN materialtf m ON p.materialid = m.materialid where v.nonota <>'-1' and v.getidsellin ='-1' and v.userid ='" +
            _userID +
            "' GROUP BY v.visittrxid, v.getidsellin, v.customerno, v.tglkunjungan,v.nonota,c.regionid,c.salesofficeid,c.salesgroupid,c.salesdistrictid,c.cycle,c.week,c.year ";
    List<Map> result = await db.rawQuery(strSQL);
    //print(result.length.toString());
    if (result.isNotEmpty) {
      var i = 0;
      for (i = 0; i < result.length; i++) {
        var _xTrx;
        //getidsellin
        if (result[i]["getidsellin"].toString() != "-1") {
          _xTrx = "edit";
        } else {
          _xTrx = "new";
        }
        //print(_xTrx);
        Map data = {
          'trx': _xTrx,
          'trxid': result[i]["getidsellin"].toString(),
          'nonota': result[i]["nonota"].toString(),
          'userid': _userID.toString(),
          'customerno': result[i]["customerno"].toString(),
          'tglkunjungan': result[i]["tglkunjungan"].toString(),
          'regionid': result[i]["regionid"].toString(),
          'salesofficeid': result[i]["salesofficeid"].toString(),
          'salesgroupid': result[i]["salesgroupid"].toString(),
          'salesdistrictid': result[i]["salesdistrictid"].toString(),
          'amountnota': result[i]["amount"].toString(),
          'cycle': result[i]["cycle"].toString(),
          'week': result[i]["week"].toString(),
          'year': result[i]["year"].toString(),
          // 'detail' : dataDetail.toString()
          // 'detail' : _getDetailPenjualan(result[i]["customerno"].toString(),result[i]["tglkunjungan"].toString())
        };
        var apiResult = await http
            //.post("http://172.27.11.41/apimimos/index.php/api/Material/hargamaterialTFbyUseridbytgl", body: data);
            .post(apiURL + "/InjectDB/injectSellingHead", body: data);
        var jsonObject = json.decode(apiResult.body);
        var getDataApi = jsonObject['data'];
        //var xmgs = jsonObject['message'];
        var xstatus = jsonObject['status'];
        if (xstatus) {
          // upload detail
          _uploadDetailPenjualan(result[i]["customerno"].toString(),
              result[i]["tglkunjungan"].toString(), getDataApi);
          // update idvist sqlite
          _updateGetIDRestServerTableVisit(
              result[i]["visittrxid"].toString(), "penjualan", getDataApi);
        }
      }
    }
  }

//---- end upload penjualan
//---- upload posm
  _updateGetIDRestServerDetailPosm(trxid, getid) async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " UPDATE posmtf set getidposmdetail = '" + getid.toString() + "' ";
    strSQL = strSQL + " where posmtrxid =" + trxid + "";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _uploadDetailPosm(xcustomerno, xtglkunjungan, xIDHead) async {
    Database db = await _dbProvider.database;
    String strSQL;
    strSQL =
        "SELECT p.posmtrxid,p.materialid, p.type,p.qty,p.status,p.note,p.condition FROM posmtf p where p.userid = '" +
            _userID +
            "' and p.tglkunjungan ='" +
            xtglkunjungan +
            "' and p.customerno ='" +
            xcustomerno +
            "' ";
    List<Map> resultd = await db.rawQuery(strSQL);
    // print(strSQL.toString());
    //return result;
    if (resultd.isNotEmpty) {
      var n = 0;
      for (n = 0; n < resultd.length; n++) {
        //print(resultd[n]["materialid"].toString() + " Qty " + resultd[n]["qtypenjualan"].toString());
        Map data = {
          'trxid': xIDHead.toString(),
          'userid': _userID.toString(),
          'materialgroupid': resultd[n]["materialid"].toString(),
          'posmtypeid': resultd[n]["type"].toString(),
          'status': resultd[n]["status"].toString(),
          'condition': resultd[n]["condition"].toString(),
          'qty': resultd[n]["qty"].toString(),
          'note': resultd[n]["note"].toString(),
        };
        var apiResult = await http
            //.post("http://172.27.11.41/apimimos/index.php/api/Material/hargamaterialTFbyUseridbytgl", body: data);
            .post(apiURL + "/InjectDB/injectPosmDetail", body: data);
        var jsonObject = json.decode(apiResult.body);
        var getDataApi = jsonObject['data'];
        // var xmgs = jsonObject['message'];
        //print(xmgs.toString());
        var xstatus = jsonObject['status'];
        if (xstatus) {
          _updateGetIDRestServerDetailPosm(
              resultd[n]["posmtrxid"].toString(), getDataApi);
        }
      }
    }
  }

  _uploadHeadPosm() async {
    Database db = await _dbProvider.database;
    String strSQL;
    // amount diambil dari sum table penjualan
    //from visittf v INNER JOIN penjualan s ON s.customerno = v.customerno AND v.userid = s.userid AND v.tglkunjungan = s.tglkunjungan INNER JOIN materialtf m ON s.materialid = m.materialid
    strSQL =
        "SELECT distinct v.visittrxid, v.getidposm, v.customerno, v.tglkunjungan,c.regionid,c.salesofficeid,c.salesgroupid,c.salesdistrictid,c.cycle,c.week,c.year FROM visittf v INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN posmtf p ON v.customerno = p.customerno AND v.tglkunjungan = p.tglkunjungan AND v.userid = p.userid INNER JOIN materialtf m ON p.materialid = m.materialgroupid where  v.getidposm ='-1' and v.userid ='" +
            _userID +
            "'";
    List<Map> result = await db.rawQuery(strSQL);
    // print(strSQL);
    //print(result.length.toString());
    if (result.isNotEmpty) {
      var i = 0;
      for (i = 0; i < result.length; i++) {
        var _xTrx;
        //getidsellin
        if (result[i]["getidposm"].toString() != "-1") {
          _xTrx = "edit";
        } else {
          _xTrx = "new";
        }
        //print(_xTrx);
        Map data = {
          'trx': _xTrx,
          'trxid': result[i]["getidposm"].toString(),
          'userid': _userID.toString(),
          'customerno': result[i]["customerno"].toString(),
          'tglkunjungan': result[i]["tglkunjungan"].toString(),
          'regionid': result[i]["regionid"].toString(),
          'salesofficeid': result[i]["salesofficeid"].toString(),
          'salesgroupid': result[i]["salesgroupid"].toString(),
          'salesdistrictid': result[i]["salesdistrictid"].toString(),
          'cycle': result[i]["cycle"].toString(),
          'week': result[i]["week"].toString(),
          'year': result[i]["year"].toString(),
        };
        var apiResult = await http
            //.post("http://172.27.11.41/apimimos/index.php/api/Material/hargamaterialTFbyUseridbytgl", body: data);
            .post(apiURL + "/InjectDB/injectPosmHead", body: data);
        var jsonObject = json.decode(apiResult.body);
        var getDataApi = jsonObject['data'];
        //var xmgs = jsonObject['message'];
        var xstatus = jsonObject['status'];
        //print(xmgs);
        if (xstatus) {
          // upload detail
          _uploadDetailPosm(result[i]["customerno"].toString(),
              result[i]["tglkunjungan"].toString(), getDataApi);
          // update idvist sqlite
          _updateGetIDRestServerTableVisit(
              result[i]["visittrxid"].toString(), "posm", getDataApi);
        }
      }
    }
  }
//----- end upload posm

// --- upload data stock
  _updateGetIDRestServerDetailStock(trxid, getid) async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL =
        " UPDATE stocktf set getidstockdetail = '" + getid.toString() + "' ";
    strSQL = strSQL + " where stocktrxid =" + trxid + "";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _uploadDetailStock(xcustomerno, xtglkunjungan, xIDHead) async {
    Database db = await _dbProvider.database;
    String strSQL;
    strSQL =
        "SELECT p.stocktrxid,p.materialid, p.bal,p.qtystock,p.slof,p.pac FROM stocktf p where p.userid = '" +
            _userID +
            "' and p.tglkunjungan ='" +
            xtglkunjungan +
            "' and p.customerno ='" +
            xcustomerno +
            "' ";
    List<Map> resultd = await db.rawQuery(strSQL);
    // print(strSQL.toString());
    //return result;
    if (resultd.isNotEmpty) {
      var n = 0;
      for (n = 0; n < resultd.length; n++) {
        //print(resultd[n]["materialid"].toString() + " Qty " + resultd[n]["qtystock"].toString());
        Map data = {
          'trxid': xIDHead.toString(),
          'userid': _userID.toString(),
          'materialid': resultd[n]["materialid"].toString(),
          'bal': resultd[n]["bal"].toString(),
          'slof': resultd[n]["slof"].toString(),
          'pac': resultd[n]["pac"].toString(),
          'qtystock': resultd[n]["qtystock"].toString(),
        };
        var apiResult = await http
            //.post("http://172.27.11.41/apimimos/index.php/api/Material/hargamaterialTFbyUseridbytgl", body: data);
            .post(apiURL + "/InjectDB/injectStockDetail", body: data);
        var jsonObject = json.decode(apiResult.body);
        var getDataApi = jsonObject['data'];
        // var xmgs = jsonObject['message'];
        //print(xmgs.toString());
        var xstatus = jsonObject['status'];
        if (xstatus) {
          _updateGetIDRestServerDetailStock(
              resultd[n]["stocktrxid"].toString(), getDataApi);
        }
      }
    }
  }

  _uploadHeadStock() async {
    Database db = await _dbProvider.database;
    String strSQL;
    // amount diambil dari sum table penjualan
    //from visittf v INNER JOIN penjualan s ON s.customerno = v.customerno AND v.userid = s.userid AND v.tglkunjungan = s.tglkunjungan INNER JOIN materialtf m ON s.materialid = m.materialid
    strSQL =
        "SELECT distinct v.visittrxid, v.getidstock, v.customerno, v.tglkunjungan,c.regionid,c.salesofficeid,c.salesgroupid,c.salesdistrictid,c.cycle,c.week,c.year FROM visittf v INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN stocktf p ON v.customerno = p.customerno AND v.tglkunjungan = p.tglkunjungan AND v.userid = p.userid INNER JOIN materialtf m ON p.materialid = m.materialid where  v.getidstock ='-1' and v.userid ='" +
            _userID +
            "'";
    List<Map> result = await db.rawQuery(strSQL);
    //print(result.length.toString());
    if (result.isNotEmpty) {
      var i = 0;
      for (i = 0; i < result.length; i++) {
        var _xTrx;
        //getidsellin
        if (result[i]["getidstock"].toString() != "-1") {
          _xTrx = "edit";
        } else {
          _xTrx = "new";
        }
        //print(_xTrx);
        Map data = {
          'trx': _xTrx,
          'trxid': result[i]["getidstock"].toString(),
          'userid': _userID.toString(),
          'customerno': result[i]["customerno"].toString(),
          'tglkunjungan': result[i]["tglkunjungan"].toString(),
          'regionid': result[i]["regionid"].toString(),
          'salesofficeid': result[i]["salesofficeid"].toString(),
          'salesgroupid': result[i]["salesgroupid"].toString(),
          'salesdistrictid': result[i]["salesdistrictid"].toString(),
          'cycle': result[i]["cycle"].toString(),
          'week': result[i]["week"].toString(),
          'year': result[i]["year"].toString(),
        };
        var apiResult = await http
            //.post("http://172.27.11.41/apimimos/index.php/api/Material/hargamaterialTFbyUseridbytgl", body: data);
            .post(apiURL + "/InjectDB/injectStockHead", body: data);
        var jsonObject = json.decode(apiResult.body);
        var getDataApi = jsonObject['data'];
        //var xmgs = jsonObject['message'];
        var xstatus = jsonObject['status'];
        //print(xmgs);
        if (xstatus) {
          // upload detail
          _uploadDetailStock(result[i]["customerno"].toString(),
              result[i]["tglkunjungan"].toString(), getDataApi);
          // update idvist sqlite
          _updateGetIDRestServerTableVisit(
              result[i]["visittrxid"].toString(), "stock", getDataApi);
        }
      }
    }
  }

// --- end upload data stock
//---- upload data visibility
  _updateGetIDRestServerDetailVisibility(trxid, getid) async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " UPDATE visibility set getidvisibilitydetail = '" +
        getid.toString() +
        "' ";
    strSQL = strSQL + " where visibilitytrxid =" + trxid + "";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _uploadDetailVisibility(xcustomerno, xtglkunjungan, xIDHead) async {
    Database db = await _dbProvider.database;
    String strSQL;
    strSQL =
        "SELECT p.visibilitytrxid,p.materialid,p.pac FROM visibility p where p.userid = '" +
            _userID +
            "' and p.tglkunjungan ='" +
            xtglkunjungan +
            "' and p.customerno ='" +
            xcustomerno +
            "' ";
    List<Map> resultd = await db.rawQuery(strSQL);
    // print(strSQL.toString());
    //return result;
    if (resultd.isNotEmpty) {
      var n = 0;
      for (n = 0; n < resultd.length; n++) {
        //print(resultd[n]["materialid"].toString() + " Qty " + resultd[n]["qtystock"].toString());
        Map data = {
          'trxid': xIDHead.toString(),
          'userid': _userID.toString(),
          'materialid': resultd[n]["materialid"].toString(),
          'pac': resultd[n]["pac"].toString(),
        };
        var apiResult = await http
            //.post("http://172.27.11.41/apimimos/index.php/api/Material/hargamaterialTFbyUseridbytgl", body: data);
            .post(apiURL + "/InjectDB/injectVisibilityDetail", body: data);
        var jsonObject = json.decode(apiResult.body);
        var getDataApi = jsonObject['data'];
        // var xmgs = jsonObject['message'];
        //print(xmgs.toString());
        var xstatus = jsonObject['status'];
        if (xstatus) {
          _updateGetIDRestServerDetailVisibility(
              resultd[n]["visibilitytrxid"].toString(), getDataApi);
        }
      }
    }
  }

  _uploadHeadVisibility() async {
    Database db = await _dbProvider.database;
    String strSQL;
    // amount diambil dari sum table penjualan
    //from visittf v INNER JOIN penjualan s ON s.customerno = v.customerno AND v.userid = s.userid AND v.tglkunjungan = s.tglkunjungan INNER JOIN materialtf m ON s.materialid = m.materialid
    strSQL =
        "SELECT distinct v.visittrxid, v.getidvisibility, v.customerno, v.tglkunjungan,c.regionid,c.salesofficeid,c.salesgroupid,c.salesdistrictid,c.cycle,c.week,c.year FROM visittf v INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN visibility p ON v.customerno = p.customerno AND v.tglkunjungan = p.tglkunjungan AND v.userid = p.userid INNER JOIN materialtf m ON p.materialid = m.materialid where  v.getidvisibility ='-1' and v.userid ='" +
            _userID +
            "'";
    List<Map> result = await db.rawQuery(strSQL);
    //print(result.length.toString());
    if (result.isNotEmpty) {
      var i = 0;
      for (i = 0; i < result.length; i++) {
        var _xTrx;
        //getidsellin
        if (result[i]["getidvisibility"].toString() != "-1") {
          _xTrx = "edit";
        } else {
          _xTrx = "new";
        }
        //print(_xTrx);
        Map data = {
          'trx': _xTrx,
          'trxid': result[i]["getidvisibility"].toString(),
          'userid': _userID.toString(),
          'customerno': result[i]["customerno"].toString(),
          'tglkunjungan': result[i]["tglkunjungan"].toString(),
          'regionid': result[i]["regionid"].toString(),
          'salesofficeid': result[i]["salesofficeid"].toString(),
          'salesgroupid': result[i]["salesgroupid"].toString(),
          'salesdistrictid': result[i]["salesdistrictid"].toString(),
          'cycle': result[i]["cycle"].toString(),
          'week': result[i]["week"].toString(),
          'year': result[i]["year"].toString(),
        };
        var apiResult = await http
            //.post("http://172.27.11.41/apimimos/index.php/api/Material/hargamaterialTFbyUseridbytgl", body: data);
            .post(apiURL + "/InjectDB/injectVisibilityHead", body: data);
        var jsonObject = json.decode(apiResult.body);
        var getDataApi = jsonObject['data'];
        //var xmgs = jsonObject['message'];
        var xstatus = jsonObject['status'];
        //print(xmgs);
        if (xstatus) {
          // upload visibility
          _uploadDetailVisibility(result[i]["customerno"].toString(),
              result[i]["tglkunjungan"].toString(), getDataApi);
          // update idvist sqlite
          _updateGetIDRestServerTableVisit(
              result[i]["visittrxid"].toString(), "visibility", getDataApi);
        }
      }
    }
  }

//----- end upload data visibility
//--- upload data visit
  _uploadDataVisit() async {
    Database db = await _dbProvider.database;
    String strSQL;
    strSQL =
        //"SELECT v.visittrxid,v.userid,v.customerno,v.tglkunjungan,v.notvisitreason,v.notbuyreason,c.salesofficeid,c.salesgroupid,c.salesdistrictid,c.visitday,c.visitweek, c.regionid FROM visittf v INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid where  v.notbuyreason != '-1' and v.getidvisit = '-1' ";
        "SELECT v.visittrxid,v.userid,v.customerno,v.tglkunjungan,v.notvisitreason,v.notbuyreason,c.salesofficeid,c.salesgroupid,c.salesdistrictid,c.visitday,c.week, c.regionid, c.cycle, c.year FROM visittf v INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid where v.getidvisit = '-1' and v.userid ='" +
            _userID +
            "' ";
    List<Map> result = await db.rawQuery(strSQL);
    //print(result.length.toString());
    if (result.isNotEmpty) {
      var i = 0;
      for (i = 0; i < result.length; i++) {
        Map data = {
          'userid': result[i]["userid"].toString(),
          'customerno': result[i]["customerno"].toString(),
          'visitdate': result[i]["tglkunjungan"].toString(),
          'notvisitreason': result[i]["notvisitreason"].toString(),
          'notbuyreason': result[i]["notbuyreason"].toString(),
          //'notbuyreason':xnotbuyreason,
          'regionid': result[i]["regionid"].toString(),
          'salesofficeid': result[i]["salesofficeid"].toString(),
          'salesgroupid': result[i]["salesgroupid"].toString(),
          'salesdistrictid': result[i]["salesdistrictid"].toString(),
          'cycle': result[i]["cycle"].toString(),
          'week': result[i]["week"].toString(),
          //'year': DateFormat("yyyy").format(DateTime.parse(result[i]["tglkunjungan"])).toString()
          'year': result[i]["year"].toString()
        };
        var apiResult = await http
            //.post("http://172.27.11.41/apimimos/index.php/api/Material/hargamaterialTFbyUseridbytgl", body: data);
            .post(apiURL + "/InjectDB/injectVisit", body: data);
        var jsonObject = json.decode(apiResult.body);
        var getDataApi = jsonObject['data'];
        //var xmgs = jsonObject['message'];
        var xstatus = jsonObject['status'];
        // print(result[i]["userid"].toString());
        // print(xmgs);
        if (xstatus) {
          // update idvist di sqlite
          _updateGetIDRestServerTableVisit(
              result[i]["visittrxid"].toString(), "visit", getDataApi);
        }
      }
    }
    return result;
  }
  // - end upload data visit
}

const List<ListMenu> listMenuItemUploadTF = const <ListMenu>[
  const ListMenu(
      judul: 'Upload',
      lambang: Icon(Icons.cloud_upload, color: Colors.blueAccent, size: 54),
      tampilan: '111'),
  const ListMenu(
      judul: 'Penjualan belum terupload semua',
      lambang: Icon(
        Icons.shopping_cart,
        color: Colors.orange,
        size: 54,
      ),
      tampilan: '121'),
  const ListMenu(
      judul: 'Posm belum terupload semua',
      lambang: Icon(
        Icons.list,
        color: Colors.orange,
        size: 54,
      ),
      tampilan: '122'),
  const ListMenu(
      judul: 'Cek Stock belum terupload semua',
      lambang: Icon(
        Icons.smoking_rooms,
        color: Colors.orange,
        size: 54,
      ),
      tampilan: '123'),
  const ListMenu(
      judul: 'Cek Display belum terupload semua',
      lambang: Icon(
        Icons.picture_in_picture,
        color: Colors.orange,
        size: 54,
      ),
      tampilan: '124'),
  const ListMenu(
      judul: 'Hapus data semua',
      lambang: Icon(Icons.delete_forever, color: Colors.red, size: 54),
      tampilan: '131'),
];
