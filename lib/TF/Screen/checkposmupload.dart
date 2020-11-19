import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
//import 'package:intl/intl.dart';
import 'package:mimos/TF/Bloc/posmnotuploadbloc.dart';
import 'package:mimos/TF/Model/posmmodeltf.dart';

import 'package:mimos/TF/UC/kartustocktf.dart';
import 'package:mimos/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';

class CheckPosmUpload extends StatefulWidget {
  @override
  _CheckPosmUploadState createState() => _CheckPosmUploadState();
}

class _CheckPosmUploadState extends State<CheckPosmUpload> {
  Future<void> _dialogCall(
      BuildContext context, userID, tglKunjungan, customerNo, customerName) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "Upload Ulang",
      desc: "Posm '" + customerName + "' to Server ",
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
             _uploadHeadPosm(userID, tglKunjungan, customerNo);
            _posmNotUploadBloc.getPosmNotUploadByMaterialID();
            Navigator.pop(context);
          },
          color: Color.fromRGBO(0, 125, 0, 1.0),
        )
      ],
    ).show();
  }

  final _dbProvider = DatabaseProvider.dbProvider;
 // final oCcy = new NumberFormat("#,##0.00", "en_US");
  PosmNotUploadBloc _posmNotUploadBloc = PosmNotUploadBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF54C5F8),
        title: Text("Upload Ulang Posm"),
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [MyPalette.ijoMimos, MyPalette.ijoMimos],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight))),
      ),
      body: SafeArea(
          child: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
              child: Container(
                  //This is where the magic starts
                  // child: Text("List customer"),
                  child: getPosmWidget()))),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: Colors.grey, width: 0.3),
          )),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton.icon(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  _posmNotUploadBloc.getPosmNotUploadByMaterialID();
                },
                icon: Icon(Icons.refresh, color: Colors.lightBlueAccent),
                label: Text(" Refresh "),
                // color: Colors.lightBlue,
                textColor: Colors.black,
                // elevation: 5.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
//---- upload posm
  _updateGetIDRestServerDetailPosm(trxid, getid) async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " UPDATE posmtf set getidposmdetail = '" + getid.toString() + "' ";
    strSQL = strSQL + " where posmtrxid =" + trxid + "";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _uploadDetailPosm(xcustomerno, xtglkunjungan, xIDHead,userID) async {
    Database db = await _dbProvider.database;
    String strSQL;
    strSQL =
        "SELECT p.posmtrxid,p.materialid, p.type,p.qty,p.status,p.note,p.condition FROM posmtf p where p.userid = '" +
            userID +
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
          'userid': userID.toString(),
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

_updateGetIDRestServerTableVisit(visittrxid, trx, getidrest) async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " UPDATE visittf set ";
    // if (trx == "visit") {
    //   strSQL = strSQL + " getidvisit ='" + getidrest.toString() + "'";
    // } else if (trx == "penjualan") {
    //   strSQL = strSQL + " getidsellin ='" + getidrest.toString() + "'";
    //   strSQL = strSQL + " ,iseditsellin ='N'";
    //} else if (trx == "posm") {
      strSQL = strSQL + " getidposm ='" + getidrest.toString() + "'";
      strSQL = strSQL + " ,iseditposm ='N'";
    // } else if (trx == "stock") {
    //   strSQL = strSQL + " getidstock ='" + getidrest.toString() + "'";
    //   strSQL = strSQL + " ,iseditstock ='N'";
    // }
    strSQL = strSQL + " where visittrxid =" + visittrxid + "";
    //print(strSQL);
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _uploadHeadPosm(userID,tglKunjungan,customerNo) async {
    Database db = await _dbProvider.database;
    String strSQL;
    strSQL =
        "SELECT distinct v.visittrxid, v.getidposm, v.customerno, v.tglkunjungan,c.regionid,c.salesofficeid,c.salesgroupid,c.salesdistrictid,c.cycle,c.week,c.year FROM visittf v INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN posmtf p ON v.customerno = p.customerno AND v.tglkunjungan = p.tglkunjungan AND v.userid = p.userid INNER JOIN materialtf m ON p.materialid = m.materialgroupid where v.tglkunjungan ='"+ tglKunjungan +"' and  v.customerno ='"+ customerNo +"' and v.userid ='" +
            userID +
            "'";
    List<Map> result = await db.rawQuery(strSQL);
   //print(strSQL);
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
          'userid': userID.toString(),
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
              result[i]["tglkunjungan"].toString(), getDataApi,userID.toString());
               _updateGetIDRestServerTableVisit(
              result[i]["visittrxid"].toString(), "posm", getDataApi);
        }
      }
    }
  }
//----- end upload posm
  Widget getPosmWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (todos)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      //stream: _customerBloc.customerS,
      stream: _posmNotUploadBloc.posmNotUploadByMaterialID,
      builder:
          (BuildContext context, AsyncSnapshot<List<POSMModelTF>> snapshot) {
        return getPosmDetaildWidget(snapshot, context);
      },
    );
  }

  Widget getPosmDetaildWidget(
      AsyncSnapshot<List<POSMModelTF>> snapshot, context) {
    /*Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator*/
    if (snapshot.hasData) {
      /*Also handles whenever there's stream
      but returned returned 0 records of Todo from DB.
      If that the case show user that you have empty Todos
      */
      // print("data snapshot   " + snapshot.data.length.toString());
      return snapshot.data.length != 0
          ? ListView.builder(
              // print(snapshot.data.length.toString()),
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemPosition) {
                POSMModelTF _dataPOSM = snapshot.data[itemPosition];
                return InkWell(
                  splashColor: Colors.blueAccent,
                  onTap: () {
                    //_customer.userid;
                    _dialogCall(
                        context,
                        _dataPOSM.userid.toString(),
                        _dataPOSM.tglkunjungan.toString(),
                        _dataPOSM.customerno.toString(),
                        _dataPOSM.materialname.toString());
                  },
                  child: new KartuStockTF(
                      lambangaksikiri: IconButton(
                          icon: Icon(Icons.list),
                          color: Colors.orange,
                          onPressed: () {}),
                      // trxid: "# "+ _datastock.stocktrxid ,
                      namamaterial: _dataPOSM.materialname,
                      kodematerial: _dataPOSM.typedescription.length > 30
                          ? _dataPOSM.typedescription.substring(0, 26) + " ..."
                          : _dataPOSM.typedescription,
                      qtypac:  _dataPOSM.statusdescription.toString(),
                      qtyslof: _dataPOSM.tglkunjungan,
                      // qtybal: _datastock.bal.toString() + " bal",
                      // qtyslof: _datastock.slof.toString() + " slof",
                      lambangaksikanan: IconButton(
                          icon: Icon(
                            Icons.create,
                            color: Colors.transparent,
                          ),
                          onPressed: () {})),
                );
              },
            )
          : Container(
              child: Center(
              //this is used whenever there 0 Todo
              //in the data base
              child: noTodoMessageWidget(),
            ));
    } else {
      return Center(
        /*since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the use know the app is currently
        processing*/
        child: loadingData(),
      );
    }
  }

  Widget loadingData() {
    //pull todos again
    _posmNotUploadBloc.getDataPOSMNotUploadByMaterialID();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Loading...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget noTodoMessageWidget() {
    return Container(
      child: Text(
        "Data tidak ada ",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }
}
