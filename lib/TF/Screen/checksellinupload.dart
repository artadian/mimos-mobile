import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:intl/intl.dart';
import 'package:mimos/TF/Bloc/penjualannotuploadbloc.dart';
import 'package:mimos/TF/Model/penjualanmodeltf.dart';
import 'package:mimos/TF/UC/kartupenjualancustomer.dart';
import 'package:mimos/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';

class CheckSellinUpload extends StatefulWidget {
  @override
  _CheckSellinUploadState createState() => _CheckSellinUploadState();
}

class _CheckSellinUploadState extends State<CheckSellinUpload> {
  Future<void> _dialogCall(BuildContext context,userID,tglKunjungan,customerNo,customerName) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "Upload Ulang",
      desc: "Selling '" + customerName +"' to Server " ,
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
            _uploadHeadPenjualan(userID, tglKunjungan, customerNo);
            _penjualanNotUploadBloc.getPenjualanNotUploadByMaterialID();
            Navigator.pop(context);
          },
          color: Color.fromRGBO(0, 125, 0, 1.0),
        )
      ],
    ).show();
  }
  final _dbProvider = DatabaseProvider.dbProvider;
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  PenjualanNotUploadBloc _penjualanNotUploadBloc = PenjualanNotUploadBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF54C5F8),
        title: Text("Upload Ulang Penjualan"),
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
                  child: getPenjualanWidget()))),
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
                  _penjualanNotUploadBloc.getPenjualanNotUploadByMaterialID();
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

  _updateGetIDRestServerDetailPenjualan(trxid, getid) async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL =
        " UPDATE penjualan set getidsellindetail = '" + getid.toString() + "' ";
    strSQL = strSQL + " where penjualantrxid =" + trxid + "";
    int result = await db.rawInsert(strSQL);
    return result;
  }

  _uploadDetailPenjualan(xcustomerno, xtglkunjungan, xIDHead, userID) async {
    Database db = await _dbProvider.database;
    String strSQL;
    strSQL =
        // "SELECT p.materialid, p.qtypenjualan, p.bal,p.slof,p.pac, p.introdeal, p.harga, p.harga * p.qtypenjualan as sellinvalue FROM visit v INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN penjualan p ON v.customerno = p.customerno AND v.tglkunjungan = p.tglkunjungan AND v.userid = p.userid where v.userid = '"+ _userID +"' and v.tglkunjungan ='"+ xtglkunjungan +"' and v.customerno ='"+ xcustomerno +"' and v.nonota <>'-1'";
        "SELECT p.penjualantrxid,p.materialid, p.qtypenjualan, p.bal,p.slof,p.pac, p.introdeal, p.harga, p.harga * p.qtypenjualan as sellinvalue FROM penjualan p where p.userid = '" +
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

_updateGetIDRestServerTableVisit(visittrxid, trx, getidrest) async {
    Database db = await _dbProvider.database;
    var strSQL;
    strSQL = " UPDATE visittf set ";
    // if (trx == "visit") {
    //   strSQL = strSQL + " getidvisit ='" + getidrest.toString() + "'";
    // } else if (trx == "penjualan") {
      strSQL = strSQL + " getidsellin ='" + getidrest.toString() + "'";
      strSQL = strSQL + " ,iseditsellin ='N'";
    // } else if (trx == "posm") {
    //   strSQL = strSQL + " getidposm ='" + getidrest.toString() + "'";
    //   strSQL = strSQL + " ,iseditposm ='N'";
    // } else if (trx == "stock") {
    //   strSQL = strSQL + " getidstock ='" + getidrest.toString() + "'";
    //   strSQL = strSQL + " ,iseditstock ='N'";
    // }
    strSQL = strSQL + " where visittrxid =" + visittrxid + "";
    //print(strSQL);
    int result = await db.rawInsert(strSQL);
    return result;
  }
  _uploadHeadPenjualan(userID, tglKunjungan, customerno) async {
    Database db = await _dbProvider.database;
    String strSQL;
    // amount diambil dari sum table penjualan
    //from visittf v INNER JOIN penjualan s ON s.customerno = v.customerno AND v.userid = s.userid AND v.tglkunjungan = s.tglkunjungan INNER JOIN materialtf m ON s.materialid = m.materialid
    strSQL =
        "SELECT v.visittrxid, v.getidsellin, v.customerno, v.tglkunjungan,v.nonota,c.regionid,c.salesofficeid,c.salesgroupid,c.salesdistrictid,SUM (((p.bal *( m.bal / m.pac)) + (p.slof * (m.slof / m.pac)) + p.pac) * p.harga) as amount,c.cycle,c.week,c.year FROM visittf v INNER JOIN customer c ON v.customerno = c.customerno AND v.tglkunjungan = c.tanggalkunjungan AND v.userid = c.userid INNER JOIN penjualan p ON v.customerno = p.customerno AND v.tglkunjungan = p.tglkunjungan AND v.userid = p.userid INNER JOIN materialtf m ON p.materialid = m.materialid where  v.tglkunjungan ='" +
            tglKunjungan.toString() +
            "' and v.customerno ='" +
            customerno.toString() +
            "' and v.userid ='" +
            userID +
            "' GROUP BY v.visittrxid, v.getidsellin, v.customerno, v.tglkunjungan,v.nonota,c.regionid,c.salesofficeid,c.salesgroupid,c.salesdistrictid,c.cycle,c.week,c.year ";
    List<Map> result = await db.rawQuery(strSQL);
    //print(strSQL);
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
          'userid': userID.toString(),
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
          _uploadDetailPenjualan(
              result[i]["customerno"].toString(),
              result[i]["tglkunjungan"].toString(),
              getDataApi,
              userID.toString());

               _updateGetIDRestServerTableVisit(
              result[i]["visittrxid"].toString(), "penjualan", getDataApi);
        }
      }
    }
  }

  Widget getPenjualanWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (todos)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      //stream: _customerBloc.customerS,
      stream: _penjualanNotUploadBloc.penjualanNotUploadByMaterialID,
      builder: (BuildContext context,
          AsyncSnapshot<List<PenjualanModelTF>> snapshot) {
        return getPenjualanDetaildWidget(snapshot, context);
      },
    );
  }

  Widget getPenjualanDetaildWidget(
      AsyncSnapshot<List<PenjualanModelTF>> snapshot, context) {
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
                PenjualanModelTF _customer = snapshot.data[itemPosition];
                Color _warnaWsp = Colors.transparent;
                 _customer.wspclass == "G"
                     ? _warnaWsp = Colors.amber
                    :  _customer.wspclass == "S" ? _warnaWsp = Colors.grey : _customer.wspclass == "B" ? _warnaWsp = Colors.brown : _warnaWsp = Colors.transparent;
                return InkWell(
                  splashColor: Colors.blueAccent,
                  onTap: () {
                    //_customer.userid;
                    _dialogCall(context,_customer.userid.toString(),_customer.tglkunjungan.toString(),_customer.customerno.toString(),_customer.name.toString());
                  },
                  child: new KartuPenjualanCustomer(
                      namacustomer: _customer.name,
                      kodecustomer: _customer.customerno,
                      alamatcustomer: _customer.address.length > 30
                          ? _customer.address.substring(0, 26) + " ..."
                          : _customer.address,
                      kotacustomer:_customer.tglkunjungan ,
                      logo: Icons.shopping_cart,
                      warnalogo: Colors.amber,
                      tglkunjungan: 
                          "Rp. " +
                          oCcy.format(int.parse(_customer.amountnota)),
                      datanota: "No Nota : " + _customer.nonota,
                      lambangaksi: IconButton(
                          icon: Icon(Icons.store, color: _warnaWsp),
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
    _penjualanNotUploadBloc.getDataPenjualanNotUploadByMaterialID();
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
        "Data tidak ada",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }
}
