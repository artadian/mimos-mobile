import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/TF/Model/stockmodeltf.dart';
import 'package:mimos/TF/Screen/stockeditscreentf.dart';
import 'package:mimos/TF/Screen/stockinputscreentf.dart';
import 'package:mimos/TF/Screen/visitingscreentf.dart';
import 'package:mimos/TF/UC/kartustocktf.dart';
import 'package:mimos/db/database.dart';
import 'package:mimos/TF/Screen/deletetrxtfscreen.dart';
//import 'package:sqflite/sqflite.dart';

class StockScreenTF extends StatefulWidget {
  final String customerno;
  final String customername;
  final String tglkunjungan;
  final String userid;
  final String priceid;
  final String alamat;
  StockScreenTF(
      {Key key,
      this.customerno,
      this.customername,
      this.tglkunjungan,
      this.userid,
      this.priceid,
      this.alamat})
      : super(key: key);
  @override
  _StockScreenTFState createState() => _StockScreenTFState();
}

class _StockScreenTFState extends State<StockScreenTF> {
  Future<void> _dialogCall(
      BuildContext context,
      String customerno,
      customername,
      tglkunjungan,
      userid,
      priceid,
      stocktrxid,
      materialname,
      materialid,
      kuantity,alamat) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          //return MyDialog();
          return DeleteTrxTFScreen(
            trx:"stock",
            customerno: customerno.toString(),
            customername: customername.toString(),
            tglkunjungan: tglkunjungan.toString(),
            userid: userid.toString(),
            priceid: priceid.toString(),
            trxid: stocktrxid.toString(),
            materialname: materialname.toString(),
            materialid: materialid.toString(),
            kuantity: kuantity.toString(),
            alamat: alamat.toString(),
          );
        });
  }

  Future<void> _dialogEdit(
      BuildContext context,
      String customerno,
      customername,
      tglkunjungan,
      userid,
      priceid,
      stocktrxid,
      materialname,
      materialid,
      pac,
      slof,
      bal,alamat) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          //return MyDialog();

          return EditStockScreenTF(
            customerno: customerno.toString(),
            customername: customername.toString(),
            tglkunjungan: tglkunjungan.toString(),
            userid: userid.toString(),
            priceid: priceid.toString(),
            stocktrxid: stocktrxid.toString(),
            materialname: materialname.toString(),
            materialid: materialid.toString(),
            pac: pac.toString(),
            slof: slof.toString(),
            bal: bal.toString(),
            alamat: alamat.toString(),
          );
        });
  }

  final _dbProvider = DatabaseProvider.dbProvider;
  goToHome(String customerno, customername, tglkunjungan, userid, priceid,alamat) {
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

  goToInput(String customerno, customername, tglkunjungan, userid, priceid,alamat) {
    var root = MaterialPageRoute(
        builder: (context) => new InputStockScreenTF(
              customerno: customerno.toString(),
              customername: customername.toString(),
              tglkunjungan: tglkunjungan.toString(),
              userid: userid.toString(),
              priceid: priceid.toString(),
              alamat: alamat.toString(),
            ));
    Navigator.pushReplacement(context, root);
  }

  // goToDelete(String customerno, customername, tglkunjungan, userid, priceid,
  //     stocktrxid, materialname, materialid, kuantity) {
  //   var root = MaterialPageRoute(
  //       builder: (context) => new DeleteStockScreenTF(
  //             customerno: customerno.toString(),
  //             customername: customername.toString(),
  //             tglkunjungan: tglkunjungan.toString(),
  //             userid: userid.toString(),
  //             priceid: priceid.toString(),
  //             stocktrxid: stocktrxid.toString(),
  //             materialname: materialname.toString(),
  //             materialid: materialid.toString(),
  //             kuantity: kuantity.toString(),
  //           ));
  //   Navigator.pushReplacement(context, root);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     FloatingActionButton.extended(
      //       backgroundColor: Colors.lightBlue,
      //       onPressed: () {
      //         goToInput(widget.customerno, widget.customername,
      //             widget.tglkunjungan, widget.userid, widget.priceid);
      //       },
      //       icon: Icon(Icons.add),
      //       label: Text('Material'),
      //       //child: Icon(Icons.add),
      //     ),
      //   ],
      // ),
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
                  goToHome(widget.customerno, widget.customername,
                      widget.tglkunjungan, widget.userid, widget.priceid,widget.alamat);
                })
          ],
          //backgroundColor: warnaBackground,
          backgroundColor: MyPalette.ijoMimos,
          leading: new Container(),
          flexibleSpace: Container(
            child: Positioned(
                bottom: 0,
                //right: 0,
                child: Container(
                  // alignment: Alignment.center,
                  //margin: EdgeInsets.all(20),
                   margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "CEK STOCK",
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
          child: getDataStockWidget(
              widget.customerno, widget.tglkunjungan, widget.userid)),
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
              // RaisedButton.icon(
              //     onPressed: () {
              //      // _customerBloc.getCustomerS();
              //     },
              //     icon: Icon(Icons.refresh,color: Colors.blueAccent),
              //     color: Colors.white,
              //     label: Text("Refresh")),

              // IconButton(
              //     icon: Icon(
              //       Icons.refresh,
              //       color: Colors.blueAccent,
              //       size: 28,
              //     ),
              //     onPressed: () {
              //       //just re-pull UI for testing purposes
              //       //_customerBloc.getCustomerS();
              //     }),
              SizedBox(
                width: 45,
              ),
              Expanded(
                child: new RaisedButton.icon(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () {
                    goToInput(widget.customerno, widget.customername,
                        widget.tglkunjungan, widget.userid, widget.priceid,widget.alamat);
                  },
                  icon: Icon(Icons.add, color: Colors.blueAccent),
                  label: Text(" Item Barang"),
                  color: Colors.grey[200],
                  textColor: Colors.black,
                  // elevation: 5.0,
                ),
              ),
              SizedBox(width: 45)
              // Wrap(children: <Widget>[
              //   IconButton(
              //     icon: Icon(
              //       Icons.search,
              //       size: 28,
              //       color: Colors.indigoAccent,
              //     ),
              //     onPressed: () {
              //       // _showCustomerSearchSheet(context);
              //     },
              //   ),
              //   Padding(
              //     padding: EdgeInsets.only(right: 5),
              //   )
              // ])
            ],
          ),
        ),
      ),
    );
  }

  //----- akses sqlite
  Future<List<StockModelTF>> _getAllStock(
      String customerno, tglkunjungan, userid) async {
    final db = await _dbProvider.database;
    List<Map<String, dynamic>> result;
    //result = await db.query("customer", columns: columns);
    result = await db.rawQuery(
        "select s.stocktrxid,s.customerno,s.tglkunjungan,s.materialid,m.materialname,s.bal,s.slof,s.pac,s.ismaterialdefault,s.iscek from visittf v INNER JOIN stocktf s ON s.customerno = v.customerno AND v.userid = s.userid AND v.tglkunjungan = s.tglkunjungan INNER JOIN materialtf m ON s.materialid = m.materialid where s.customerno ='" +
            customerno +
            "' and s.tglkunjungan ='" +
            tglkunjungan +
            "' and v.userid ='" +
            userid +
            "' ORDER BY s.stocktrxid Desc");
    List<StockModelTF> datastock = result.isNotEmpty
        ? result.map((item) => StockModelTF.createStockFromJson(item)).toList()
        : [];
    return datastock;
  }

  //-----
  Widget getDataStockWidget(String customerno, tglkunjungan, userid) {
    return FutureBuilder(
        future: _getAllStock(customerno, tglkunjungan, userid),
        builder:
            (BuildContext context, AsyncSnapshot<List<StockModelTF>> snapshot) {
          return getStockCardWidget(snapshot);
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

  Widget getStockCardWidget(AsyncSnapshot<List<StockModelTF>> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data.length != 0
          ? ListView.builder(
              // print(snapshot.data.length.toString()),
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemPosition) {
                StockModelTF _datastock = snapshot.data[itemPosition];
                //---- ini udah bisa
                //Color _warna = Colors.transparent;
                // _customer.customerno != "3320000021"
                //     ? _warna = Colors.green
                //     : _warna = Colors.blueAccent;
                return new KartuStockTF(
                    lambangaksikiri: IconButton(
                        //icon: Icon(Icons.delete_forever),
                        icon: _datastock.ismaterialdefault.toString()=="N"? new Icon(Icons.delete_forever): _datastock.iscek.toString()=="Y" ? new Icon(Icons.assignment_turned_in):new Icon(Icons.assignment_late) ,
                        //color: Colors.red,
                        color: _datastock.ismaterialdefault.toString()=="N"?Colors.red:_datastock.iscek.toString()=="Y" ?Colors.green:Colors.orange,
                        //onPressed: () {
                          onPressed: _datastock.ismaterialdefault.toString()=="Y"? (){}:() {
                           _dialogCall(
                              context,
                              widget.customerno,
                              widget.customername,
                              widget.tglkunjungan,
                              widget.userid,
                              widget.priceid,
                              _datastock.stocktrxid.toString(),
                              _datastock.materialname.toString(),
                              _datastock.materialid.toString(),
                              _datastock.pac.toString() +
                                  " pac ; " +
                                  _datastock.slof.toString() +
                                  " slof ; " +
                                  _datastock.bal.toString() +
                                  " bal",widget.alamat);
                          //--- tidak bisa ngrender ulang / refresh sehingga pakai screen sendiri
                          // _deleteDataStock(_datastock.stocktrxid.toString());
                          // _getAllStock(widget.customerno, widget.tglkunjungan,
                          //     widget.userid);
                         
                        }),
                    // trxid: "# "+ _datastock.stocktrxid ,
                    namamaterial: _datastock.materialname,
                    kodematerial: _datastock.materialid ,
                    qtypac: _datastock.pac.toString() +
                        " pac ; " +
                        _datastock.slof.toString() +
                        " slof ; " +
                        _datastock.bal.toString() +
                        " bal ",
                    // qtybal: _datastock.bal.toString() + " bal",
                    // qtyslof: _datastock.slof.toString() + " slof",
                    lambangaksikanan: IconButton(
                        icon: Icon(
                          Icons.create,
                          color: Colors.green,
                        ),
                        onPressed: () {
                         _dialogEdit(
                              context,
                              widget.customerno,
                              widget.customername,
                              widget.tglkunjungan,
                              widget.userid,
                              widget.priceid,
                              _datastock.stocktrxid.toString(),
                              _datastock.materialname.toString(),
                              _datastock.materialid.toString(),
                              _datastock.pac.toString(),
                              _datastock.slof.toString(),
                              _datastock.bal.toString(),widget.alamat);
                         
                        }));
              },
            )
          : Container(
              child: Center(
              //this is used whenever there 0 Todo
              //in the data base
              //child: noCustomerMessageWidget(),
              child: Text("Data cek stock tidak ada",style: TextStyle(fontSize: 19)),
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

  // _deleteDataStock(trxid) async {
  //   Database db = await _dbProvider.database;
  //   await db.rawDelete(
  //       "DELETE FROM stocktf Where stocktrxid = '" + trxid.toString() + "'");
  // }
}
