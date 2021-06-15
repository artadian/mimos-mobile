import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/TF/Screen/Penjualanscreentf.dart';
import 'package:mimos/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';
class PenjualanEditScreenTF extends StatefulWidget {
  final String customerno;
  final String customername;
  final String tglkunjungan;
  final String userid;
  final String priceid;
  final String trxid;
  final String materialname;
  final String materialid;
  final String pac;
  final String slof;
  final String bal;
  final String alamat;
  PenjualanEditScreenTF(
      {Key key,
      this.customerno,
      this.customername,
      this.tglkunjungan,
      this.userid,
      this.priceid,
      this.trxid,
      this.materialname,
      this.materialid,
      this.pac,
      this.slof,
      this.bal,
      this.alamat})
      : super(key: key);
  @override
  _PenjualanEditScreenTFState createState() => _PenjualanEditScreenTFState();
}

class _PenjualanEditScreenTFState extends State<PenjualanEditScreenTF> {
  final _dbProvider = DatabaseProvider.dbProvider;
  TextEditingController balController = new TextEditingController();
  TextEditingController slofController = new TextEditingController();
  TextEditingController pacController = new TextEditingController();
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

  int _qtybonus;
  int _qtyorder;
  void getIntrodeal(materialid, since) async {
    Database db = await _dbProvider.database;
    String strSQL;
    strSQL = "select qtybonus,qtyorder from introdeal where materialid = '" +
        materialid +
        "' and since <=" +
        since +
        " Order By since Desc LIMIT 1 ";
    List<Map> result = await db.rawQuery(strSQL);
    var _xqtybonus;
    var _xqtyorder;
    if (result.isNotEmpty) {
      _xqtybonus = result[0]['qtybonus'];
      _xqtyorder = result[0]['qtyorder'];
    } else {
      _xqtybonus = 0;
      _xqtyorder = 0;
    }

    setState(() {
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
    });
  }

  int _bal2Pac;
  int _slof2Pac;
  void getHarga(materialid, since, priceid) async {
    Database db = await _dbProvider.database;
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
    //var _xHarga;
    var _xBal2Pac;
    var _xSlof2Pac;
    if (result.isNotEmpty) {
      // _xHarga = result[0]['harga'];
      _xBal2Pac = result[0]['bal2pac'];
      _xSlof2Pac = result[0]['slof2pac'];
    } else {
      //_xHarga =0;
      _xBal2Pac = 0;
      _xSlof2Pac = 0;
    }

    setState(() {
      // if (_xHarga != null) {
      //   _harga = _xHarga;
      // } else {
      //   _harga = 0;
      // }
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

  int _minQty;
  int _inStock;
  //int _inDisplay;
  int _stdMinimal;
  getQtyStock(materialid) async {
    Database db = await _dbProvider.database;
    String strSQL;
    //strSQL =
       // "select p.qtystock as stock from stocktf p INNER JOIN materialtf m ON m.materialid = p.materialid INNER JOIN customer c ON  c.tanggalkunjungan = p.tglkunjungan and c.customerno = p.customerno where p.materialid = '" +
          //  materialid +
          //  "' and c.customerno = '" +
          //  widget.customerno +
           // "' and c.tanggalkunjungan = '" +
           // widget.tglkunjungan +
            //"' and c.userid = '" +
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
    Database db2 = await _dbProvider.database;
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
      _minQty = _stdMinimal - _inStock;
      if (_minQty < 0) {
        _minQty = 0;
      }
      //--- end
    });

    //print("wsp " + _stdMinimal.toString());
  }

  String _pac;
  @override
  void initState() {
    super.initState();
    pacController = TextEditingController(text: widget.pac.toString());
    slofController = TextEditingController(text: widget.slof.toString());
    balController = TextEditingController(text: widget.bal.toString());
    getHarga(widget.materialid,
        widget.tglkunjungan.replaceAll(new RegExp(r'-'), ''), widget.priceid);
    getIntrodeal(widget.materialid,
        widget.tglkunjungan.replaceAll(new RegExp(r'-'), ''));
    //_pac = widget.pac;
    getQtyStock(widget.materialid);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                //colors: [warnaAwalGradien, warnaAkhirGradien],
                colors: [MyPalette.ijoMimos, Colors.white],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter),
            borderRadius: new BorderRadius.circular(15.0)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text("Edit Data Penjualan"),
            Text(widget.tglkunjungan),
            Text(widget.customername),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.materialname),
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
                initialValue: _pac,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: "Jumlah Pac",
                  labelStyle: new TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w700),
                  prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 7.0),
                      child: new Icon(Icons.create)),
                )),
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
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
            child: const Text("BATAL"),
            onPressed: () {
              goToHome(
                  widget.customerno,
                  widget.customername,
                  widget.tglkunjungan,
                  widget.userid,
                  widget.priceid,
                  widget.alamat);
            }),
        new FlatButton(
            child: const Text('SIMPAN'),
            onPressed: () {
              String _fixIntrodeal;
              int _totQty;
              _totQty = (int.parse(balController.value.text) * _bal2Pac) +
                  (int.parse(slofController.value.text) * _slof2Pac) +
                  (int.parse(pacController.value.text));
                      // bandingkan QTY Order dan MIN Order
                      if (_totQty < _minQty) {
Fluttertoast.showToast(
                                            msg: "Jumlah kurang dari Minimal Order",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,

                                            //backgroundColor: Colors.red,
                                            textColor: Colors.red,
                                            fontSize: 16.0,
                                            timeInSecForIosWeb: 1);
                      }else{
                        if (_qtybonus > 0) {
                if ((int.parse(balController.value.text) * _bal2Pac) +
                        (int.parse(slofController.value.text) * _slof2Pac) +
                        (int.parse(slofController.value.text)) >
                    _qtyorder) {
                  _fixIntrodeal = _qtybonus.toString();
                } else {
                  _fixIntrodeal = "0";
                }
              } else {
                _fixIntrodeal = "0";
              }
              _updateDataPenjualan(
                  widget.trxid,
                  pacController.value.text,
                  slofController.value.text,
                  balController.value.text,
                  _fixIntrodeal,
                  _totQty.toString());
              _updateVisitisEdit(
                  widget.customerno, widget.tglkunjungan, widget.userid);
              goToHome(
                  widget.customerno,
                  widget.customername,
                  widget.tglkunjungan,
                  widget.userid,
                  widget.priceid,
                  widget.alamat);
                      }
              
            }),
      ],
    );
  }

  _updateVisitisEdit(customerno, tglkunjungan, userid) async {
    Database db = await _dbProvider.database;
    await db.rawInsert(
        "Update visittf   set iseditsellin ='Y' where customerno = '" +
            customerno.toString() +
            "' and tglkunjungan ='" +
            tglkunjungan.toString() +
            "' and userid ='" +
            userid.toString() +
            "' ");
  }

  _updateDataPenjualan(trxid, pac, slof, bal, introdeal, qty) async {
    Database db = await _dbProvider.database;
    await db.rawDelete("UPDATE penjualan set pac =" +
        pac +
        " , slof = " +
        slof +
        ", bal =" +
        bal +
        ", introdeal =" +
        introdeal +
        ", qtypenjualan =" +
        qty +
        " , getidsellindetail = '-1' Where penjualantrxid = '" +
        trxid.toString() +
        "'");
  }

  @override
  void dispose() {
    super.dispose();
    pacController.dispose();
    slofController.dispose();
    balController.dispose();
  }
}
