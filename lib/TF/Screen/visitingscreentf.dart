import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Constant/listmenu.dart';
import 'package:mimos/Screen/homescreen.dart';
import 'package:mimos/TF/Screen/stockscreentf.dart';
import 'package:mimos/TF/Screen/listcustomervisitscreentf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mimos/Screen/homescreen_old.dart';
import 'package:mimos/TF/Screen/dialogpenjualanscreentf.dart';
import 'package:mimos/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimos/TF/Screen/penjualanscreentf.dart';
import 'package:mimos/TF/Screen/posmscreentf.dart';
import 'package:mimos/TF/Screen/visibilityscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VisitingScreenTF extends StatefulWidget {
  final String customerno;
  final String customername;
  final String tglkunjungan;
  final String userid;
  final String priceid;
  final String alamat;
  VisitingScreenTF(
      {Key key,
      this.customerno,
      this.customername,
      this.tglkunjungan,
      this.userid,
      this.priceid,
      this.alamat})
      : super(key: key);
  @override
  _VisitingScreenTFState createState() => _VisitingScreenTFState();
}

class _VisitingScreenTFState extends State<VisitingScreenTF> {
  SharedPreferences sharedPreferences;
  goToHome() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var root = MaterialPageRoute(
        builder: (context) => new HomeScreen(
              userName: sharedPreferences.getString("username").toString(),
              userId: sharedPreferences.getString("userid").toString(),
              userRoleID: sharedPreferences.getString("userroleid").toString(),
              roleName: sharedPreferences.getString("rolename").toString(),
              salesOfficeId:
                  sharedPreferences.getString("salesofficeid").toString(),
            ));
    Navigator.pushReplacement(context, root);
  }

  final _dbProvider = DatabaseProvider.dbProvider;
  bool _datadialogpenjualan = false;
  bool _dataInputStockDone = false;
  bool _dataInputVisibilityDone = false;
  var listMenuHome = listMenuItemVisitingTF;
  void _setDataInputDisplay() async {
    var result = (await _cekInputDisplay(
        widget.customerno, widget.tglkunjungan, widget.userid));
    if (result.isNotEmpty) {
      setState(() {
        _dataInputVisibilityDone = true;
      });
    } else {
      setState(() {
        _dataInputVisibilityDone = false;
      });
    }
  }

  void _setDataInputStock() async {
    var result = (await _cekInputStock(
        widget.customerno, widget.tglkunjungan, widget.userid));
    if (result.isNotEmpty) {
      setState(() {
        _dataInputStockDone = true;
      });
    } else {
      setState(() {
        _dataInputStockDone = false;
      });
    }
  }

  void _setdatadialogpenjualan() async {
    var ndata;
    var xnotbuyreason;
    var xlookupdesc;
    var result = (await _cariDialogPenjualan(
        widget.customerno, widget.tglkunjungan, widget.userid));
    if (result.isNotEmpty) {
      xnotbuyreason = result[0]['notbuyreason'];
      xlookupdesc = result[0]['lookupdesc'];
      ndata = "1";
    } else {
      xnotbuyreason = "";
      xlookupdesc = "";
      ndata = "0";
    }
    // print("ndata  :" + ndata);
    // print("bu " + xnotbuyreason.toString());
    // print("des " + xlookupdesc.toString());
    // false ke dialog
    setState(() {
      if (ndata == "0") {
        _datadialogpenjualan = false;
      } else {
        if (xnotbuyreason != null) {
          if (xlookupdesc != null) {
            _datadialogpenjualan = false;
          } else {
            _datadialogpenjualan = true;
          }
        } else {
          _datadialogpenjualan = false;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _setdatadialogpenjualan();
    _setDataInputStock();
    _setDataInputDisplay();
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Colors.lightBlue,
            onPressed: () {
              //Navigator.of(context).pushNamed(PROSES_DOWNLOAD_DATA_TF);
              var root =
                  MaterialPageRoute(builder: (context) => new VisitScreenTF());
              Navigator.pushReplacement(context, root);
            },
            child: Icon(Icons.person_add),
          ),
        ],
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () {
                  goToHome();
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
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "KUNJUNGAN KE KONSUMEN",
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
                  if (data.tampilan.toString() == "11") {
                    var root = MaterialPageRoute(
                        builder: (context) => new StockScreenTF(
                              customerno: widget.customerno.toString(),
                              customername: widget.customername.toString(),
                              tglkunjungan: widget.tglkunjungan.toString(),
                              userid: widget.userid.toString(),
                              priceid: widget.priceid.toString(),
                              alamat: widget.alamat.toString(),
                            ));
                    Navigator.pushReplacement(context, root);
                  } else if (data.tampilan.toString() == "14") {
                    var root = MaterialPageRoute(
                        builder: (context) => new VisibilityScreen(
                              customerno: widget.customerno.toString(),
                              customername: widget.customername.toString(),
                              tglkunjungan: widget.tglkunjungan.toString(),
                              userid: widget.userid.toString(),
                              priceid: widget.priceid.toString(),
                              alamat: widget.alamat.toString(),
                            ));
                    Navigator.pushReplacement(context, root);
                  } else if (data.tampilan.toString() == "12") {
                    // cek apakah cek stock  material default sudah di cek?
                    if (_dataInputStockDone) {
                      Fluttertoast.showToast(
                          msg: "Input Cek Stock Belum Lengkap",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          //backgroundColor: Colors.red,
                          textColor: Colors.red,
                          fontSize: 16.0,
                          timeInSecForIosWeb: 1);
                    } else {
                      // cek input display
                      if (_dataInputVisibilityDone) {
                        Fluttertoast.showToast(
                            msg: "Input Cek Display Belum Lengkap",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            //backgroundColor: Colors.red,
                            textColor: Colors.red,
                            fontSize: 16.0,
                            timeInSecForIosWeb: 1);
                      } else {
// cek apakah sudah inputan dialogpenjualan
                        // print(_datadialogpenjualan);
                        if (_datadialogpenjualan) {
                          var root = MaterialPageRoute(
                              builder: (context) => new PenjualanScreenTF(
                                    customerno: widget.customerno.toString(),
                                    customername:
                                        widget.customername.toString(),
                                    tglkunjungan:
                                        widget.tglkunjungan.toString(),
                                    userid: widget.userid.toString(),
                                    priceid: widget.priceid.toString(),
                                    alamat: widget.alamat.toString(),
                                  ));
                          Navigator.pushReplacement(context, root);
                        } else {
                          var root = MaterialPageRoute(
                              builder: (context) => new DialogPenjualanScreenTF(
                                    customerno: widget.customerno.toString(),
                                    customername:
                                        widget.customername.toString(),
                                    tglkunjungan:
                                        widget.tglkunjungan.toString(),
                                    priceid: widget.priceid.toString(),
                                    alamat: widget.alamat.toString(),
                                    userid: widget.userid.toString(),
                                  ));
                          Navigator.pushReplacement(context, root);
                        }
                      }
                    }
                  } else if (data.tampilan.toString() == "13") {
                    var root = MaterialPageRoute(
                        builder: (context) => new POSMScreenTF(
                              customerno: widget.customerno.toString(),
                              customername: widget.customername.toString(),
                              tglkunjungan: widget.tglkunjungan.toString(),
                              priceid: widget.priceid.toString(),
                              alamat: widget.alamat.toString(),
                              userid: widget.userid.toString(),
                            ));
                    Navigator.pushReplacement(context, root);
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
                            // decoration: BoxDecoration(
                            //   boxShadow: [
                            //     BoxShadow(
                            //         color: Colors.black.withOpacity(0.1),
                            //         blurRadius: 5,
                            //         offset: Offset(1, 1))
                            //   ],
                            //   color: Colors.white,
                            //   border:
                            //       // Border.all(color: Colors.blueAccent),
                            //       Border.all(color: Colors.transparent),
                            //   borderRadius: BorderRadius.circular(6),
                            // ),
                            child: Icon(data.lambang,
                                size: 50.0, color: MyPalette.ijoMimos),
                          ),
                          Text(data.judul,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              textAlign: TextAlign.center)
                        ],
                      ),
                      // child: Text(data.title,
                      //     style: TextStyle(fontSize: 22, color: Colors.black),
                      //     textAlign: TextAlign.center),
                    ))))
            .toList(),
      )),
    );
  }

  //- cek apakah  material sudah ada penjualan
