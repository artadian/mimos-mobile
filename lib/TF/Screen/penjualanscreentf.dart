import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/TF/Screen/penjualaneditscreentf.dart';
import 'package:mimos/TF/Screen/penjualaninputscreentf.dart';
import 'package:mimos/TF/Screen/visitingscreentf.dart';
import 'package:mimos/db/database.dart';
import 'package:intl/intl.dart';
import 'package:mimos/TF/Model/penjualanmodeltf.dart';
import 'package:mimos/TF/UC/kartustocktf.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimos/TF/Screen/deletetrxtfscreen.dart';

class PenjualanScreenTF extends StatefulWidget {
  final String customerno;
  final String customername;
  final String tglkunjungan;
  final String userid;
  final String priceid;
  final String alamat;
  PenjualanScreenTF(
      {Key key,
      this.customerno,
      this.customername,
      this.tglkunjungan,
      this.userid,
      this.priceid,
      this.alamat})
      : super(key: key);
  @override
  _PenjualanScreenTFState createState() => _PenjualanScreenTFState();
}

class _PenjualanScreenTFState extends State<PenjualanScreenTF> {
  void _dialogDeleteNota(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red[600], Colors.red[600]],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight),
                    borderRadius: new BorderRadius.circular(10.0)
                    ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text("Menghapus Nota"),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          content: new Container(
              height: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.tglkunjungan),
                  new Expanded(child: Text(widget.customername)),
                ],
              )),
          actions: <Widget>[
            FlatButton(
              child: new Text(
                "Cancel",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("OK", style: TextStyle(fontSize: 18)),
              onPressed: () {
                _deleteDataNota(widget.customerno, widget.tglkunjungan, widget.userid);
                _updateDataVisitNota(widget.customerno, widget.tglkunjungan, widget.userid);
                goToHome(
                    widget.customerno,
                    widget.customername,
                    widget.tglkunjungan,
                    widget.userid,
                    widget.priceid,
                    widget.alamat);
              },
            ),
          ],
        );
      },
    );
  }

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
          return DeleteTrxTFScreen(
            trx: "penjualan",
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

  Future<void> _dialogEdit(
      BuildContext context,
      String customerno,
      customername,
      tglkunjungan,
      userid,
      priceid,
      trxid,
      materialname,
      materialid,
      pac,
      slof,
      bal,
      alamat) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          //return MyDialog();

          return PenjualanEditScreenTF(
            customerno: customerno.toString(),
            customername: customername.toString(),
            tglkunjungan: tglkunjungan.toString(),
            userid: userid.toString(),
            priceid: priceid.toString(),
            trxid: trxid.toString(),
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
      String customerno, customername, tglkunjungan, userid, priceid, alamat) {
    var root = MaterialPageRoute(
        builder: (context) => new PenjualanInputScreenTF(
              customerno: customerno.toString(),
              customername: customername.toString(),
              tglkunjungan: tglkunjungan.toString(),
              userid: userid.toString(),
              priceid: priceid.toString(),
              alamat: alamat.toString(),
            ));
    Navigator.pushReplacement(context, root);
  }

  int _total = 0;
  String _noNota;
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  void _getTotal() async {
    var nomernota;
    var total;
    var result = (await _cariDataNota(
        widget.customerno, widget.tglkunjungan, widget.userid));
    if (result.isNotEmpty) {
      if (result[0]['nonota'] != '-1'){
         nomernota = result[0]['nonota'];
      }else{
         nomernota ="";
      }
     
      total = result[0]['amount'];
    } else {
      nomernota = "";
      total = 0;
    }

    // result.forEach((k, v) {
    //   print("$k: $v");
    // });
    // result.forEach((e) => _list.add(NotaPenjualan()));
// result.forEach((k,v) => print('${k}: ${v}'));
    //result.forEach(
    // (row) => _total = (row['amount']),
    // nomernota = (valuerow) => (valuerow['nonota']),
    //print(nomernota),
    //(valuerow) => print(valuerow),
    // (valuerow) => (total = valuerow[0]['amount']) ,
    // (valuerow) => (nomernota = valuerow[0]['nonota'])
    //print(valuerow[0]['nonta'])
    // );
    setState(() {
      if (total != null) {
        _total = total;
      }
      if (nomernota != null) {
        _noNota = nomernota;
      }
      totalController.text = "Rp." + oCcy.format(_total);
      notaController.text = _noNota;
    });
  }

  @override
  void initState() {
    super.initState();
    _getTotal();
    // _cariDataNota(widget.customerno, widget.tglkunjungan, widget.userid)
    //     .then((val) => setState(() {
    //       val.forEach(
    //        // (row) => _total = (row['amount']),
    //        (row) => _noNota = (row['nonota'])
    //         );
    //       //print(val);
    //           //_total = val;
    //           //print(_total);
    //           totalController.text = "Rp." + oCcy.format(_total);
    //           notaController.text =_noNota;
    //         }));

    // _getTotalNota(widget.customerno, widget.tglkunjungan, widget.userid)
    //     .then((val) => setState(() {
    //           _total = val;
    //           //print(_total);
    //           totalController.text = "Rp." + oCcy.format(_total);
    //         }));
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
         // backgroundColor: warnaBackground,
          backgroundColor: MyPalette.ijoMimos,
          leading: new Container(),
          flexibleSpace: Container(
            child: Positioned(
                bottom: 0,
                //right: 0,
                child: Container(
                  // alignment: Alignment.center,
                  //margin: EdgeInsets.all(18),
                  margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "PENJUALAN",
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
            new TextFormField(
                controller: notaController,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: "Nomer Nota",
                  labelStyle: new TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w700),
                  prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 7.0),
                      child: new Icon(Icons.create,color: MyPalette.ijoMimos,)),
                )),
            new TextFormField(
                controller: totalController,
                keyboardType: TextInputType.number,
                readOnly: true,
                decoration: new InputDecoration(
                  labelText: "Total",
                  labelStyle: new TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w700),
                  prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 7.0),
                      child: new Icon(Icons.attach_money,color: MyPalette.ijoMimos)),
                )),
            Expanded(
              child: getDataStockWidget(
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
              Expanded(
                child: new RaisedButton.icon(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () {
                    // cek apakah sudah diupload ke server dgn idikator filed  getidvisit <>'-1' di table visit
                     _cekDataDiUpload(
                                  widget.customerno,
                                  widget.tglkunjungan,
                                  widget.userid,)
                              .then((val) => setState(() {
                                    if (val > 0) {
                                      //print("ada");
                                      Fluttertoast.showToast(
                                          msg: "Data Uploaded",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,

                                          //backgroundColor: Colors.red,
                                          textColor: Colors.red,
                                          fontSize: 16.0,
                                          timeInSecForIosWeb: 1);
                                    } else {
                                       _dialogDeleteNota(context);
                                    }}));

                   
                  },
                  icon: Icon(Icons.delete_forever, color: Colors.red),
                  label: Text("DEL"),
                  color: Colors.grey[200],
                  textColor: Colors.black,
                  // elevation: 5.0,
                ),
              ),
              SizedBox(width: 10),
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
                        widget.alamat);
                  },
                  icon: Icon(Icons.add, color: Colors.blueAccent),
                  label: Text("ITEMS"),
                  color: Colors.grey[200],
                  textColor: Colors.black,
                  // elevation: 5.0,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: new RaisedButton.icon(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () {
                    if (!(notaController.value.text.trim().toString().length >
                        0)) {
                      Fluttertoast.showToast(
                          msg: "No Nota Kosong",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          //backgroundColor: Colors.red,
                          textColor: Colors.red,
                          fontSize: 16.0,
                          timeInSecForIosWeb: 1);
                    } else {
                      _updateDataVisit(
                          widget.customerno,
                          widget.tglkunjungan,
                          widget.userid,
                          notaController.value.text,
                          _total.toString());
                      goToHome(
                          widget.customerno,
                          widget.customername,
                          widget.tglkunjungan,
                          widget.userid,
                          widget.priceid,
                          widget.alamat);
                    }
                  },
                  icon: Icon(Icons.save, color: Colors.green),
                  label: Text("FINISH"),
                  color: Colors.grey[200],
                  textColor: Colors.black,
                  // elevation: 5.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //- cek apakah  material sudah ada penjualan
