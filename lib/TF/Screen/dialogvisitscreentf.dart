import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Constant/listmenu.dart';
import 'package:mimos/TF/Bloc/lookupbloc.dart';
import 'package:mimos/TF/Dao/lookupdao.dart';
import 'package:mimos/TF/Screen/visitingscreentf.dart';
import 'package:mimos/TF/Screen/listcustomervisitscreentf.dart';
import 'package:mimos/db/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mimos/TF/Model/lookupmodel.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:marquee/marquee.dart';

class DialogVisitScreenTF extends StatefulWidget {
  final String customerno;
  final String customername;
  final String tglkunjungan;
  final String priceid;
  final String alamat;
  final String trx;
  DialogVisitScreenTF(
      {Key key,
      this.customerno,
      this.customername,
      this.tglkunjungan,
      this.priceid,
      this.alamat,
      this.trx})
      : super(key: key);
  @override
  _DialogVisitScreenTFState createState() => _DialogVisitScreenTFState();
}

class _DialogVisitScreenTFState extends State<DialogVisitScreenTF> {
  goToParent() {
    var root = MaterialPageRoute(builder: (context) => new VisitScreenTF());
    Navigator.pushReplacement(context, root);
  }

  DatabaseProvider _dbprovider = DatabaseProvider();
  List<ListItemDDL> _listDDLVisit = <ListItemDDL>[
    ListItemDDL(textDDL: 'Ya', valueDDL: '0'),
    ListItemDDL(textDDL: 'Tidak', valueDDL: '1')
  ];
  LookupBloc _lookupBloc = LookupBloc();
  LookupDao _lookupDao = LookupDao();
  //--- get data loopup
  //-----
  String _currentValue;
  String _currentValueLookup;
  //LookupModel _currentValueLookupModel;