//   _cekInputdialogPenjualan(customerno, tglkunjungan, userid) async {
//     Database db = await _dbProvider.database;
//     String strSQL;
//     strSQL = "select count(customerno) from visittf v  where v.customerno = '" +
//         customerno +
//         "' and v.tglkunjungan ='" +
//         tglkunjungan +
//         "' and v.userid ='" +
//         userid +
//         "'  and notbuyreason is not null ";
// //print(strSQL);
//     int count = Sqflite.firstIntValue(await db.rawQuery(strSQL));
//     //print(count);
//     return count;
//   }
  _cekInputDisplay(customerno, tglkunjungan, userid) async {
    Database db = await _dbProvider.database;
    String strSQL;
    strSQL = "select visibilitytrxid from visibility where  customerno = '" +
        customerno +
        "' and tglkunjungan ='" +
        tglkunjungan +
        "' and userid ='" +
        userid +
        "' and iscek='N'";
    List<Map> result = await db.rawQuery(strSQL);
    return result;
  }

  _cekInputStock(customerno, tglkunjungan, userid) async {
    Database db = await _dbProvider.database;
    String strSQL;
    strSQL = "select stocktrxid from stocktf where  customerno = '" +
        customerno +
        "' and tglkunjungan ='" +
        tglkunjungan +
        "' and userid ='" +
        userid +
        "' and iscek='N'";
    List<Map> result = await db.rawQuery(strSQL);
    return result;
  }

  _cariDialogPenjualan(customerno, tglkunjungan, userid) async {
    // get a reference to the database
    Database db = await _dbProvider.database;
    String strSQL;
    strSQL =
        "select notbuyreason,lookupdesc from visittf v left join lookup l on v.notbuyreason = l.lookupvalue and l.lookupkey ='not_buy_reason'  where v.notbuyreason <>'-1' and v.customerno = '" +
            customerno +
            "' and v.tglkunjungan ='" +
            tglkunjungan +
            "' and v.userid ='" +
            userid +
            "' ";
    List<Map> result = await db.rawQuery(strSQL);
    // raw query
    //List<Map> result = await db.rawQuery('SELECT * FROM my_table WHERE name=?', ['Mary']);
    return result;
    // print the results
    //result.forEach((row) => print(row));
    // {_id: 2, name: Mary, age: 32}
  }
}

const List<MenuItem> listMenuItemVisitingTF = const <MenuItem>[
  const MenuItem(
      judul: 'CEK STOCK', lambang: Icons.smoking_rooms, tampilan: '11'),
  const MenuItem(
      judul: 'CEK DISPLAY', lambang: Icons.picture_in_picture, tampilan: '14'),
  const MenuItem(
      judul: 'PENJUALAN', lambang: Icons.shopping_cart, tampilan: '12'),
  const MenuItem(judul: 'POSM', lambang: Icons.storage, tampilan: '13'),
];