//   _getTotalNota(customerno, tglkunjungan, userid) async {
//     Database db = await _dbProvider.database;
//     String strSQL;
//     strSQL =
//         "select SUM ((s.bal *( m.bal / m.pac) * s.harga) +(s.slof * (m.slof / m.pac) * s.harga)+ (s.pac  * s.harga)) from visittf v INNER JOIN penjualan s ON s.customerno = v.customerno AND v.userid = s.userid AND v.tglkunjungan = s.tglkunjungan INNER JOIN materialtf m ON s.materialid = m.materialid where s.customerno = '" +
//             customerno +
//             "' and s.tglkunjungan ='" +
//             tglkunjungan +
//             "' and v.userid ='" +
//             userid +
//             "' ";
// //print(strSQL);
//     int count = Sqflite.firstIntValue(await db.rawQuery(strSQL));
//     //print(count);
//     return count;
//   }
_cekDataDiUpload(
      customerno, tglkunjungan, userid) async {
    Database db = await _dbProvider.database;
    String strSQL;
    strSQL = "SELECT COUNT(getidvisit)  FROM visittf where customerno = '" +
        customerno +
        "' and tglkunjungan ='" +
        tglkunjungan +
        "' and userid ='" +
        userid +
        "' and getidvisit <>'-1' ";
//print(strSQL);
    int count = Sqflite.firstIntValue(await db.rawQuery(strSQL));
    //print(count);
    return count;
  }

  _deleteDataNota(customerno, tglkunjungan, userid) async {
    Database db = await _dbProvider.database;
         int result = await db.rawInsert("Delete FROM penjualan where customerno ='" +
        customerno.toString() +
        "' and tglkunjungan ='" +
        tglkunjungan.toString() +
        "' and userid ='" +
        userid.toString() +
        "' ");
    return result;
  }

   _updateDataVisitNota(customerno, tglkunjungan, userid) async {
    Database db = await _dbProvider.database;
         int result = await db.rawInsert(" UPDATE  visittf set nonota = '-1', amount = 0, notbuyreason = null where customerno ='" +
        customerno.toString() +
        "' and tglkunjungan ='" +
        tglkunjungan.toString() +
        "' and userid ='" +
        userid.toString() +
        "' ");
    return result;
  }

  _updateDataVisit(customerno, tglkunjungan, userid, nonota, amount) async {
    Database db = await _dbProvider.database;
    int result = await db.rawInsert("UPDATE  visittf set nonota = '" +
        nonota +
        "', amount = " +
        amount +
        " where customerno ='" +
        customerno.toString() +
        "' and tglkunjungan ='" +
        tglkunjungan.toString() +
        "' and userid ='" +
        userid.toString() +
        "'");
    return result;
  }

  //----- akses sqlite

  _cariDataNota(customerno, tglkunjungan, userid) async {
    // get a reference to the database
    Database db = await _dbProvider.database;
    String strSQL;
    strSQL =
        "select SUM (((s.bal *( m.bal / m.pac)) + (s.slof * (m.slof / m.pac)) + s.pac) * s.harga) as amount, v.nonota from visittf v INNER JOIN penjualan s ON s.customerno = v.customerno AND v.userid = s.userid AND v.tglkunjungan = s.tglkunjungan INNER JOIN materialtf m ON s.materialid = m.materialid where s.customerno = '" +
            customerno +
            "' and s.tglkunjungan ='" +
            tglkunjungan +
            "' and v.userid ='" +
            userid +
            "' GROUP BY v.nonota ";
    List<Map> result = await db.rawQuery(strSQL);
    // raw query
    //List<Map> result = await db.rawQuery('SELECT * FROM my_table WHERE name=?', ['Mary']);
    return result;
    // print the results
    //result.forEach((row) => print(row));
    // {_id: 2, name: Mary, age: 32}
  }

  // Future<List<NotaPenjualan>> _getNoNota(
  //     customerno, tglkunjungan, userid) async {
  //   // Get a reference to the database.
  //   final Database db = await _dbProvider.database;
  //   // Query the table for all The Dogs.
  //   String strSQL;
  //   strSQL =
  //       "select SUM ((s.bal *( m.bal / m.pac) * s.harga) +(s.slof * (m.slof / m.pac) * s.harga)+ (s.pac  * s.harga)) as amount, v.nonota from visittf v INNER JOIN penjualan s ON s.customerno = v.customerno AND v.userid = s.userid AND v.tglkunjungan = s.tglkunjungan INNER JOIN materialtf m ON s.materialid = m.materialid where s.customerno = '" +
  //           customerno +
  //           "' and s.tglkunjungan ='" +
  //           tglkunjungan +
  //           "' and v.userid ='" +
  //           userid +
  //           "' ";
  //   final List<Map<String, dynamic>> maps = await db.rawQuery(strSQL);
  //   //final List<Map<String, dynamic>> maps = await db.query('dogs');

  //   // Convert the List<Map<String, dynamic> into a List<Dog>.
  //   return List.generate(maps.length, (i) {
  //     return NotaPenjualan(
  //       nonota: maps[i]['nonota'],
  //       amount: maps[i]['amount'],
  //     );
  //   });
  // }

  Future<List<PenjualanModelTF>> _getPenjualan(
      String customerno, tglkunjungan, userid) async {
    final db = await _dbProvider.database;
    List<Map<String, dynamic>> result;
    //result = await db.query("customer", columns: columns);
    result = await db.rawQuery(
        "select s.penjualantrxid,s.customerno,s.tglkunjungan,s.materialid,m.materialname,s.pac,s.slof,s.bal,s.introdeal,s.harga, (1) as rownumber from visittf v INNER JOIN penjualan s ON s.customerno = v.customerno AND v.userid = s.userid AND v.tglkunjungan = s.tglkunjungan INNER JOIN materialtf m ON s.materialid = m.materialid where s.customerno ='" +
            customerno +
            "' and s.tglkunjungan ='" +
            tglkunjungan +
            "' and v.userid ='" +
            userid +
            "' ORDER BY s.penjualantrxid Desc");
    // "' ");
    List<PenjualanModelTF> datapenjualan = result.isNotEmpty
        ? result
            .map((item) => PenjualanModelTF.createPenjualanFromJson(item))
            .toList()
        : [];
    return datapenjualan;
  }

  Widget getDataStockWidget(String customerno, tglkunjungan, userid) {
    return FutureBuilder(
        future: _getPenjualan(customerno, tglkunjungan, userid),
        builder: (BuildContext context,
            AsyncSnapshot<List<PenjualanModelTF>> snapshot) {
          return getPenjualanCardWidget(snapshot);
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

  Widget getPenjualanCardWidget(
      AsyncSnapshot<List<PenjualanModelTF>> snapshot) {
    //print("data penjualan " + snapshot.data.length.toString());
    if (snapshot.hasData) {
      return snapshot.data.length != 0
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemPosition) {
                PenjualanModelTF _dataPenjualan = snapshot.data[itemPosition];
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
                              _dataPenjualan.penjualantrxid.toString(),
                              _dataPenjualan.materialname.toString(),
                              _dataPenjualan.materialid.toString(),
                              _dataPenjualan.pac.toString() +
                                  " pac ; " +
                                  _dataPenjualan.slof.toString() +
                                  " slof ; " +
                                  _dataPenjualan.bal.toString() +
                                  " bal",
                              widget.alamat);
                          //--- tidak bisa ngrender ulang / refresh sehingga pakai screen sendiri
                          // _deleteDataStock(_datastock.stocktrxid.toString());
                          // _getAllStock(widget.customerno, widget.tglkunjungan,
                          //     widget.userid);
                        }),
                    // trxid: "# "+ _datastock.stocktrxid ,
                    namamaterial: _dataPenjualan.materialname,
                    // kodematerial: _dataPenjualan.materialid +
                    //     " [# " +
                    //     _dataPenjualan.rownumber +
                    //     " ]",
                    kodematerial: _dataPenjualan.materialid,
                    qtypac: _dataPenjualan.pac.toString() +
                        " pac ; " +
                        _dataPenjualan.slof.toString() +
                        " slof ; " +
                        _dataPenjualan.bal.toString() +
                        " bal ; " +
                        _dataPenjualan.introdeal +
                        " Introdeal",
                    qtyslof: "Rp" +
                        oCcy.format(int.parse(_dataPenjualan.harga)) +
                        " / pac",
                    // qtybal: _datastock.bal.toString() + " bal",
                    // qtyslof: _datastock.slof.toString() + " slof",
                    lambangaksikanan: IconButton(
                        icon: Icon(
                          Icons.edit,
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
                              _dataPenjualan.penjualantrxid.toString(),
                              _dataPenjualan.materialname.toString(),
                              _dataPenjualan.materialid.toString(),
                              _dataPenjualan.pac.toString(),
                              _dataPenjualan.slof.toString(),
                              _dataPenjualan.bal.toString(),
                              widget.alamat);
                        }));
              },
            )
          : Container(
              child: Center(
              //this is used whenever there 0 Todo
              //in the data base
              //child: noCustomerMessageWidget(),
              child: Text("Item penjualan tidak ada",style: TextStyle(fontSize: 19)),
            ));
    } else {
      return Center(
        /*since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the use know the app is currently
        processing*/
        child: Text("Loading..."),
      );
    }
  }
}

// class NotaPenjualan {
//   final String nonota;
//   final int amount;

//   NotaPenjualan({this.nonota, this.amount});

//   Map<String, dynamic> toMap() {
//     return {
//       'nonota': nonota,
//       'amount': amount,
//     };
//   }

//   // Implement toString to make it easier to see information about
//   // each dog when using the print statement.
//   @override
//   String toString() {
//     return 'NotaPenjualan{ nonota: $nonota, amount: $amount}';
//   }
// }
