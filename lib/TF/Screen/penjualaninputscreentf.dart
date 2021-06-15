import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/TF/Dao/materialdaotf.dart';
import 'package:mimos/TF/Model/materialmodeltf.dart';
import 'package:mimos/TF/Screen/penjualanscreentf.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:mimos/db/database.dart';
import 'package:intl/intl.dart';

class PenjualanInputScreenTF extends StatefulWidget {
  final String customerno;
  final String customername;
  final String tglkunjungan;
  final String userid;
  final String priceid;
  final String alamat;
  PenjualanInputScreenTF(
      {Key key,
      this.customerno,
      this.customername,
      this.tglkunjungan,
      this.userid,
      this.priceid,
      this.alamat})
      : super(key: key);
  @override
  _PenjualanInputScreenTFState createState() => _PenjualanInputScreenTFState();
}

class _PenjualanInputScreenTFState extends State<PenjualanInputScreenTF> {
  DatabaseProvider _dbprovider = DatabaseProvider();
  final TextEditingController balController = new TextEditingController();
  final TextEditingController hargaController = new TextEditingController();
  final TextEditingController slofController = new TextEditingController();
  final TextEditingController pacController = new TextEditingController();
  final TextEditingController introdealController = new TextEditingController();
  //final TextEditingController introdealIDController = new TextEditingController();
  MaterialDaoTF _materialDao = MaterialDaoTF();
  String _currentValueMaterial;
  String _introdealID;
  int _harga;
  int _qtybonus;
  int _qtyorder;
  int _bal2Pac;
  int _slof2Pac;
  int _minQty;
  int _inStock;
  //int _inDisplay;
  int _stdMinimal;
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  goToHome(
      String customerno, customername, tglkunjungan, userid, priceid, alamat) {
    var root = MaterialPageRoute(
        builder: (context) => new PenjualanScreenTF(
              customerno: customerno.toString(),
              customername: customername.toString(),
              tglkunjungan: tglkunjungan.toString(),
              userid: userid.toString(),
              priceid: priceid.toString(),
              alamat: alamat.toString(),
            ));
    Navigator.pushReplacement(context, root);
  }

//  getVisibility(materialid) async {
//     Database db = await _dbprovider.database;
//     String strSQL;
//     strSQL =
//         "select p.pac as maxwsp from visibility_wsp p INNER JOIN materialtf m ON m.materialid = p.materialid INNER JOIN customer c ON c.wspclass = p.wspclass and c.tanggalkunjungan = p.tglkunjungan and c.customerno = p.customerno where p.materialid = '" +
//             materialid +
//             "' and c.customerno = '" +
//             widget.customerno +
//             "' and c.tanggalkunjungan = '" +
//             widget.tglkunjungan +
//             "' and c.userid = '" +
//             widget.userid +
//             "' Order By p.materialid Desc LIMIT 1 ";
//     List<Map> result = await db.rawQuery(strSQL);
//     var _maxwsp;
//     if (result.isNotEmpty) {
//       _maxwsp = result[0]['maxwsp'];
//     } else {
//       _maxwsp = 0;
//     }

//     setState(() {
//       if (_maxwsp != null) {
//         _stdMinimal = _maxwsp;
//       } else {
//         _stdMinimal = 0;
//       }
//     });
//     //print(_harga);
//   }

