import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/TF/Screen/stockscreentf.dart';
import 'package:mimos/db/database.dart';
import 'package:sqflite/sqflite.dart';

class EditStockScreenTF extends StatefulWidget {
  final String customerno;
  final String customername;
  final String tglkunjungan;
  final String userid;
  final String priceid;
  final String stocktrxid;
  final String materialname;
  final String materialid;
  final String pac;
  final String slof;
  final String bal;
  final String alamat;
  EditStockScreenTF(
      {Key key,
      this.customerno,
      this.customername,
      this.tglkunjungan,
      this.userid,
      this.priceid,
      this.stocktrxid,
      this.materialname,
      this.materialid,
      this.pac,
      this.slof,
      this.bal,
      this.alamat})
      : super(key: key);
  @override
  _EditStockScreenTFState createState() => _EditStockScreenTFState();
}

class _EditStockScreenTFState extends State<EditStockScreenTF> {
  final _dbProvider = DatabaseProvider.dbProvider;
  TextEditingController balController = new TextEditingController();
  TextEditingController slofController = new TextEditingController();
  TextEditingController pacController = new TextEditingController();
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

  String _pac;
  int _bal2Pac;
  int _slof2Pac;

  void getHarga(materialid) async {
    Database db = await _dbProvider.database;
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
    pacController = TextEditingController(text: widget.pac.toString());
    slofController = TextEditingController(text: widget.slof.toString());
    balController = TextEditingController(text: widget.bal.toString());
    getHarga(widget.materialid.toString());
    //_pac = widget.pac;
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
                borderRadius: new BorderRadius.circular(15.0)
                ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text("Edit Cek Stock"),
            Text(widget.tglkunjungan),
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
              int _totQty;
              _totQty = (int.parse(balController.value.text) * _bal2Pac) +
                  (int.parse(slofController.value.text) * _slof2Pac) +
                  (int.parse(pacController.value.text));
              _updateDataStock(
                  widget.stocktrxid,
                  pacController.value.text,
                  slofController.value.text,
                  balController.value.text,
                  _totQty.toString());
                  _updateVisitisEdit(widget.customerno,widget.tglkunjungan,
                  widget.userid);
              goToHome(
                  widget.customerno,
                  widget.customername,
                  widget.tglkunjungan,
                  widget.userid,
                  widget.priceid,
                  widget.alamat);
            }),
      ],
    );
  }
_updateVisitisEdit(customerno,tglkunjungan,userid) async {
    Database db = await _dbProvider.database;
     await db.rawInsert("Update visittf   set iseditstock ='Y' where customerno = '" +
        customerno.toString()+ "' and tglkunjungan ='"+ tglkunjungan.toString() +"' and userid ='"+ userid.toString() +"' ");
  }
  _updateDataStock(trxid, pac, slof, bal, qty) async {
    Database db = await _dbProvider.database;
    await db.rawDelete("UPDATE stocktf set pac =" +
        pac +
        " , slof = " +
        slof +
        ", bal =" +
        bal +
        ", qtystock =" +
        qty +
        ",iscek='Y' Where stocktrxid = '" +
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
