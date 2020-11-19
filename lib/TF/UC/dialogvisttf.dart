import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Constant/listmenu.dart';
import 'package:mimos/TF/Bloc/lookupbloc.dart';
import 'package:mimos/TF/Dao/lookupdao.dart';
import 'package:mimos/TF/Screen/visitingscreentf.dart';
import 'package:mimos/db/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mimos/TF/Model/lookupmodel.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DialogVisitTF extends StatefulWidget {
  final String customerno;
  final String customername;
  final String tglkunjungan;
  final String priceid;
  DialogVisitTF(
      {Key key, this.customerno, this.customername, this.tglkunjungan,this.priceid})
      : super(key: key);
  @override
  _DialogVisitTFState createState() => _DialogVisitTFState();
}

class _DialogVisitTFState extends State<DialogVisitTF> {
  DatabaseProvider _dbprovider = DatabaseProvider();
  List<ListItemDDL> _listDDLVisit = <ListItemDDL>[
    ListItemDDL(textDDL: 'Yes', valueDDL: '1'),
    ListItemDDL(textDDL: 'No', valueDDL: '0')
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
  void dispose() {
    _lookupBloc.dispose();
    //_lookupDao.clo;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [warnaAwalGradien, warnaAkhirGradien],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text("Customer "),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      content: new Container(
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  new Expanded(
                    child: Text(widget.customerno+ " [" + widget.priceid + "]",
                        style: new TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 10),
                  new Expanded(
                      child: new Text(widget.customername,
                          style: new TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)))
                ],
              ),
              Row(
                children: <Widget>[
                  new Expanded(
                    child: Text("Date",
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
              Row(
                children: <Widget>[
                  new Expanded(
                    child: Text("Visit",
                        style: new TextStyle(
                            fontSize: 17, fontWeight: FontWeight.normal)),
                  ),
                  SizedBox(width: 10),
                  //Text(_currentValue),
                  new Expanded(
                      child: new DropdownButton<String>(
                          value: _currentValue,
                          // items: _dropDownItems,
                          hint: Text("Select to Do",
                              style: TextStyle(color: Colors.black)),
                          // isDense: true,
                          // isExpanded: false,
                          items: _listDDLVisit.map((ListItemDDL _ddlitems) {
                            return new DropdownMenuItem(
                                value: _ddlitems.valueDDL,
                                child: new Text(_ddlitems.textDDL));
                          }).toList(),
                          onChanged: (_newvalue) => setState(() {
                                _currentValue = _newvalue;
                                // _currentText = newvalue;
                                //print(_newvalue);
                              })))
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 30),
                  new Expanded(
                      child: new FutureBuilder(
                          future: _lookupDao.getSelectLookup(
                              query: "not_visit_reason"),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<LookupModel>> snapshot) {
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();
                            return DropdownButton<String>(
                                value: _currentValueLookup,
                                // isExpanded: false,
                                hint: Text("Select Reason Not Visit"),
                                items: snapshot.data
                                    .map((LookupModel _listOfLookup) =>
                                        DropdownMenuItem(
                                          value: _listOfLookup.lookupvalue,
                                          child: Text(_listOfLookup.lookupdesc),
                                        ))
                                    .toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _currentValueLookup = newValue;
                                  });
                                });
                            // List<LookupModel> lookList = snapshot.data;
                            // if (lookList != null){
                            //   _currentValueLookup = lookList[0].lookupvalue;

                            //   return new DropdownButton(items: null, onChanged: null)
                            // }
                          })),
                ],
              ),
              // Row(
              //children: <Widget>[
              // new Expanded(
              //   child: Text("Reason",
              //       style: new TextStyle(
              //           fontSize: 17, fontWeight: FontWeight.normal)),
              // ),

              // new Expanded(
              //     child: new StreamBuilder(
              //         stream:
              //             //_lookupBloc.getLookup(query: "not_visit_reason"),
              //             _lookupBloc.lookup,
              //         builder: (BuildContext context,
              //             AsyncSnapshot<List<LookupModel>> snapshot) {
              //           List<LookupModel> _lookUpList = snapshot.data;
              //           if (snapshot.hasError) {
              //             return Text('Error : ${snapshot.error}');
              //             //return Text('Error ');
              //           }
              //           if (snapshot.hasData) {
              //             //_currentValueLookup =
              //            // _lookUpList[0].lookupvalue.toString();
              //             return new DropdownButton<String>(
              //                 value: _currentValueLookup,
              //                 hint: Text("Reason Not Visit"),
              //                 items: _lookUpList.map((LookupModel _lookup) {
              //                   return new DropdownMenuItem(
              //                     value: _lookup.lookupvalue.toString(),
              //                     child:
              //                         Text(_lookup.lookupdesc.toString()),
              //                   );
              //                 }).toList(),
              //                 onChanged: (_newvaluelookup) => setState(() {
              //                       //if (_currentValueLookup.isNotEmpty) {
              //                         _currentValueLookup = _newvaluelookup;
              //                       //}

              //                       print(_newvaluelookup);
              //                     }));
              //           }
              //         }))
              //],
              //),
            ],
          )),
      actions: <Widget>[
        FlatButton(
          child: new Text(
            "Cancel",
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: new Text("Save", style: TextStyle(fontSize: 18)),
          onPressed: () {
            //--
            if (_currentValue == "1") {
              //if (
             // insertDataVisit(widget.customerno, widget.tglkunjungan, _userID, "0");
              // >0) {
              Fluttertoast.showToast(
                  msg: "Save Visit Success",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  //backgroundColor: Colors.red,
                  textColor: Colors.green,
                  fontSize: 16.0,
                  timeInSecForIos: 3);

              /// open screen
              //Navigator.of(context).pushNamed(VisitingScreenTF(customerno:"widget.customerno",customername:"widget.customername",tglkunjungan:"widget.tglkunjungan",userid:"_userID"));
              // return (VisitingScreenTF(customerno: widget.customerno,customername: widget.customerno,tglkunjungan: widget.tglkunjungan,userid: _userID));
              var root = MaterialPageRoute(
                  builder: (context) => new VisitingScreenTF(
                        customerno: widget.customerno.toString(),
                        customername: widget.customername.toString(),
                        tglkunjungan: widget.tglkunjungan.toString(),
                        userid: _userID.toString(),
                        priceid: widget.priceid.toString(),
                      ));
              Navigator.pushReplacement(context, root);

              /// visiting
              //}
            } else {
              // print(_currentValueLookup.toString());
              if (_currentValueLookup != null) {
                insertDataVisit(widget.customerno, widget.tglkunjungan, _userID,
                    _currentValueLookup);

                Fluttertoast.showToast(
                    msg: "Save Not Visit Success",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    //backgroundColor: Colors.red,
                    textColor: Colors.green,
                    fontSize: 16.0,
                    timeInSecForIos: 3);

                /// open screen
                Navigator.of(context).pop(VISIT_SCREEN_TF);

                /// visiting

              } else {
                //print("lookup kosong");
                Fluttertoast.showToast(
                    msg: "Select Reason Not Visit",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    //backgroundColor: Colors.red,
                    textColor: Colors.red,
                    fontSize: 16.0,
                    timeInSecForIos: 1);
              }
            }
          },
        ),
      ],
    );
  }

  insertDataVisit(String customerno, String tglkunjungan, String userid,
      String notvisitreason) async {
    Database db = await _dbprovider.database;
    int result = await db.rawInsert(
        "INSERT INTO visittf(customerno,tglkunjungan,userid,notvisitreason) VALUES('" +
            customerno.toString() +
            "','" +
            tglkunjungan.toString() +
            "','" +
            userid.toString() +
            "','" +
            notvisitreason.toString() +
            "')");
    return result;
  }
}
