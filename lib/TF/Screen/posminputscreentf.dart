import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/TF/Dao/materialdaotf.dart';
import 'package:mimos/TF/Model/materialmodeltf.dart';
import 'package:mimos/TF/Screen/posmscreentf.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:mimos/db/database.dart';
//import 'package:intl/intl.dart';
import 'package:mimos/TF/Dao/lookupdao.dart';
import 'package:mimos/TF/Model/lookupmodel.dart';

class POSMInputScreenTF extends StatefulWidget {
  final String customerno;
  final String customername;
  final String tglkunjungan;
  final String userid;
  final String priceid;
  final String alamat;
  final String trx;
  final String typeEdit;
  final String conditionEdit;
  final String statusEdit;
  final String materialEdit;
  final String trxIDEdit;
  final String qtyEdit;
  final String noteEdit;
  POSMInputScreenTF(
      {Key key,
      this.customerno,
      this.customername,
      this.tglkunjungan,
      this.userid,
      this.priceid,
      this.alamat,
      this.trx,
      this.typeEdit,
      this.conditionEdit,
      this.statusEdit,
      this.materialEdit,
      this.trxIDEdit,
      this.qtyEdit,
      this.noteEdit})
      : super(key: key);
  @override
  _POSMInputScreenTFState createState() => _POSMInputScreenTFState();
}

class _POSMInputScreenTFState extends State<POSMInputScreenTF> {
  DatabaseProvider _dbprovider = DatabaseProvider();
  final TextEditingController qtyController = new TextEditingController();
  final TextEditingController noteController = new TextEditingController();
  MaterialDaoTF _materialDao = MaterialDaoTF();
  LookupDao _lookupDao = LookupDao();
  String _currentValueMaterial;
  String _currentValueType;
  String _currentValueStatus;
  String _currentValueCondition;
  String _titleScreen;

  goToHome(
      String customerno, customername, tglkunjungan, userid, priceid, alamat) {
    var root = MaterialPageRoute(
        builder: (context) => new POSMScreenTF(
              customerno: customerno.toString(),
              customername: customername.toString(),
              tglkunjungan: tglkunjungan.toString(),
              userid: userid.toString(),
              priceid: priceid.toString(),
              alamat: alamat.toString(),
            ));
    Navigator.pushReplacement(context, root);
  }

  void _cekTransaksi() async {
    if (widget.trx == "edit") {
      setState(() {
        _currentValueMaterial = widget.materialEdit;
        _currentValueType = widget.typeEdit;
        _currentValueStatus = widget.statusEdit;
        _currentValueCondition = widget.conditionEdit;
        qtyController.text = widget.qtyEdit;
        noteController.text = widget.noteEdit;
        _titleScreen = " Edit POSM";
      });
    } else {
      setState(() {
        _titleScreen = " Input POSM";
      });
    }
  }

