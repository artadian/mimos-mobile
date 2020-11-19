import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
//import 'package:mimos/TF/Dao/materialdaotf.dart';
import 'package:mimos/TF/Model/penjualanmodeltf.dart';
import 'package:mimos/TF/UC/kartupenjualancustomer.dart';
//import 'package:mimos/TF/Bloc/penjualanbloctf.dart';
import 'package:intl/intl.dart';
//import 'package:mimos/TF/Model/materialmodeltf.dart';
import 'package:mimos/TF/Bloc/penjualantotalbloc.dart';
import 'package:mimos/TF/Dao/customerdaotf.dart';
import 'package:mimos/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RingkasanScreenTF extends StatefulWidget {
  @override
  _RingkasanScreenTFState createState() => _RingkasanScreenTFState();
}

class _RingkasanScreenTFState extends State<RingkasanScreenTF> {
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  final _dbProvider = DatabaseProvider.dbProvider;
  Future<String> _getDataUserID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("userid") ?? "No UserID";
  }

  PenjualanTotalBloc _penjualanTotalBloc = PenjualanTotalBloc();
  // String _currentValueMaterial;
  //final TextEditingController totalController = new TextEditingController();
  //var _totalamount;
  //TabController _tabController;
  String _userID;

  int _nDataCust = 0;
  int _nDataCustTerkunjungi = 0;
  int _nDataNotaKonsumen = 0;
  CustomerDaoTF _cunstomerDao = CustomerDaoTF();
  _getDataCustomer() {
    return _cunstomerDao.countData();

    /// format future <int>
  }

  _getKonsumenTerkunjungi() {
    return _cunstomerDao.countKonsumenTerkunjungi();
  }

  _getNotaKonsumen() {
    return _cunstomerDao.countNotaKonsumen();
  }

  // --- cari total penjualan
  _cariDataNota() async {
    // get a reference to the database
    Database db = await _dbProvider.database;
    String strSQL;
    strSQL =
        "select SUM (((s.bal *( m.bal / m.pac)) + (s.slof * (m.slof / m.pac)) + s.pac) * s.harga) as amount, sum(s.qtypenjualan) as qty from visittf v INNER JOIN penjualan s ON s.customerno = v.customerno AND v.userid = s.userid AND v.tglkunjungan = s.tglkunjungan INNER JOIN materialtf m ON s.materialid = m.materialid where v.nonota <>'-1' and v.userid ='" +
            _userID +
            "'";
    List<Map> result = await db.rawQuery(strSQL);
    return result;
  }

  int _totalNominal = 0;
  String strTotalNominal = "0";
  int _totalQty = 0;
  void _getTotal() async {
    var totalQty;
    var total;
    var result = (await _cariDataNota());
    if (result.isNotEmpty) {
      total = result[0]['amount'];
      totalQty = result[0]['qty'];
    } else {
      totalQty = 0;
      total = 0;
    }
    setState(() {
      if (total != null) {
        _totalNominal = total;
      }
      if (totalQty != null) {
        _totalQty = totalQty;
      }
      strTotalNominal = "Rp." + oCcy.format(_totalNominal);
    });
  }

  //----
  @override
  void initState() {
    super.initState();
    _getDataUserID().then((val) => setState(() {
          _userID = val;
        }));
     _getTotal();
    _getDataCustomer().then((val) => setState(() {
          _nDataCust = val;
          //print ("val");
        }));
    _getKonsumenTerkunjungi().then((val) => setState(() {
          _nDataCustTerkunjungi = val;
          //print ("val");
        }));
    _getNotaKonsumen().then((val) => setState(() {
      if (val != null) {
_nDataNotaKonsumen = val;
      }     
           //print (val);
        }));
    // _tabController = new TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    //_tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width - 5;
    // final double appBarHeight = kToolbarHeight;
    // final double paddingBottom = mediaQueryData.padding.bottom;
    // final double heightScreen =
    //     mediaQueryData.size.height - paddingBottom - appBarHeight;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF54C5F8),
        title: Text("RINGKASAN PENJUALAN"),
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
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: new Card(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: new Container(
                            child: new Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Text("Rencana",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                            new Text("Kunjungan",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                            new Container(
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                // shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _nDataCust.toString(),
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                            new SizedBox(
                              height: 5.0,
                            ),
                          ],
                        )),
                      )),
                      Expanded(
                          child: new Card(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: new Container(
                            child: new Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Text("Telah",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                            new Text("Dikunjungi",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                            new Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                // shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _nDataCustTerkunjungi.toString(),
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                            new SizedBox(
                              height: 5.0,
                            ),
                          ],
                        )),
                      )),
                      Expanded(
                          child: new Card(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: new Container(
                            child: new Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              "Tidak",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            new Text("Dikunjungi",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                            new Container(
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                // shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                (_nDataCust - _nDataCustTerkunjungi).toString(),
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                            new SizedBox(
                              height: 5.0,
                            ),
                          ],
                        )),
                      ))
                    ],
                  ),
                  // tes baris
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: new Card(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: new Container(
                            child: new Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Text("Nota",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                            new Text("Penjualan",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                            new Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                // shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _nDataNotaKonsumen.toString(),
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                            new SizedBox(
                              height: 5.0,
                            ),
                          ],
                        )),
                      )),
                      Expanded(
                          child: new Card(
                        color: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: new Container(
                            child: new Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Text("Kunjungan",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                            new Text("Tanpa Penjualan",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                            new Container(
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                // shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                (_nDataCustTerkunjungi - _nDataNotaKonsumen)
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                            new SizedBox(
                              height: 5.0,
                            ),
                          ],
                        )),
                      )),
                      Expanded(
                          child: new Card(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: new Container(
                            child: new Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Text("Total Pac",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                            new Text("Terjual",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                            new Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                // shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _totalQty.toString(),
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                            new SizedBox(
                              height: 5.0,
                            ),
                          ],
                        )),
                      ))
                    ],
                  ),
                  new Card(
                    shape: RoundedRectangleBorder(
                        //borderRadius: BorderRadius.circular(10.0),
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
                    color: Colors.green,
                    elevation: 5,
                    child: Container(
                      width: widthScreen - 10,
                      child: new Column(
                        children: <Widget>[
                          new SizedBox(
                            height: 5.0,
                          ),
                          new Text(
                            "Total Penjualan",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          new SizedBox(
                            height: 5.0,
                          ),
                          new Text(strTotalNominal,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 27)),
                          new SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // end tes baris
                  // // baris pertama
                  // new Row(
                  //   children: <Widget>[
                  //     new Container(
                  //       width: widthScreen / 3,
                  //       decoration: BoxDecoration(
                  //         border: Border.all(),
                  //         color: Colors.grey[200],
                  //         // borderRadius: BorderRadius.only(
                  //         //   topLeft: Radius.circular(20),
                  //         //   bottomRight: Radius.circular(20),
                  //         // )

                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       child: new Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           new Text("\n Rencana \n Kunjungan\n",
                  //               style: TextStyle(color: Colors.black)),
                  //           SizedBox(
                  //             width: 5,
                  //             child: Text(""),
                  //           ),
                  //           new Container(
                  //             decoration: BoxDecoration(
                  //               color: Colors.blueAccent,
                  //               // shape: BoxShape.rectangle,
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //             child: Text(
                  //               "30",
                  //               style: TextStyle(fontSize: 25),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     new Container(
                  //       width: widthScreen / 3,
                  //       decoration: BoxDecoration(
                  //           //border: Border.all(),
                  //           color: Colors.green,
                  //           borderRadius: BorderRadius.only(
                  //             bottomLeft: Radius.circular(20),
                  //             bottomRight: Radius.circular(20),
                  //           )),
                  //       child: new Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           new Text("\n Telah di \n Kunjungan\n",
                  //               style: TextStyle(color: Colors.white)),
                  //           SizedBox(
                  //             width: 5,
                  //             child: Text(""),
                  //           ),
                  //           new Container(
                  //             decoration: BoxDecoration(
                  //               color: Colors.grey[100],
                  //               // shape: BoxShape.rectangle,
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //             child: Text(
                  //               "30",
                  //               style: TextStyle(fontSize: 25),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     new Container(
                  //       width: widthScreen / 3,
                  //       decoration: BoxDecoration(
                  //           //border: Border.all(),
                  //           color: Colors.redAccent,
                  //           borderRadius: BorderRadius.only(
                  //             topRight: Radius.circular(20),
                  //             bottomLeft: Radius.circular(20),
                  //           )),
                  //       child: new Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           new Text("\n Tidak di \n Kunjungan\n",
                  //               style: TextStyle(color: Colors.white)),
                  //           SizedBox(
                  //             width: 5,
                  //             child: Text(""),
                  //           ),
                  //           new Container(
                  //             decoration: BoxDecoration(
                  //               color: Colors.grey[100],
                  //               // shape: BoxShape.rectangle,
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //             child: Text(
                  //               "30",
                  //               style: TextStyle(fontSize: 25),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // // --- end baris pertama
                  // baris kedua
                  // new Row(
                  //   children: <Widget>[
                  //     new Container(
                  //       width: widthScreen / 3,
                  //       decoration: BoxDecoration(
                  //           //border: Border.all(),
                  //           color: Colors.green,
                  //           borderRadius: BorderRadius.only(
                  //             topRight: Radius.circular(20),
                  //             bottomLeft: Radius.circular(20),
                  //           )),
                  //       child: new Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           new Text("\n Nota \n Penjualan\n",
                  //               style: TextStyle(color: Colors.white)),
                  //           SizedBox(
                  //             width: 5,
                  //             child: Text(""),
                  //           ),
                  //           new Container(
                  //             decoration: BoxDecoration(
                  //               color: Colors.grey[100],
                  //               // shape: BoxShape.rectangle,
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //             child: Text(
                  //               "30",
                  //               style: TextStyle(fontSize: 25),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     new Container(
                  //       width: widthScreen / 3,
                  //       decoration: BoxDecoration(
                  //           //border: Border.all(),
                  //           color: Colors.amber,
                  //           borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(20),
                  //             topRight: Radius.circular(20),
                  //           )),
                  //       child: new Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           new Text("\n Kunj.tnp\nPenjualan\n",
                  //               style: TextStyle(color: Colors.white)),
                  //           SizedBox(
                  //             width: 5,
                  //             child: Text(""),
                  //           ),
                  //           new Container(
                  //             decoration: BoxDecoration(
                  //               color: Colors.grey[100],
                  //               // shape: BoxShape.rectangle,
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //             child: Text(
                  //               "30",
                  //               style: TextStyle(fontSize: 25),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     new Container(
                  //       width: widthScreen / 3,
                  //       decoration: BoxDecoration(
                  //           //border: Border.all(),
                  //           color: Colors.lightBlue,
                  //           borderRadius: BorderRadius.only(
                  //             bottomRight: Radius.circular(20),
                  //             topLeft: Radius.circular(20),
                  //           )),
                  //       child: new Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           new Text("\n Total Pac\n Terjual\n",
                  //               style: TextStyle(color: Colors.white)),
                  //           SizedBox(
                  //             width: 5,
                  //             child: Text(""),
                  //           ),
                  //           new Container(
                  //             decoration: BoxDecoration(
                  //               color: Colors.grey[100],
                  //               // shape: BoxShape.rectangle,
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //             child: Text(
                  //               "30",
                  //               style: TextStyle(fontSize: 25),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // --- end baris kedua
                  Expanded(child: gePenjualanTotal()),
                ],
              ))),
    );
  }