   getQtyStock(materialid) async {
    Database db = await _dbprovider.database;
    String strSQL;
   // strSQL =
       // "select p.qtystock as stock from stocktf p INNER JOIN materialtf m ON m.materialid = p.materialid INNER JOIN customer c ON  c.tanggalkunjungan = p.tglkunjungan and c.customerno = p.customerno where p.materialid = '" +
        //    materialid +
        //    "' and c.customerno = '" +
         //   widget.customerno +
          //  "' and c.tanggalkunjungan = '" +
            //widget.tglkunjungan +
           // "' and c.userid = '" +
           // widget.userid +
           // "' Order By p.materialid Desc LIMIT 1 ";
             strSQL =
        "select p.pac as stock from visibility p INNER JOIN materialtf m ON m.materialid = p.materialid INNER JOIN customer c ON  c.tanggalkunjungan = p.tglkunjungan and c.customerno = p.customerno where p.materialid = '" +
            materialid +
            "' and c.customerno = '" +
            widget.customerno +
            "' and c.tanggalkunjungan = '" +
            widget.tglkunjungan +
            "' and c.userid = '" +
            widget.userid +
            "' Order By p.materialid Desc LIMIT 1 ";
           
    List<Map> result = await db.rawQuery(strSQL);
    var _stockQty;
    if (result.isNotEmpty) {
      _stockQty = result[0]['stock'];
    } else {
      _stockQty = 0;
    }
//---  visibility
 Database db2 = await _dbprovider.database;
    String strSQL2;
    strSQL2 =
        "select p.pac as maxwsp from visibility_wsp p INNER JOIN materialtf m ON m.materialid = p.materialid INNER JOIN customer c ON c.wspclass = p.wspclass and c.tanggalkunjungan = p.tglkunjungan and c.customerno = p.customerno where p.materialid = '" +
            materialid +
            "' and c.customerno = '" +
            widget.customerno +
            "' and c.tanggalkunjungan = '" +
            widget.tglkunjungan +
            "' and c.userid = '" +
            widget.userid +
            "' Order By p.materialid Desc LIMIT 1 ";
    List<Map> result2 = await db2.rawQuery(strSQL2);
    var _wsp;
    if (result2.isNotEmpty) {
      _wsp = result2[0]['maxwsp'];
    } else {
      _wsp = 0;
    }
// end visibility
    setState(() {
      if (_stockQty != null) {
        _inStock = _stockQty;
      } else {
        _inStock = 0;
      }

       if (_wsp != null) {
        _stdMinimal = _wsp;
      } else {
        _stdMinimal = 0;
      }

      //--- kalkulasi
       _minQty = _stdMinimal - _inStock ;
      if (_minQty < 0) {
        _minQty = 0;
      }
      //--- end
    });
    
    //print("wsp " + _stdMinimal.toString());

  }

//kalukulasiMinQty()  {
    // setState(() {
    //   print("kal" +_inStock.toString());
    //   print(_stdMinimal);
    //  // _minQty = _stdMinimal - (_inStock + _inDisplay);
    //   _minQty = _stdMinimal - _inStock ;
    //   if (_minQty < 0) {
    //     _minQty = 0;
    //   }
    //   print(_minQty);
    // });
  //}

