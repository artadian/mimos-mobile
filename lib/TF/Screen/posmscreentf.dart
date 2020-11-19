import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
//import 'package:mimos/TF/Screen/penjualaneditscreentf.dart';
import 'package:mimos/TF/Screen/posminputscreentf.dart';
import 'package:mimos/TF/Screen/visitingscreentf.dart';
import 'package:mimos/db/database.dart';
//import 'package:intl/intl.dart';
import 'package:mimos/TF/Model/posmmodeltf.dart';
import 'package:mimos/TF/UC/kartustocktf.dart';
import 'package:mimos/TF/Screen/deletetrxtfscreen.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class POSMScreenTF extends StatefulWidget {
  final String customerno;
  final String customername;
  final String tglkunjungan;
  final String userid;
  final String priceid;
  final String alamat;
  POSMScreenTF(
      {Key key,
      this.customerno,
      this.customername,
      this.tglkunjungan,
      this.userid,
      this.priceid,
      this.alamat})
      : super(key: key);
  @override
  _POSMScreenTFState createState() => _POSMScreenTFState();
}

class _POSMScreenTFState extends State<POSMScreenTF> {
  Future<void> _dialogDelete(
      BuildContext context,
      String customerno,
      customername,
      tglkunjungan,
      userid,
      priceid,
      trxid,
      materialname,
      materialid,
      kuantity,
      alamat) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          //return MyDialog();
          return DeleteTrxTFScreen(
            trx: "posm",
            customerno: customerno.toString(),
            customername: customername.toString(),
            tglkunjungan: tglkunjungan.toString(),
            userid: userid.toString(),
            priceid: priceid.toString(),
            trxid: trxid.toString(),
            materialname: materialname.toString(),
            materialid: materialid.toString(),
            kuantity: kuantity.toString(),
            alamat: alamat.toString(),
          );
        });
  }

  // Future<void> _dialogEdit(
  //     BuildContext context,
  //     String customerno,
  //     customername,
  //     tglkunjungan,
  //     userid,
  //     priceid,
  //     trxid,
  //     materialname,
  //     materialid,
  //     pac,
  //     slof,
  //     bal,
  //     alamat) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         //return MyDialog();

  //         return PenjualanEditScreenTF(
  //           customerno: customerno.toString(),
  //           customername: customername.toString(),
  //           tglkunjungan: tglkunjungan.toString(),
  //           userid: userid.toString(),
  //           priceid: priceid.toString(),
  //           trxid: trxid.toString(),
  //           materialname: materialname.toString(),
  //           materialid: materialid.toString(),
  //           pac: pac.toString(),
  //           slof: slof.toString(),
  //           bal: bal.toString(),
  //           alamat: alamat.toString(),
  //         );
  //       });
  // }

  final _dbProvider = DatabaseProvider.dbProvider;
  final TextEditingController notaController = new TextEditingController();
  final TextEditingController totalController = new TextEditingController();
  goToHome(
      String customerno, customername, tglkunjungan, userid, priceid, alamat) {
    var root = MaterialPageRoute(
        builder: (context) => new VisitingScreenTF(
              customerno: customerno.toString(),
              customername: customername.toString(),
              tglkunjungan: tglkunjungan.toString(),
              userid: userid.toString(),
              priceid: priceid.toString(),
              alamat: alamat.toString(),
            ));
    Navigator.pushReplacement(context, root);
  }

  goToInput(
      String customerno, customername, tglkunjungan, userid, priceid, alamat,trx,type,condition,status,materialID,trxID,qty,note) {
    var root = MaterialPageRoute(
        builder: (context) => new POSMInputScreenTF(
              customerno: customerno.toString(),
              customername: customername.toString(),
              tglkunjungan: tglkunjungan.toString(),
              userid: userid.toString(),
              priceid: priceid.toString(),
              alamat: alamat.toString(),
              trx: trx.toString(),
              typeEdit: type.toString(),
              conditionEdit: condition.toString(),
              statusEdit: status.toString(),
              materialEdit: materialID.toString(),
              trxIDEdit: trxID.toString(),
              qtyEdit: qty.toString(),
              noteEdit: note.toString(),
            ));
    Navigator.pushReplacement(context, root);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () {
                  goToHome(
                      widget.customerno,
                      widget.customername,
                      widget.tglkunjungan,
                      widget.userid,
                      widget.priceid,
                      widget.alamat);
                })
          ],
          backgroundColor: MyPalette.ijoMimos,
          leading: new Container(),
          flexibleSpace: Container(
            child: Positioned(
                bottom: 0,
                //right: 0,
                child: Container(
                  // alignment: Alignment.center,
                  //margin: EdgeInsets.all(18),
                  margin: EdgeInsets.fromLTRB(18, 5, 5, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "POSM",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.amberAccent,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        widget.customername,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        widget.alamat,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        widget.tglkunjungan,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
        child: Column(
          children: <Widget>[
            Expanded(
              child: getDataPOSMkWidget(
                  widget.customerno, widget.tglkunjungan, widget.userid),
            ),
          ],
        ),
      )),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: Colors.grey, width: 0.3),
          )),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
               SizedBox(width: 54),
              Expanded(
                child: new RaisedButton.icon(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () {
                    goToInput(
                        widget.customerno,
                        widget.customername,
                        widget.tglkunjungan,
                        widget.userid,
                        widget.priceid,
                        widget.alamat,"new","","","","","","","");
                  },
                  icon: Icon(Icons.add, color: Colors.blueAccent),
                  label: Text("Item Material"),
                  color: Colors.grey[200],
                  textColor: Colors.black,
                  // elevation: 5.0,
                ),
              ),
              SizedBox(width: 54),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<POSMModelTF>> _getPOSM(
      String customerno, tglkunjungan, userid) async {
    final db = await _dbProvider.database;
    List<Map<String, dynamic>> result;
    //result = await db.query("customer", columns: columns);
    String strSQL =
        "select s.posmtrxid,s.customerno,s.tglkunjungan,s.materialid,m.materialgroupdescription as materialname,s.type,s.qty,s.status,s.note,s.condition, (1) as rownumber,type_L.lookupdesc as typedescription,status_L.lookupdesc as statusdescription from visittf v  ";
        strSQL = strSQL + " INNER JOIN posmtf s ON s.customerno = v.customerno AND v.userid = s.userid AND v.tglkunjungan = s.tglkunjungan ";
        strSQL = strSQL + " INNER JOIN materialtf m ON s.materialid = m.materialgroupid" ;
        strSQL = strSQL + " INNER JOIN lookup type_L ON type_L.lookupvalue = s.type AND type_L.lookupkey = 'posm_type'" ;
        strSQL = strSQL + " INNER JOIN lookup status_L ON status_L.lookupvalue = s.status AND status_L.lookupkey = 'posm_status'" ;
        strSQL = strSQL + " INNER JOIN lookup condition_L ON condition_L.lookupvalue = s.condition AND condition_L.lookupkey = 'posm_condition'" ;
        strSQL = strSQL + " where s.customerno ='" +
            customerno +
            "' and s.tglkunjungan ='" +
            tglkunjungan +
            "' and v.userid ='" +
            userid +
            "' ORDER BY s.posmtrxid Desc";
    result = await db.rawQuery(strSQL);
    // "' ");
    List<POSMModelTF> datapenjualan = result.isNotEmpty
        ? result
            .map((item) => POSMModelTF.createPOSMFromJson(item))
            .toList()
        : [];
    return datapenjualan;
  }

  Widget getDataPOSMkWidget(String customerno, tglkunjungan, userid) {
    return FutureBuilder(
        future: _getPOSM(customerno, tglkunjungan, userid),
        builder: (BuildContext context,
            AsyncSnapshot<List<POSMModelTF>> snapshot) {
          return getPOSMCardWidget(snapshot);
        });

    ///----
    // return StreamBuilder(
    //  stream: _customerBloc.customerS,
    //   builder: (BuildContext context,
    //       AsyncSnapshot<List<KonsumenModelSQLite>> snapshot) {
    //     return getCustomerCardWidget(snapshot);
    //   },
    // );
  }

  Widget getPOSMCardWidget(
      AsyncSnapshot<List<POSMModelTF>> snapshot) {
    //print("data penjualan " + snapshot.data.length.toString());
    if (snapshot.hasData) {
      return snapshot.data.length != 0
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemPosition) {
                POSMModelTF _dataPOSM = snapshot.data[itemPosition];
                //---- ini udah bisa
                //Color _warna = Colors.transparent;
                // _customer.customerno != "3320000021"
                //     ? _warna = Colors.green
                //     : _warna = Colors.blueAccent;
                return new KartuStockTF(
                    lambangaksikiri: IconButton(
                        icon: Icon(Icons.delete_forever),
                        color: Colors.red,
                        onPressed: () {
                          _dialogDelete(
                              context,
                              widget.customerno,
                              widget.customername,
                              widget.tglkunjungan,
                              widget.userid,
                              widget.priceid,
                              _dataPOSM.posmtrxid.toString(),
                              _dataPOSM.materialname.toString(),
                              _dataPOSM.materialid.toString(),
                              _dataPOSM.typedescription.toString(),
                              widget.alamat);
                          //--- tidak bisa ngrender ulang / refresh sehingga pakai screen sendiri
                          // _deleteDataStock(_datastock.stocktrxid.toString());
                          // _getAllStock(widget.customerno, widget.tglkunjungan,
                          //     widget.userid);
                          
                          
                        }),
                    // trxid: "# "+ _datastock.stocktrxid ,
                    namamaterial: _dataPOSM.materialname,
                    // kodematerial: _dataPenjualan.materialid +
                    //     " [# " +
                    //     _dataPenjualan.rownumber +
                    //     " ]",
                    kodematerial:  _dataPOSM.typedescription.toString() +
                        " " +
                        _dataPOSM.qty.toString(),
                    qtypac: _dataPOSM.statusdescription.toString() ,
                    qtyslof:  _dataPOSM.note.length > 30 ? _dataPOSM.note.substring(0, 26) + " ..." :_dataPOSM.note,
                    // qtybal: _datastock.bal.toString() + " bal",
                    // qtyslof: _datastock.slof.toString() + " slof",
                    lambangaksikanan: IconButton(
                        icon: Icon(
                          Icons.create,
                          color: Colors.green,
                        ),
                        onPressed: () {
 goToInput(
                        widget.customerno,
                        widget.customername,
                        widget.tglkunjungan,
                        widget.userid,
                        widget.priceid,
                        widget.alamat,"edit",_dataPOSM.type.toString(),_dataPOSM.condition.toString(),_dataPOSM.status.toString(),_dataPOSM.materialid.toString(),_dataPOSM.posmtrxid.toString(),_dataPOSM.qty.toString(),_dataPOSM.note.toString());
                          
                        }));
              },
            )
          : Container(
              child: Center(
              //this is used whenever there 0 Todo
              //in the data base
              //child: noCustomerMessageWidget(),
              child: Text("Data POSM tidak ada"),
            ));
    } else {
      return Center(
        /*since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the use know the app is currently
        processing*/
        child: Text("loading data"),
      );
    }
  }
}