  bool _isStatusNew = true;
  @override
  void initState() {
    super.initState();
    _cekTransaksi();
    //qtyController.text ="0";
    _currentValueStatus = "1"; // 1 = new , 2 maintenance
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleScreen),
        leading: new Container(),
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
          // alignment: Alignment.centerRight,
          padding: EdgeInsets.all(10),
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Material ",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              new FutureBuilder(
                  future: _materialDao.getSelectMaterialGroup(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MaterialModelTF>> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return DropdownButton<String>(
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                        value: _currentValueMaterial,
                        // isExpanded: false,
                        hint: Text("Pilih material"),
                        items: snapshot.data
                            .map((MaterialModelTF _listMaterial) =>
                                DropdownMenuItem(
                                  value: _listMaterial.materialgroupid,
                                  child: Text(
                                      _listMaterial.materialgroupdescription),
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _currentValueMaterial = newValue;
                          });
                        });
                  }),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    color: Colors.black26,
                    width: 0.5,
                  ),
                )),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "Tipe ",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black45,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new FutureBuilder(
                            future:
                                _lookupDao.getSelectLookup(query: "posm_type"),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<LookupModel>> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return DropdownButton<String>(
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                  value: _currentValueType,
                                  //isExpanded: true,
                                  hint: Text("Pilih Tipe"),
                                  items: snapshot.data
                                      .map((LookupModel _listOfLookup) =>
                                          DropdownMenuItem(
                                            value: _listOfLookup.lookupvalue,
                                            child:
                                                Text(_listOfLookup.lookupdesc),
                                          ))
                                      .toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _currentValueType = newValue;
                                    });
                                  });
                            }),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    color: Colors.black26,
                    width: 0.5,
                  ),
                )),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "Status ",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black45,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new FutureBuilder(
                            future: _lookupDao.getSelectLookup(
                                query: "posm_status"),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<LookupModel>> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              // _currentValueStatus = snapshot.data[0].lookupvalue.toString();
                              return DropdownButton<String>(
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                  value: _currentValueStatus,
                                  //isExpanded: true,
                                  hint: Text("Pilih Status"),
                                  items: snapshot.data
                                      .map((LookupModel _listOfLookup) =>
                                          DropdownMenuItem(
                                            value: _listOfLookup.lookupvalue,
                                            child:
                                                Text(_listOfLookup.lookupdesc),
                                          ))
                                      .toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _currentValueStatus = newValue;
                                      if (_currentValueStatus == "1") {
                                        _isStatusNew = true;
                                      } else {
                                        _isStatusNew = false;
                                      }
                                    });
                                  });
                            }),
                      ],
                    )
                  ],
                ),
              ),
              _isStatusNew
                  ? SizedBox(
                      width: 1,
                      child: Text(""),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: Colors.black26,
                          width: 0.5,
                        ),
                      )),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                "Kondisi ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              new FutureBuilder(
                                  future: _lookupDao.getSelectLookup(
                                      query: "posm_condition"),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<LookupModel>>
                                          snapshot) {
                                    if (!snapshot.hasData)
                                      return CircularProgressIndicator();
                                    return DropdownButton<String>(
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                        value: _currentValueCondition,
                                        //isExpanded: true,
                                        hint: Text("Pilih kondisi"),
                                        items: snapshot.data
                                            .map((LookupModel _listOfLookup) =>
                                                DropdownMenuItem(
                                                  value:
                                                      _listOfLookup.lookupvalue,
                                                  child: Text(
                                                      _listOfLookup.lookupdesc),
                                                ))
                                            .toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            _currentValueCondition = newValue;
                                          });
                                        });
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
              new TextFormField(
                  controller: qtyController,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    labelText: "Jumlah",
                    labelStyle: new TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w700),
                    prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 7.0),
                        child: new Icon(Icons.create)),
                  )),
              _isStatusNew
                  ? SizedBox(
                      width: 1,
                      child: Text(""),
                    )
                  : new TextFormField(
                      controller: noteController,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        labelText: "Catatan",
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
              Container(
                alignment: Alignment.center,
                child: new RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () {
                    //Navigator.pop(context,ProsesStockScreenTF);
                    if (_currentValueMaterial != null) {
                      if (_currentValueType != null) {
                        if (_currentValueStatus != null) {
                          if (!(qtyController.value.text
                                  .trim()
                                  .toString()
                                  .length >
                              0)) {
                            // print(balController.value.text.trim().toString().length);
                            Fluttertoast.showToast(
                                msg: "Jumlah belum diinput",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,

                                //backgroundColor: Colors.red,
                                textColor: Colors.red,
                                fontSize: 16.0,
                                timeInSecForIosWeb: 1);
                          } else {
                            bool _isDataKomplite = true;
                            if (_isStatusNew) {
                              _isDataKomplite = true;
                              _currentValueCondition = "1";
                              noteController.text = "-";
                            } else {
                              if (_currentValueCondition != null) {
                                if (!(noteController.value.text
                                        .trim()
                                        .toString()
                                        .length >
                                    0)) {
                                  _isDataKomplite = false;
                                  Fluttertoast.showToast(
                                      msg: "Catatan belum diinput",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      //backgroundColor: Colors.red,
                                      textColor: Colors.red,
                                      fontSize: 16.0,
                                      timeInSecForIosWeb: 1);
                                } 
                              } else {
                                _isDataKomplite = false;
                                Fluttertoast.showToast(
                                    msg: "Kondisi belum dipilih",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,

                                    //backgroundColor: Colors.red,
                                    textColor: Colors.red,
                                    fontSize: 16.0,
                                    timeInSecForIosWeb: 1);
                              }
                            }
                            if (_isDataKomplite) {
                              //--- proses simpan
                              _cekDataPOSMMaterial(
                                      widget.customerno,
                                      widget.tglkunjungan,
                                      widget.userid,
                                      _currentValueMaterial.toString(),
                                      _currentValueType.toString())
                                  .then((val) => setState(() {
                                        if (val > 0) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Material dan tipe sudah tersimpan",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              backgroundColor:
                                                  Color(0xff0096ff),
                                              //textColor: Color(0xff0096ff),
                                              fontSize: 27.0,
                                              timeInSecForIosWeb: 1);
                                        } else {
                                          if (widget.trx == "new") {
                                            _insertDataPOSM(
                                                widget.customerno,
                                                widget.tglkunjungan,
                                                widget.userid,
                                                _currentValueMaterial,
                                                _currentValueType,
                                                qtyController.value.text,
                                                _currentValueStatus,
                                                noteController.value.text
                                                    .replaceAll(
                                                        new RegExp(r"'"), '`'),
                                                _currentValueCondition);
                                            _updateVisitisEdit(
                                                widget.customerno,
                                                widget.tglkunjungan,
                                                widget.userid);
                                          } else {
                                            _updateDataPOSM(
                                                widget.trxIDEdit,
                                                _currentValueMaterial,
                                                _currentValueType,
                                                qtyController.value.text,
                                                _currentValueStatus,
                                                noteController.value.text
                                                    .replaceAll(
                                                        new RegExp(r"'"), '`'),
                                                _currentValueCondition);
                                            _updateVisitisEdit(
                                                widget.customerno,
                                                widget.tglkunjungan,
                                                widget.userid);
                                          }

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
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Status belum dipilih",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,

                              //backgroundColor: Colors.red,
                              textColor: Colors.red,
                              fontSize: 16.0,
                              timeInSecForIosWeb: 1);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Tipe belum dipilih",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,

                            //backgroundColor: Colors.red,
                            textColor: Colors.red,
                            fontSize: 16.0,
                            timeInSecForIosWeb: 1);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Material belum dipilih",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          //backgroundColor: Colors.red,
                          textColor: Colors.red,
                          fontSize: 16.0,
                          timeInSecForIosWeb: 1);
                    }
                  },
                  child: new Text(
                    "Simpan",
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                  color: warnaBackground,
                  textColor: Colors.white,
                  elevation: 5.0,
                  // padding: EdgeInsets.only(
                  //     left: 80.0, right: 80.0, top: 15.0, bottom: 15.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _updateDataPOSM(trxid, materialid, type, qty, status, note, condition) async {
    Database db = await _dbprovider.database;
    await db.rawInsert("Update posmtf set materialid ='" +
        materialid.toString() +
        "',type ='" +
        type.toString() +
        "',qty =" +
        qty +
        ",status ='" +
        status.toString() +
        "',note ='" +
        note.toString() +
        "',condition = '" +
        condition.toString() +
        "',getidposmdetail ='-1' where posmtrxid = " +
        trxid.toString());
  }

  _updateVisitisEdit(customerno, tglkunjungan, userid) async {
    Database db = await _dbprovider.database;
    await db.rawInsert(
        "Update visittf set iseditposm ='Y' where customerno = '" +
            customerno.toString() +
            "' and tglkunjungan ='" +
            tglkunjungan +
            "' and userid ='" +
            userid +
            "'");
  }

  _insertDataPOSM(customerno, tglkunjungan, userid, materialid, type, qty,
      status, note, condition) async {
    Database db = await _dbprovider.database;
    await db.rawInsert(
        "INSERT INTO posmtf(customerno,userid,tglkunjungan,materialid,type,qty,status,note,condition,getidposmdetail) VALUES('" +
            customerno.toString() +
            "','" +
            userid.toString() +
            "','" +
            tglkunjungan.toString() +
            "','" +
            materialid.toString() +
            "','" +
            type.toString() +
            "'," +
            qty +
            ",'" +
            status +
            "','" +
            note +
            "','" +
            condition +
            "','-1' )");
  }

  //- cek apakah  material sudah ada penjualan
  _cekDataPOSMMaterial(
      customerno, tglkunjungan, userid, materialid, type) async {
    Database db = await _dbprovider.database;
    String strSQL;
    strSQL = "SELECT COUNT(customerno)  FROM posmtf where customerno = '" +
        customerno +
        "' and tglkunjungan ='" +
        tglkunjungan +
        "' and userid ='" +
        userid +
        "' and materialid ='" +
        materialid +
        "' and type ='" +
        type +
        "'";
    if (widget.trx == "edit") {
      strSQL = strSQL + " and posmtrxid <>" + widget.trxIDEdit.toString();
    }
//print(strSQL);
    int count = Sqflite.firstIntValue(await db.rawQuery(strSQL));
    //print(count);
    return count;
  }
}
