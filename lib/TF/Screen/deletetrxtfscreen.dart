import 'package:flutter/material.dart';
import 'package:mimos/TF/Screen/penjualanscreentf.dart';
import 'package:mimos/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimos/TF/Screen/stockscreentf.dart';
import 'package:mimos/TF/Screen/posmscreentf.dart';
import 'package:mimos/TF/Screen/visitingscreentf.dart';
import 'package:mimos/TF/Screen/visibilityscreen.dart';
class DeleteTrxTFScreen extends StatefulWidget {
  final String trx;
  final String customerno;
  final String customername;
  final String tglkunjungan;
  final String userid;
  final String priceid;
  final String trxid;
  final String materialname;
  final String materialid;
  final String kuantity;
  final String alamat;
  DeleteTrxTFScreen(
      {Key key,
      this.trx,
      this.customerno,
      this.customername,
      this.tglkunjungan,
      this.userid,
      this.priceid,
      this.trxid,
      this.materialname,
      this.materialid,
      this.kuantity,
      this.alamat})
      : super(key: key);
  @override
  _DeleteTrxTFScreenState createState() => _DeleteTrxTFScreenState();
}

class _DeleteTrxTFScreenState extends State<DeleteTrxTFScreen> {
  final _dbProvider = DatabaseProvider.dbProvider;
  goToHome(String customerno, customername, tglkunjungan, userid, priceid,
      alamat, trx) {
    switch (trx) {
      case "stock":
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
        break;
        case "visibility":
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
        break;
      case "posm":
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
        break;
      case "penjualan":
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
        break;
      default:
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
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                //colors: [warnaAwalGradien, warnaAkhirGradien],
                colors: [Colors.red[600], Colors.red[600]],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight),
                borderRadius: new BorderRadius.circular(10.0)),
        child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(widget.trx == "stock"?"Hapus Data Cek Stock" : widget.trx =="penjualan" ?"Hapus Data Penjualan" :widget.trx =="posm"? "Hapus Data POSM":widget.trx =="visibility"? "Hapus Data Cek Display":"Delete Data ?"),
              Text(""),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Expanded(
            child: Text(widget.materialname + " ( " + widget.kuantity + " )"),
          ),
         
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            child: const Text("BATAL"),
            onPressed: () {
               goToHome(widget.customerno, widget.customername,
                    widget.tglkunjungan, widget.userid, widget.priceid,widget.alamat,widget.trx);
            }),
        new FlatButton(
            child: const Text('HAPUS'),
            onPressed: () {
                _deleteDataStock(widget.trxid,widget.trx);
                _updateVisitisEdit(widget.customerno,widget.tglkunjungan,widget.userid,widget.trx) ;
                goToHome(widget.customerno, widget.customername,
                    widget.tglkunjungan, widget.userid, widget.priceid,widget.alamat,widget.trx);
            }),
        
      ],
    );
  }
  _updateVisitisEdit(customerno,tglkunjungan,userid,trx) async {
    Database db = await _dbProvider.database;
    switch (trx) {
      case "stock":
       await db.rawInsert("Update visittf   set iseditstock ='Y' where customerno = '" +
        customerno.toString()+ "' and tglkunjungan ='"+ tglkunjungan.toString() +"' and userid ='"+ userid.toString() +"' ");
      break;
      case "visibility":
       await db.rawInsert("Update visittf   set iseditvisibility ='Y' where customerno = '" +
        customerno.toString()+ "' and tglkunjungan ='"+ tglkunjungan.toString() +"' and userid ='"+ userid.toString() +"' ");
      break;
      case "penjualan":
      await db.rawInsert("Update visittf   set iseditsellin ='Y' where customerno = '" +
        customerno.toString()+ "' and tglkunjungan ='"+ tglkunjungan.toString() +"' and userid ='"+ userid.toString() +"' ");
      break;
      case "posm":
      await db.rawInsert("Update visittf   set iseditposm ='Y' where customerno = '" +
        customerno.toString()+ "' and tglkunjungan ='"+ tglkunjungan.toString() +"' and userid ='"+ userid.toString() +"' ");
      break;
    }
    
  }

   _deleteDataStock(trxid,trx) async {
    Database db = await _dbProvider.database;
    switch (trx) {
      case "stock":
        await db.rawDelete(
        "DELETE FROM stocktf Where stocktrxid = '" + trxid.toString() + "'");
        break;
       case "visibility":
        await db.rawDelete(
        "DELETE FROM visibility Where visibilitytrxid = '" + trxid.toString() + "'");
        break;
      case "penjualan":
        await db.rawDelete(
        "DELETE FROM penjualan Where penjualantrxid = '" + trxid.toString() + "'");
        break;
      case "posm":
        await db.rawDelete(
        "DELETE FROM posmtf Where posmtrxid = '" + trxid.toString() + "'");
        break;
      default:
      // exexucte data yg tidak akan 
       await db.rawDelete(
        "DELETE FROM posmtf Where posmtrxid = '" + trxid.toString() + trx.toString()+ "'");
    }
    
  }
}