  Future<String> _getDataUserID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("userid") ?? "No UserID";
  }

  String _userID;
  bool _isDropdownVisible = false;
  @override
  void initState() {
    super.initState();
    _getDataUserID().then((val) => setState(() {
          _userID = val;
        }));
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
        leading: new Container(
            // child: Text("Customer"),
            ),
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
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        //padding: EdgeInsets.only(top: 10.0),
        child: Stack(
          children: [
            ListView(
              //padding: EdgeInsets.only(top: 10.0),
              children: [
                _buildComplexMarquee(),
              ].map(_wrapWithStuff).toList(),
            ),
            new ListView(
              children: <Widget>[
                Column(
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
                          child: Text("Dikunjungi ?",
                              style: new TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(width: 10),
                        //Text(_currentValue),
                        new Expanded(
                            child: new DropdownButton<String>(
                                style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                                value: _currentValue,
                                // items: _dropDownItems,
                                hint: Text("Select to Do",
                                    style: TextStyle(color: Colors.black)),
                                items:
                                    _listDDLVisit.map((ListItemDDL _ddlitems) {
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
                                        query: "not_visit_reason"),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<LookupModel>>
                                            snapshot) {
                                      if (!snapshot.hasData)
                                        return CircularProgressIndicator();
                                      return DropdownButton<String>(
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                          value: _currentValueLookup,
                                          //isExpanded: true,
                                          hint: Text("Pilih alasan"),
                                          items: snapshot.data
                                              .map(
                                                  (LookupModel _listOfLookup) =>
                                                      DropdownMenuItem(
                                                        value: _listOfLookup
                                                            .lookupvalue,
                                                        child: Text(
                                                            _listOfLookup
                                                                .lookupdesc),
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
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              onPressed: () {
                                // Navigator.of(context).pop(false);
                                //Navigator.of(context).pushNamed(DOWNLOAD_SCREEN_TF);
                                goToParent();
                              }),
                        ),
                        SizedBox(width: 45),
                        new Expanded(
                          child: new RaisedButton(
                              child: const Text("SIMPAN"),
                              //color: Color(0xFF54C5F8),
                              color: Colors.green,
                              //textColor: Colors.white,
                              elevation: 5.0,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              onPressed: () {
                                if (_currentValue == "0") {
                                  insertDataVisit(
                                      widget.customerno,
                                      widget.tglkunjungan,
                                      _userID,
                                      _currentValue);
                                  Fluttertoast.showToast(
                                      msg: "Status dikunjungi sukses tersimpan",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      //backgroundColor: Colors.red,
                                      textColor: Colors.green,
                                      fontSize: 16.0,
                                      timeInSecForIosWeb: 3);

                                  /// open screen
                                  //Navigator.of(context).pushNamed(VisitingScreenTF(customerno:"widget.customerno",customername:"widget.customername",tglkunjungan:"widget.tglkunjungan",userid:"_userID"));
                                  // return (VisitingScreenTF(customerno: widget.customerno,customername: widget.customerno,tglkunjungan: widget.tglkunjungan,userid: _userID));
                                  var root = MaterialPageRoute(
                                      builder: (context) =>
                                          new VisitingScreenTF(
                                            customerno:
                                                widget.customerno.toString(),
                                            customername:
                                                widget.customername.toString(),
                                            tglkunjungan:
                                                widget.tglkunjungan.toString(),
                                            userid: _userID.toString(),
                                            priceid: widget.priceid.toString(),
                                            alamat: widget.alamat.toString(),
                                          ));
                                  Navigator.pushReplacement(context, root);

                                  /// visiting
                                  //}
                                } else {
                                  // print(_currentValueLookup.toString());
                                  if (_currentValueLookup != null) {
                                    insertDataVisit(
                                        widget.customerno,
                                        widget.tglkunjungan,
                                        _userID,
                                        _currentValueLookup);

                                    Fluttertoast.showToast(
                                        msg: "Status tidak dikunjungi suskses tersimpan ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        //backgroundColor: Colors.red,
                                        textColor: Colors.green,
                                        fontSize: 16.0,
                                        timeInSecForIosWeb: 3);

                                    /// open screen
                                    // Navigator.of(context).pop(VISIT_SCREEN_TF);
                                    goToParent();

                                    /// visiting

                                  } else {
                                    //print("lookup kosong");
                                    Fluttertoast.showToast(
                                        msg: "Pilih alasan",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        //backgroundColor: Colors.red,
                                        textColor: Colors.red,
                                        fontSize: 16.0,
                                        timeInSecForIosWeb: 1);
                                  }
                                }
                              }),
                        ),
                        SizedBox(width: 45),
                      ],
                    ),
                    new Image.asset(
                      'assets/images/checklist_icon.png',
                      width: MediaQuery.of(context).size.height * 0.35,
                      height: MediaQuery.of(context).size.height * 0.35,
                    ),
                  ],
                )
              ],
            ),

            // _dataCustomer(),
            // _isiTransaksi(),
          ],
        ),
      ),
    );
  }

  Widget _wrapWithStuff(Widget child) {
    return Padding(
      //padding: EdgeInsets.all(16.0),
      padding: EdgeInsets.fromLTRB(
          5,
          MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.bottom -
              135,
          5,
          5),
      child: Container(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.bottom -
              56,
          color: Colors.white,
          child: child),
    );
  }

  Widget _buildComplexMarquee() {
    return Marquee(
      text: '  * Don`t Forget Six Steps            ',
      style: TextStyle(fontWeight: FontWeight.bold),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      // blankSpace: 10.0,
      velocity: 100.0,
      pauseAfterRound: Duration(seconds: 5),
      startPadding: 10.0,
      // accelerationDuration: Duration(seconds: 2),
      //accelerationCurve: Curves.linear,
      // decelerationDuration: Duration(milliseconds: 500),
      //decelerationCurve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _lookupBloc.dispose();
    //_lookupDao.clo;
    super.dispose();
  }

  insertDataVisit(String customerno, String tglkunjungan, String userid,
      String notvisitreason) async {
    Database db = await _dbprovider.database;
    var strSQL;
    if (widget.trx == "edit") {
      strSQL = "UPDATE visittf set notvisitreason ='" +
          notvisitreason.toString() +
          "' where customerno ='" +
          customerno.toString() +
          "' and tglkunjungan ='" +
          tglkunjungan.toString() +
          "' and userid = '" +
          userid.toString() +
          "' ";
    } else {
      strSQL =
          "INSERT INTO visittf(customerno,tglkunjungan,userid,notvisitreason,getidvisit,getidstock,getidposm,notbuyreason,nonota,getidsellin,getidvisibility) VALUES('" +
              customerno.toString() +
              "','" +
              tglkunjungan.toString() +
              "','" +
              userid.toString() +
              "','" +
              notvisitreason.toString() +
              "','-1','-1','-1','-1','-1','-1','-1')";
    }
    int result = await db.rawInsert(strSQL);
    return result;
  }
}