  @override
  void initState() {
    super.initState();
    // _cekTransaksi();
    balController.text = "0";
    _introdealID = "0";
    //slofController.text ="0";
    //pacController.text ="0";
    _stdMinimal = 0;
    _minQty = 0;
    _inStock = 0;
    //_inDisplay = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INPUT ITEM PENJUALAN"),
        leading: new Container(),
        //backgroundColor: warnaBackground,
        backgroundColor: MyPalette.ijoMimos,
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
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(mainAxisSize: MainAxisSize.max,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Item Barang",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  new FutureBuilder(
                      future: _materialDao.getSelectMaterialTF(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<MaterialModelTF>> snapshot) {
                        if (!snapshot.hasData)
                          return CircularProgressIndicator();
                        return DropdownButton<String>(
                            value: _currentValueMaterial,
                            // isExpanded: false,
                            hint: Text("Pilih Item Barang"),
                            items: snapshot.data
                                .map((MaterialModelTF _listMaterial) =>
                                    DropdownMenuItem(
                                      value: _listMaterial.materialid,
                                      child: Text(_listMaterial.materialname),
                                    ))
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _currentValueMaterial = newValue;
                                //getVisibility(_currentValueMaterial);
                                getQtyStock(_currentValueMaterial);
                                //kalukulasiMinQty();
                                getHarga(
                                    _currentValueMaterial,
                                    widget.tglkunjungan
                                        .replaceAll(new RegExp(r'-'), ''),
                                    widget.priceid);
                                getIntrodeal(
                                    _currentValueMaterial,
                                    widget.tglkunjungan
                                        .replaceAll(new RegExp(r'-'), ''),
                                    widget.customerno);
                              });
                            });
                      }),
                  new TextFormField(
                      controller: hargaController,
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      decoration: new InputDecoration(
                        labelText: "Harga @",
                        labelStyle: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                        prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 7.0),
                            child: new Icon(Icons.attach_money)),
                      )),
                  new TextFormField(
                      controller: introdealController,
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      decoration: new InputDecoration(
                        labelText: "Introdeal",
                        labelStyle: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                        prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 7.0),
                            child: new Icon(Icons.chat)),
                      )),
                  new TextFormField(
                      controller: balController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        labelText: "Jumlah Bal",
                        labelStyle: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                        prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 7.0),
                            child: new Icon(Icons.create)),
                      )),
                  new TextFormField(
                      controller: slofController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        labelText: "Jumlah Slof",
                        labelStyle: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                        prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 7.0),
                            child: new Icon(Icons.create)),
                      )),
                  new TextFormField(
                      controller: pacController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        labelText: "Jumlah Pac",
                        labelStyle: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                        prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 7.0),
                            child: new Icon(Icons.create)),
                      )),
                  SizedBox(
                    width: 40,
                    child: Text(""),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "* Minimal Order " + _minQty.toString() + " Pac",
                        // style: TextStyle(
                        //     fontSize: 18,
                        //     color: Colors.black,
                        //     ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(""),
                  ),
                  new RaisedButton(
                    padding: EdgeInsets.fromLTRB(45, 12, 45, 12),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () {
                      //Navigator.pop(context,ProsesStockScreenTF);
                      if (_currentValueMaterial != null) {
                        if (!(balController.value.text
                                .trim()
                                .toString()
                                .length >
                            0)) {
                          // print(balController.value.text.trim().toString().length);
                          Fluttertoast.showToast(
                              msg: "Jumlah Bal belum diisi",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,

                              //backgroundColor: Colors.red,
                              textColor: Colors.red,
                              fontSize: 16.0,
                              timeInSecForIosWeb: 1);
                        } else if (!(slofController.value.text
                                .trim()
                                .toString()
                                .length >
                            0)) {
                          Fluttertoast.showToast(
                              msg: "Jumlah Slof belum diisi",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,

                              //backgroundColor: Colors.red,
                              textColor: Colors.red,
                              fontSize: 16.0,
                              timeInSecForIosWeb: 1);
                        } else if (!(pacController.value.text
                                .trim()
                                .toString()
                                .length >
                            0)) {
                          Fluttertoast.showToast(
                              msg: "Jumlah Pac belum diisi",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,

                              //backgroundColor: Colors.red,
                              textColor: Colors.red,
                              fontSize: 16.0,
                              timeInSecForIosWeb: 1);
                        } else {
                          //
                          _cekDataPenjualanMaterial(
                                  widget.customerno,
                                  widget.tglkunjungan,
                                  widget.userid,
                                  _currentValueMaterial.toString())
                              .then((val) => setState(() {
                                    if (val > 0) {
                                      //print("ada");
                                      Fluttertoast.showToast(
                                          msg: "Item sudah terinput",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,

                                          //backgroundColor: Colors.red,
                                          textColor: Colors.red,
                                          fontSize: 16.0,
                                          timeInSecForIosWeb: 1);
                                    } else {
                                      //print("tidak ada");
                                      String _fixIntrodeal;
                                      String _fixIntrodealID;
                                      int _totQty;
                                      _totQty = (int.parse(
                                                  balController.value.text) *
                                              _bal2Pac) +
                                          (int.parse(
                                                  slofController.value.text) *
                                              _slof2Pac) +
                                          (int.parse(pacController.value.text));
// cek harus minimal sesuai std wsp
                                      if (_totQty < _minQty) {
                                        Fluttertoast.showToast(
                                            msg: "Jumlah kurang dari Minimal Order",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,

                                            //backgroundColor: Colors.red,
                                            textColor: Colors.red,
                                            fontSize: 16.0,
                                            timeInSecForIosWeb: 1);
                                      } else {
                                        if (_qtybonus > 0) {
                                          if ((int.parse(balController
                                                          .value.text) *
                                                      _bal2Pac) +
                                                  (int.parse(slofController
                                                          .value.text) *
                                                      _slof2Pac) +
                                                  (int.parse(slofController
                                                      .value.text)) >
                                              _qtyorder) {
                                            _fixIntrodeal =
                                                _qtybonus.toString();
                                            _fixIntrodealID = _introdealID;
                                          } else {
                                            _fixIntrodeal = "0";
                                            _fixIntrodealID = "0";
                                          }
                                        } else {
                                          _fixIntrodeal = "0";
                                          _fixIntrodealID = "0";
                                        }
                                        _insertDataPenjualan(
                                            widget.customerno,
                                            widget.tglkunjungan,
                                            widget.userid,
                                            _currentValueMaterial,
                                            balController.value.text,
                                            slofController.value.text,
                                            pacController.value.text,
                                            _fixIntrodeal,
                                            _harga.toString(),
                                            _fixIntrodealID,
                                            _totQty.toString());
                                        _updateVisitisEdit(widget.customerno,
                                            widget.tglkunjungan, widget.userid);
                                        goToHome(
                                            widget.customerno,
                                            widget.customername,
                                            widget.tglkunjungan,
                                            widget.userid,
                                            widget.priceid,
                                            widget.alamat);
                                      }
                                    }
                                  }));
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Item belum dipilih",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,

                            //backgroundColor: Colors.red,
                            textColor: Colors.red,
                            fontSize: 16.0,
                            timeInSecForIosWeb: 1);
                      }
                    },
                    child: new Text(
                      " S I M P A N",
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                    color: warnaBackground,
                    textColor: Colors.white,
                    elevation: 5.0,
                    // padding: EdgeInsets.only(
                    //     left: 80.0, right: 80.0, top: 15.0, bottom: 15.0),
                  )
                ])),
      ),
    );
  }

  void getIntrodeal(materialid, since, customerno) async {
    Database db = await _dbprovider.database;
    String strSQL;
    // strSQL = "select i.introdealid,i.qtybonus,i.qtyorder, p.penjualantrxid,ci.custintroid  from introdeal i  LEFT JOIN customer_introdeal ci ON i.introdealid = ci.introdealid AND ci.customerno = '" +
    //     customerno +
    //     "' LEFT JOIN penjualan p ON i.introdealid = p.introdealid AND p.customerno = '" +
    //     customerno.toString() +
    //     "' where p.penjualantrxid is null and p.penjualantrxid = null  and ci.custintroid is null and ci.custintroid = null and i.materialid = '" +
    //     materialid +
    //     "' and i.since <=" +
    //     since +
    //     " and i.expired >=" +
    //     since +
    //     " Order By i.since Desc LIMIT 1 ";

    strSQL =
        "select i.introdealid,i.qtybonus,i.qtyorder  from introdeal i  where i.introdealid not in(select p.introdealid from penjualan p where p.customerno ='" +
            customerno +
            "'  ) and i.introdealid not in(select ci.introdealid from customer_introdeal ci where ci.customerno ='" +
            customerno +
            "'  )and i.materialid = '" +
            materialid +
            "' and i.since <=" +
            since +
            " and i.expired >=" +
            since +
            " Order By i.since Desc LIMIT 1 ";
    //print(strSQL);
    List<Map> result = await db.rawQuery(strSQL);
    var _xqtybonus;
    var _xqtyorder;
    var _xintrodelaID;
    //print(result.length.toString());
    //print(result[0]['penjualantrxid']);
    if (result.isNotEmpty) {
      //print(result[0]['penjualantrxid']);
      // print(result[0]['custintroid']);
      _xqtybonus = result[0]['qtybonus'];
      _xqtyorder = result[0]['qtyorder'];
      _xintrodelaID = result[0]['introdealid'];
    } else {
      _xqtybonus = 0;
      _xqtyorder = 0;
      _xintrodelaID = "0";
    }
// jangan lupa ambil introdeal id
    setState(() {
      _introdealID = _xintrodelaID;
      if (_xqtybonus != null) {
        _qtybonus = _xqtybonus;
      } else {
        _qtybonus = 0;
      }

      if (_xqtyorder != null) {
        _qtyorder = _xqtyorder;
      } else {
        _qtyorder = 0;
      }

      if (_qtybonus > 0) {
        introdealController.text = " Order : " +
            _qtyorder.toString() +
            " Pac;  Bonus : " +
            _qtybonus.toString() +
            " Pac";
      } else {
        introdealController.text = " Bonus : " + _qtybonus.toString() + " Pac";
      }
    });
  }

  void getHarga(materialid, since, priceid) async {
    Database db = await _dbprovider.database;
    String strSQL;
    strSQL =
        "select p.harga,m.bal/m.pac as bal2pac,m.slof/m.pac as slof2pac from price p INNER JOIN materialtf m ON m.materialid = p.materialid where p.materialid = '" +
            materialid +
            "' and priceid ='" +
            priceid +
            "' and since <=" +
            since +
            " Order By since Desc LIMIT 1 ";
    List<Map> result = await db.rawQuery(strSQL);
    var _xHarga;
    var _xBal2Pac;
    var _xSlof2Pac;
    if (result.isNotEmpty) {
      _xHarga = result[0]['harga'];
      _xBal2Pac = result[0]['bal2pac'];
      _xSlof2Pac = result[0]['slof2pac'];
    } else {
      _xHarga = 0;
      _xBal2Pac = 0;
      _xSlof2Pac = 0;
    }

    setState(() {
      if (_xHarga != null) {
        _harga = _xHarga;
      } else {
        _harga = 0;
      }
      if (_xBal2Pac != null) {
        _bal2Pac = _xBal2Pac;
      } else {
        _bal2Pac = 0;
      }
      if (_xSlof2Pac != null) {
        _slof2Pac = _xSlof2Pac;
      } else {
        _slof2Pac = 0;
      }
      hargaController.text = "Rp." + oCcy.format(_harga);
    });
    //print(_harga);
  }

  _updateVisitisEdit(customerno, tglkunjungan, userid) async {
    Database db = await _dbprovider.database;
    await db.rawInsert(
        "Update visittf set iseditsellin ='Y' where customerno = '" +
            customerno.toString() +
            "' and tglkunjungan ='" +
            tglkunjungan +
            "' and userid ='" +
            userid +
            "'");
  }

  _insertDataPenjualan(customerno, tglkunjungan, userid, materialid, bal, slof,
      pac, introdeal, harga, introdealid, totalqty) async {
    //print(introdealid);
    Database db = await _dbprovider.database;
    await db.rawInsert(
        "INSERT INTO penjualan(customerno,userid,tglkunjungan,materialid,bal,slof,pac,introdeal,harga,qtypenjualan,introdealid,getidsellindetail) VALUES('" +
            customerno.toString() +
            "','" +
            userid.toString() +
            "','" +
            tglkunjungan.toString() +
            "','" +
            materialid.toString() +
            "'," +
            bal +
            "," +
            slof +
            "," +
            pac +
            "," +
            introdeal +
            "," +
            harga +
            "," +
            totalqty +
            " ,'" +
            introdealid +
            "','-1')");
  }

  //- cek apakah  material sudah ada penjualan
  _cekDataPenjualanMaterial(
      customerno, tglkunjungan, userid, materialid) async {
    Database db = await _dbprovider.database;
    String strSQL;
    strSQL = "SELECT COUNT(customerno)  FROM penjualan where customerno = '" +
        customerno +
        "' and tglkunjungan ='" +
        tglkunjungan +
        "' and userid ='" +
        userid +
        "' and materialid ='" +
        materialid +
        "' ";
//print(strSQL);
    int count = Sqflite.firstIntValue(await db.rawQuery(strSQL));
    //print(count);
    return count;
  }
}
