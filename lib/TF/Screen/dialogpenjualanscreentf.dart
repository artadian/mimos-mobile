import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Constant/listmenu.dart';
import 'package:mimos/TF/Dao/lookupdao.dart';
import 'package:mimos/TF/Screen/visitingscreentf.dart';
import 'package:mimos/db/database.dart';
import 'package:mimos/TF/Model/lookupmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimos/TF/Screen/penjualanscreentf.dart';

class DialogPenjualanScreenTF extends StatefulWidget {
  final String customerno;
  final String customername;
  final String tglkunjungan;
  final String priceid;
  final String alamat;
  final String userid;
  DialogPenjualanScreenTF(
      {Key key,
      this.customerno,
      this.customername,
      this.tglkunjungan,
      this.priceid,
      this.alamat,
      this.userid})
      : super(key: key);
  @override
  _DialogPenjualanScreenTFState createState() =>
      _DialogPenjualanScreenTFState();
}

class _DialogPenjualanScreenTFState extends State<DialogPenjualanScreenTF> {
  goToParent() {
    var root = MaterialPageRoute(
        builder: (context) => new VisitingScreenTF(
              customerno: widget.customerno.toString(),
              customername: widget.customername.toString(),
              tglkunjungan: widget.tglkunjungan.toString(),
              userid: widget.userid.toString(),
              priceid: widget.priceid.toString(),
              alamat: widget.alamat.toString(),
            ));
    Navigator.pushReplacement(context, root);
  }

  DatabaseProvider _dbprovider = DatabaseProvider();
  List<ListItemDDL> _listDDLVisit = <ListItemDDL>[
    ListItemDDL(textDDL: 'Ya', valueDDL: '0'),
    ListItemDDL(textDDL: 'Tidak', valueDDL: '1')
  ];
  //LookupBloc _lookupBloc = LookupBloc();
  LookupDao _lookupDao = LookupDao();
  //--- get data loopup
  String _currentValue;
  String _currentValueLookup;
  bool _isDropdownVisible = false;
  @override
  void initState() {
    super.initState();
    // _currentValue = _dropDownItems[0].value;
    _currentValue = _listDDLVisit[0].valueDDL;
    //_currentText = _listDDLVisit[0].textDDL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF54C5F8),
        title: Text(widget.customername),
        leading: new Container(),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: () {
                goToParent();
              })
        ],
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [MyPalette.ijoMimos, MyPalette.ijoMimos],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight))),
      ),
      body: SingleChildScrollView(
        child: new Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Text(widget.alamat,
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(height: 5),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: Text("ID", style: new TextStyle(fontSize: 17)),
                    ),
                    SizedBox(width: 10),
                    new Expanded(
                        child: new Text(
                            widget.customerno + " [" + widget.priceid + "]",
                            style: new TextStyle(fontSize: 17)))
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: Text("Tanggal",
                          style: new TextStyle(
                              fontSize: 17, fontWeight: FontWeight.normal)),
                    ),
                    SizedBox(width: 10),
                    new Expanded(
                        child: new Text(widget.tglkunjungan,
                            style: new TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)))
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: Text("Membeli ?",
                          style: new TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 10),
                    //Text(_currentValue),
                    new Expanded(
                        child: new DropdownButton<String>(
                            value: _currentValue,
                            // items: _dropDownItems,
                            hint: Text("Select to Do",
                                style: TextStyle(color: Colors.black)),
                            items: _listDDLVisit.map((ListItemDDL _ddlitems) {
                              return new DropdownMenuItem(
                                  value: _ddlitems.valueDDL,
                                  child: new Text(_ddlitems.textDDL));
                            }).toList(),
                            onChanged: (_newvalue) => setState(() {
                                  _currentValue = _newvalue;
                                  if (_newvalue == '0') {
                                    _isDropdownVisible = false;
                                  } else {
                                    _isDropdownVisible = true;
                                  }
                                })))
                  ],
                ),
                new Row(
                  children: <Widget>[
                    SizedBox(width: 90),
                    _isDropdownVisible
                        ? new Expanded(
                            child: new FutureBuilder(
                                future: _lookupDao.getSelectLookup(
                                    query: "not_buy_reason"),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<LookupModel>> snapshot) {
                                  if (!snapshot.hasData)
                                    return CircularProgressIndicator();
                                  return DropdownButton<String>(
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                      value: _currentValueLookup,
                                      hint: Text("Pilih alasan"),
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
                                          _currentValueLookup = newValue;
                                        });
                                      });
                                }))
                        : SizedBox(
                            height: 9.0,
                          ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    SizedBox(width: 45),
                    new Expanded(
                      child: new RaisedButton(
                          child: const Text("BATAL"),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () {
                            goToParent();
                          }),
                    ),
                    SizedBox(width: 45),
                    new Expanded(
                      child: new RaisedButton(
                          child: const Text("SIMPAN"),
                          color: Colors.green,
                          elevation: 5.0,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () {
                            if (_currentValue == "0") {
                              _updateDataVisit(
                                  widget.customerno,
                                  widget.tglkunjungan,
                                  widget.userid,
                                  _currentValue);
                              Fluttertoast.showToast(
                                  msg: "Status membeli sukses tersimpan",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  //backgroundColor: Colors.red,
                                  textColor: Colors.green,
                                  fontSize: 16.0,
                                  timeInSecForIos: 3);

                              /// open screen penjualan
                              var root = MaterialPageRoute(
                                  builder: (context) => new PenjualanScreenTF(
                                        customerno:
                                            widget.customerno.toString(),
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
                              if (_currentValueLookup != null) {
                                _updateDataVisit(
                                    widget.customerno,
                                    widget.tglkunjungan,
                                    widget.userid,
                                    _currentValueLookup);
                                Fluttertoast.showToast(
                                    msg: "Status tdk membeli sukses tersimpan",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    textColor: Colors.green,
                                    fontSize: 16.0,
                                    timeInSecForIos: 3);
                                goToParent();
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Select Reason Not Visit",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    textColor: Colors.red,
                                    fontSize: 16.0,
                                    timeInSecForIos: 1);
                              }
                            }
                          }),
                    ),
                    SizedBox(width: 45),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _updateDataVisit(String customerno, String tglkunjungan, String userid,
      String notvisitreason) async {
    Database db = await _dbprovider.database;
    print(notvisitreason);
    int result = await db.rawInsert("UPDATE  visittf set notbuyreason = '" +
        notvisitreason +
        "' where customerno ='" +
        customerno.toString() +
        "' and tglkunjungan ='" +
        tglkunjungan.toString() +
        "' and userid ='" +
        userid.toString() +
        "'");
    return result;
  }
}