//   Future<int> sumStream(Stream<int> stream) async {
//   var sum = 0;
//   await for (var value in stream) {
//     sum += value;
//   }
//   return sum;
// }
// Future getTotal() async {
//      int counter = 0;
//   //  var result = _penjualanBloc.penjualanByMaterialID  ;
//   //  result.forEach((row) => print(row));
//    await _penjualanBloc.penjualanByMaterialID
//        .listen((data) =>
//         data.forEach((doc) => counter += (doc["amountnota"])));

//     // await Firestore.instance
//     //     .collection('post').document('doc').collection('collection')
//     //     .snapshots()
//     //     .listen((data) =>
//     //     data.documents.forEach((doc) => counter += (doc["score"])));
//    print("The total is $counter");
//     //return counter;
//   }

  Widget gePenjualanTotal() {
    return StreamBuilder(
      stream: _penjualanTotalBloc.penjualanTotalByMaterialID,
      builder: (BuildContext context,
          AsyncSnapshot<List<PenjualanModelTF>> datatotal) {
        return getPenjualanTotaldWidget(datatotal, context);
      },
    );
  }

  Widget getPenjualanTotaldWidget(
      AsyncSnapshot<List<PenjualanModelTF>> datatotal, context) {
    if (datatotal.hasData) {
      return datatotal.data.length != 0
          ? ListView.builder(
              // print(snapshot.data.length.toString()),
              itemCount: datatotal.data.length,
              itemBuilder: (context, itemPosition) {
                PenjualanModelTF _dataPenjualanTot =
                    datatotal.data[itemPosition];
                return new KartuPenjualanCustomer(
                    namacustomer: _dataPenjualanTot.materialname,
                    kodecustomer: _dataPenjualanTot.materialid,
                    alamatcustomer: "@Rp. " +
                        oCcy.format(int.parse(_dataPenjualanTot.harga)),
                    kotacustomer: _dataPenjualanTot.pac +
                        " pac ; " +
                        _dataPenjualanTot.slof +
                        " slof ; " +
                        _dataPenjualanTot.bal +
                        " bal " +
                        " ; introdeal " +
                        _dataPenjualanTot.introdeal,
                    logo: Icons.check,
                    warnalogo: Colors.green,
                    tglkunjungan: "Rp. " +
                        oCcy.format(int.parse(_dataPenjualanTot.amountnota)),
                    datanota: "",
                    lambangaksi: IconButton(
                        icon: Icon(Icons.store, color: Colors.transparent),
                        onPressed: () {}));
              },
            )
          : Container(
              child: Center(
              //this is used whenever there 0 Todo
              //in the data base
              child: noDataPenjualanTotalWidget(),
            ));
    } else {
      return Center(
        child: loadingDataPenjualanTotal(),
      );
    }
  }

  Widget loadingDataPenjualanTotal() {
    //pull todos again
    _penjualanTotalBloc.getPenjualanTotalByMaterialID();
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
        "Data not found ",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget noDataPenjualanTotalWidget() {
    return Container(
      child: Text(
        "Data Penjualan Tidak Ada",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }
}
