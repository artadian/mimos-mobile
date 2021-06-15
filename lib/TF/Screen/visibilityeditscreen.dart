import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/TF/Screen/visibilityscreen.dart';
import 'package:mimos/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VisibilityEditScreen extends StatefulWidget {
  final String customerno;
  final String customername;
  final String tglkunjungan;
  final String userid;
  final String priceid;
  final String stocktrxid;
  final String materialname;
  final String materialid;
  final String pac;
  final String alamat;
  VisibilityEditScreen(
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
      this.alamat})
      : super(key: key);
  @override
  _VisibilityEditScreenState createState() => _VisibilityEditScreenState();
}

class _VisibilityEditScreenState extends State<VisibilityEditScreen> {
  final _dbProvider = DatabaseProvider.dbProvider;
  TextEditingController balController = new TextEditingController();
  TextEditingController slofController = new TextEditingController();
  TextEditingController pacController = new TextEditingController();
  goToHome(
      String customerno, customername, tglkunjungan, userid, priceid, alamat) {
    var root = MaterialPageRoute(
        builder: (context) => new VisibilityScreen(
              customerno: customerno.toString(),
              customername: customername.toString(),
              tglkunjungan: tglkunjungan.toString(),
              userid: userid.toString(),
              priceid: priceid.toString(),
              alamat: alamat.toString(),
            ));
    Navigator.pushReplacement(context, root);
  }

  //int maxWSP;
  String _pac;
  // void getHarga(materialid) async {
  //   Database db = await _dbProvider.database;
  //   String strSQL;
  //   strSQL =
  //       "select p.pac as maxwsp from visibility_wsp p INNER JOIN materialtf m ON m.materialid = p.materialid INNER JOIN customer c ON c.wspclass = p.wspclass where p.materialid = '" +
  //           materialid +
  //           "' and c.customerno = '" +
  //           widget.customerno +
  //           "' and c.tanggalkunjungan = '" +
  //           widget.tglkunjungan +
  //           "' and c.userid = '" +
  //           widget.userid +
  //           "' Order By p.materialid Desc LIMIT 1 ";
  //   List<Map> result = await db.rawQuery(strSQL);
  //   var _maxwsp;
  //   if (result.isNotEmpty) {
  //     _maxwsp = result[0]['maxwsp'];
  //   } else {
  //     _maxwsp = 0;
  //   }

  //   setState(() {
  //     if (_maxwsp != null) {
  //       maxWSP = _maxwsp;
  //     } else {
  //       maxWSP = 0;
  //     }
  //   });
  //   //print(_harga);
  // }

  @override
  void initState() {
    super.initState();
    pacController = TextEditingController(text: widget.pac.toString());
   // getHarga(widget.materialid.toString());
    
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
            Text("Edit Cek Display"),
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
                // Text(
                //   "* Maksimal Qty " + maxWSP.toString() + " Pac",
                //   // style: TextStyle(
                //   //     fontSize: 18,
                //   //     color: Colors.black,
                //   //     ),
                //   textAlign: TextAlign.start,
                // ),
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
              if (!(pacController.value.text.trim().toString().length > 0)) {
                Fluttertoast.showToast(
                    msg: "Jumlah Pac belum diisi",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,

                    //backgroundColor: Colors.red,
                    textColor: Colors.red,
                    fontSize: 16.0,
                    timeInSecForIosWeb: 1);
              } else {
                // if ((int.parse(pacController.value.text)) > maxWSP) {
                //   Fluttertoast.showToast(
                //       msg: "Jumlah Pac melebihi maksimal",
                //       toastLength: Toast.LENGTH_SHORT,
                //       gravity: ToastGravity.CENTER,

                //       //backgroundColor: Colors.red,
                //       textColor: Colors.red,
                //       fontSize: 16.0,
                //       timeInSecForIosWeb: 1);
                // } else {
                  // int _totQty;
                  // _totQty = (int.parse(balController.value.text) * _bal2Pac) +
                  //     (int.parse(slofController.value.text) * _slof2Pac) +
                  //     (int.parse(pacController.value.text));
                  _updateDataStock(
                      widget.stocktrxid,
                      pacController.value.text,                     
                      );
                  _updateVisitisEdit(
                      widget.customerno, widget.tglkunjungan, widget.userid);
                  goToHome(
                      widget.customerno,
                      widget.customername,
                      widget.tglkunjungan,
                      widget.userid,
                      widget.priceid,
                      widget.alamat);
                //}
              }
            }),
      ],
    );
  }
  _updateVisitisEdit(customerno,tglkunjungan,userid) async {
    Database db = await _dbProvider.database;
     await db.rawInsert("Update visittf   set iseditvisibility ='Y' where customerno = '" +
        customerno.toString()+ "' and tglkunjungan ='"+ tglkunjungan.toString() +"' and userid ='"+ userid.toString() +"' ");
  }
  _updateDataStock(trxid, pac) async {
    Database db = await _dbProvider.database;
    //print(trxid);
    await db.rawDelete("UPDATE visibility set pac =" +
        pac +      
        ", iscek='Y' Where visibilitytrxid = '" +
        trxid.toString() +
        "'");
  }

  @override
  void dispose() {
    super.dispose();
    pacController.dispose();
   
  }
}
