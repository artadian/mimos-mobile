import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/TF/Dao/materialdaotf.dart';
import 'package:mimos/TF/Model/materialmodeltf.dart';
import 'package:mimos/TF/Screen/stockscreentf.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:mimos/db/database.dart';
//import 'package:mimos/TF/Model/konsumenmodelsqllite.dart';
//import 'dart:convert';

class InputStockScreenTF extends StatefulWidget {
  final String customerno;
  final String customername;
  final String tglkunjungan;
  final String userid;
  final String priceid;
  final String alamat;
  InputStockScreenTF(
      {Key key,
      this.customerno,
      this.customername,
      this.tglkunjungan,
      this.userid,
      this.priceid,
      this.alamat})
      : super(key: key);
  @override
  _InputStockScreenTFState createState() => _InputStockScreenTFState();
}

class _InputStockScreenTFState extends State<InputStockScreenTF> {
  DatabaseProvider _dbprovider = DatabaseProvider();
  final TextEditingController balController = new TextEditingController();
  final TextEditingController slofController = new TextEditingController();
  final TextEditingController pacController = new TextEditingController();
  MaterialDaoTF _materialDao = MaterialDaoTF();
  String _currentValueMaterial;
  goToHome(
      String customerno, customername, tglkunjungan, userid, priceid, alamat) {
    var root = MaterialPageRoute(
        builder: (context) => new StockScreenTF(
              customerno: customerno.toString(),
              customername: customername.toString(),
              tglkunjungan: tglkunjungan.toString(),
              userid: userid.toString(),
              priceid: priceid.toString(),
              alamat: alamat.toString(),
            ));
    Navigator.pushReplacement(context, root);
  }

  int _bal2Pac;
  int _slof2Pac;
  void getHarga(materialid) async {
    Database db = await _dbprovider.database;
    String strSQL;
    strSQL =
        "select m.bal/m.pac as bal2pac,m.slof/m.pac as slof2pac from price p INNER JOIN materialtf m ON m.materialid = p.materialid where p.materialid = '" +
            materialid +
            "'  Order By since Desc LIMIT 1 ";
    List<Map> result = await db.rawQuery(strSQL);
    var _xBal2Pac;
    var _xSlof2Pac;
    if (result.isNotEmpty) {
      _xBal2Pac = result[0]['bal2pac'];
      _xSlof2Pac = result[0]['slof2pac'];
    } else {
      _xBal2Pac = 0;
      _xSlof2Pac = 0;
    }

    setState(() {
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
    });
    //print(_harga);
  }

  @override
  void initState() {
    super.initState();
    // _cekTransaksi();
    balController.text = "0";
    //slofController.text ="0";
    //pacController.text ="0";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INPUT CEK STOCK"),
        leading: new Container(),
        //backgroundColor: warnaBackground,
        backgroundColor:MyPalette.ijoMimos,
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
            child: Column(
                 mainAxisSize: MainAxisSize.max,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Item Barang ",
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
                            hint: Text("Pilih item barang"),
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
                                getHarga(_currentValueMaterial);
                              });
                            });
                      }),
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
                              timeInSecForIos: 1);
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
                              timeInSecForIos: 1);
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
                              timeInSecForIos: 1);
                        } else {
                          //

                          _cekDataStockMaterial(
                                  widget.customerno,
                                  widget.tglkunjungan,
                                  widget.userid,
                                  _currentValueMaterial.toString())
                              .then((val) => setState(() {
                                    // print("val dalam " + val.toString());
                                    // print("material" +
                                    //     _currentValueMaterial.toString());
                                    if (val > 0) {
                                      //print("ada");
                                      Fluttertoast.showToast(
                                          msg: "item telah tersimpan",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,

                                          //backgroundColor: Colors.red,
                                          textColor: Colors.red,
                                          fontSize: 16.0,
                                          timeInSecForIos: 1);
                                    } else {
                                      //print("tidak ada");
                                      int _totQty;
                                      _totQty = (int.parse(
                                                  balController.value.text) *
                                              _bal2Pac) +
                                          (int.parse(
                                                  slofController.value.text) *
                                              _slof2Pac) +
                                          (int.parse(pacController.value.text));

                                      _insertDataStock(
                                          widget.customerno,
                                          widget.tglkunjungan,
                                          widget.userid,
                                          _currentValueMaterial,
                                          balController.value.text,
                                          slofController.value.text,
                                          pacController.value.text,
                                          _totQty.toString());
                                          _updateVisitisEdit(widget.customerno,
                                          widget.tglkunjungan,
                                          widget.userid);
                                      goToHome(
                                          widget.customerno,
                                          widget.customername,
                                          widget.tglkunjungan,
                                          widget.userid,
                                          widget.priceid,
                                          widget.alamat);
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
                            timeInSecForIos: 1);
                      }
                    },
                    child: new Text(
                      "SIMPAN",
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
_updateVisitisEdit(customerno, tglkunjungan, userid) async {
    Database db = await _dbprovider.database;
    await db.rawInsert("Update visittf set iseditstock ='Y' where customerno = '" +
        customerno.toString()+ "' and tglkunjungan ='"+ tglkunjungan + "' and userid ='"+ userid +"'");
  }

  _insertDataStock(
      customerno, tglkunjungan, userid, materialid, bal, slof, pac, qty) async {
    Database db = await _dbprovider.database;
    await db.rawInsert(
        "INSERT INTO stocktf(customerno,userid,tglkunjungan,materialid,bal,slof,pac,qtystock,getidstockdetail,ismaterialdefault,iscek) VALUES('" +
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
            qty +
            ",'-1','N','Y')");
  }

  //- cek apakah  material sudah distock
  _cekDataStockMaterial(customerno, tglkunjungan, userid, materialid) async {
    Database db = await _dbprovider.database;
    String strSQL;
    strSQL = "SELECT COUNT(customerno)  FROM stocktf where customerno = '" +
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
  //--- delete
  @override
  void dispose() {
    super.dispose();
    pacController.dispose();
    slofController.dispose();
    balController.dispose();
  }
}
