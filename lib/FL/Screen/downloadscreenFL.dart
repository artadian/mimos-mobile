import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Constant/listmenu.dart';
import 'package:mimos/FL/Component/menucard.dart';
import 'package:mimos/FL/Dao/BrandCompetitorDao.dart';
import 'package:mimos/FL/Dao/MaterialFLDao.dart';
import 'package:mimos/Screen/homescreen.dart';
import 'package:mimos/Screen/homescreen_old.dart';
import 'package:mimos/TF/Dao/lookupdao.dart';
import 'package:mimos/TF/UC/kartumenu.dart';
import 'package:mimos/db/database.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DownloadScreenFL extends StatefulWidget {
  @override
  _DownloadScreenFLState createState() => _DownloadScreenFLState();
}

class _DownloadScreenFLState extends State<DownloadScreenFL> {
  SharedPreferences sharedPreferences;
  DatabaseProvider _dbprovider = DatabaseProvider();
  int _nDataLookup;
  int _nDataMaterialFL;
  int _nDataCompetitor;
  String salesofficeid;

  goToHome() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var root = MaterialPageRoute(
        builder: (context) => new HomeScreen(
              userName: sharedPreferences.getString("username").toString(),
              userId: sharedPreferences.getString("userid").toString(),
              userRoleID: sharedPreferences.getString("userroleid").toString(),
              roleName: sharedPreferences.getString("rolename").toString(),
              salesOfficeId:
                  sharedPreferences.getString("salesofficeid").toString(),
              salesOfficeName:
                  sharedPreferences.getString("salesofficename").toString(),
            ));
    Navigator.pushReplacement(context, root);
  }

  Future<String> _getSalesofficeid() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    salesofficeid = pref.getString("salesofficeid") ?? "No Salesofficeid";
    // print(salesofficeid);
    return salesofficeid;
  }

  LookupDao _lookupDao = LookupDao();
  _getDataLookup() {
    return _lookupDao.countDataLookup();
  }

  BrandCompetitorDao _brandCompetitorDao = BrandCompetitorDao();
  _getdatacompetitor() {
    return _brandCompetitorDao.countDataCompetitor();
  }

  MaterialFLDao _materialflDao = MaterialFLDao();
  _getDataMaterialFL() {
    return _materialflDao.countDataMaterial();
  }

  @override
  void initState() {
    super.initState();
    _getSalesofficeid();
    _getDataLookup().then((vallookup) => setState(() {
          _nDataLookup = vallookup;
        }));
    _getDataMaterialFL().then((valmaterial) => setState(() {
          _nDataMaterialFL = valmaterial;
        }));
    _getdatacompetitor().then((valcompetitor) => setState(() {
          _nDataCompetitor = valcompetitor;
        }));
    // print(salesofficeid);
  }

  var listItemDownload = listMenuItemDownload;

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr;
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Download,
      isDismissible: true,
    );
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () async {
              print(salesofficeid);
              pr.style(
                message: 'Downloading file...',
                // message:
                //     'Lets dump some huge text into the progress dialog and check whether it can handle the huge text. If it works then not you or me, flutter is awesome',
                borderRadius: 10.0,
                backgroundColor: Colors.white,
                elevation: 10.0,
                insetAnimCurve: Curves.easeInOut,
                progress: 0.0,
                progressWidgetAlignment: Alignment.center,
                maxProgress: 100.0,
                progressTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400),
                messageTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600),
              );
              await pr.show();
              Future.delayed(Duration(seconds: 2)).then((onvalue) {
                _downloadDataLookup();
                pr.update(
                  progress: 25,
                  message: "Downloading Master Lookup",
                  progressWidget: Container(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator()),
                  maxProgress: 100.0,
                  progressTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400),
                  messageTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 19.0,
                      fontWeight: FontWeight.w600),
                );

                Future.delayed(Duration(seconds: 2)).then((value) {
                  _downloadDataCompetitor(salesofficeid);
                  pr.update(
                      progress: 50, message: "Downloading Brand Competitor");
                  // print(percentage);
                  Future.delayed(Duration(seconds: 2)).then((value) {
                    _downloadDataMaterial(salesofficeid);
                    pr.update(progress: 75, message: "Downloading Material");
                    // print(percentage);

                    Future.delayed(Duration(seconds: 2)).then((value) {
                      _refreshtotaldata();
                      pr.update(progress: 90, message: "Calculating Data");
                      Future.delayed(Duration(seconds: 2)).then((value) {
                        pr.hide().whenComplete(() {
                          // print(pr.isShowing());
                        });
                        // percentage = 0.0;
                      });

                      // percentage = 0.0;
                    });
                  });
                });
              });
            },
            child: Icon(Icons.cloud_download),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("DOWNLOAD DATA"),
        leading: new Container(),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: () {
                goToHome();
              })
        ],
        // flexibleSpace: Container(
        //     decoration: BoxDecoration(
        //         gradient: LinearGradient(
        //             colors: [MyPalette.biru, MyPalette.ijoMimos],
        //             begin: FractionalOffset.topLeft,
        //             end: FractionalOffset.bottomRight))),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
            itemCount: listItemDownload == null ? 0 : listItemDownload.length,
            itemBuilder: (context, index) {
              int _nData = 0;

              if (listItemDownload[index].urut.toString() == "1") {
                //_nData = _getnCust();
                _nData = _nDataCompetitor;
              } else if (listItemDownload[index].urut.toString() == "2") {
                _nData = _nDataMaterialFL;
              } else if (listItemDownload[index].urut.toString() == "3") {
                _nData = _nDataLookup;
              }
              return new GestureDetector(
                  onTap: () {
                    // // Navigator.push(context,
                    // //     MaterialPageRoute(builder: (context) {
                    // if (listItemDownload[index].urut.toString() == "1") {
                    //   //Navigator.of(context).pushReplacementNamed(PROSES_DOWNLOAD_DATA_TF);
                    //   Navigator.of(context).pushNamed(LIST_VIEW_CUSTOMER_TF);
                    //   // return ListViewCustomer();
                    // } else if (listItemDownload[index].urut.toString() == "2") {
                    //   // return ListViewCustomer();
                    //   Navigator.of(context).pushNamed(LIST_VIEW_MATERIAL_TF);
                    // } else if (listItemDownload[index].urut.toString() == "3") {
                    //   // return ListViewCustomer();
                    //   Navigator.of(context).pushNamed(LIST_VIEW_PRICE_TF);
                    //   // } else if (listItemDownload[index].urut.toString() ==
                    //   //     "4") {
                    //   //  // return ListViewCustomer();
                    //   //   Navigator.of(context).pushReplacementNamed(PROSES_DOWNLOAD_DATA_TF);
                    // } else if (listItemDownload[index].urut.toString() == "6") {
                    //   // return ListViewCustomer();
                    //   Navigator.of(context).pushNamed(LIST_VIEW_INTRODEAL_TF);
                    // } else {
                    //   // return LogInScreen();
                    //   // Navigator.of(context).pushReplacementNamed(LOGIN_SCREEN);
                    // }
                    // // }));
                  },
                  child: new MenuCard(
                    judul: listItemDownload[index].judul,
                    logo: listItemDownload[index].lambang,
                    //ndata: listItemDownload[index].ndata,
                    ndata: _nData.toString() + " Data",
                    warna: Colors.blue,
                    // lambangaksi: Icons.list,
                    //urut: listItemDownload[index].urut,
                  ));
            },
          ))
        ],
      ),
    );
  }
  //=========== lookup

  _deleteAllDataLookup() async {
    Database db = await _dbprovider.database;
    var result = await db.rawDelete("DELETE FROM lookup ");
    return result;
  }

  _deleteAllDataMaterialFL() async {
    Database db = await _dbprovider.database;
    var result = await db.rawDelete("DELETE FROM materialfl ");
    return result;
  }

  _deleteAllDataBrandCompetitor() async {
    Database db = await _dbprovider.database;
    var result = await db.rawDelete("DELETE FROM competitor ");
    return result;
  }

  // download data lookup
  _downloadDataLookup() async {
    var apiResult = await http
        //.post("http://172.27.11.41/apimimos/index.php/api/Umum/lookup", body: data);
        .post(
      apiURL + "/Frontliner/lookup",
    );
    var jsonObject = json.decode(apiResult.body);
    var getDataApi = jsonObject['data'];
    // var xmgs = jsonObject['message'];
    // print(getDataApi);
    var xstatus = jsonObject['status'];
    if (xstatus) {
      _deleteAllDataLookup();
      for (var item in getDataApi) {
        Database db = await _dbprovider.database;
        await db.rawInsert(
            "INSERT INTO lookup(lookupid,lookupkey,lookupvalue,lookupdesc) VALUES(?,?,?,?)",
            [
              item['lookupid'],
              item['lookupkey'],
              item['lookupvalue'],
              item['lookupdesc']
            ]);
      }
    }
  }

  //=========== end lookup
  // download data material FL
  _downloadDataMaterial(String salesofficeid) async {
    Map data = {
      'salesofficeid': salesofficeid,
    };
    var apiResult = await http
        //.post("http://172.27.11.41/apimimos/index.php/api/Umum/lookup", body: data);
        .post(apiURL + "/Material/materialFL", body: data);
    var jsonObject = json.decode(apiResult.body);
    var getDataApi = jsonObject['data'];
    // var xmgs = jsonObject['message'];
    print(getDataApi);
    var xstatus = jsonObject['status'];
    if (xstatus) {
      _deleteAllDataMaterialFL();
      for (var item in getDataApi) {
        Database db = await _dbprovider.database;
        await db.rawInsert(
            "INSERT INTO materialfl(materialid,materialname,materialgroupid,materialgroupdescription,priceid,price) VALUES(?,?,?,?,?,?)",
            [
              item['materialid'],
              item['materialname'],
              item['materialgroupid'],
              item['materialgroupdescription'],
              item['priceid'],
              item['price']
            ]);
      }
    }
  }
  //=========== end material

  // download data Competitor
  _downloadDataCompetitor(String salesofficeid) async {
    Map data = {
      'salesofficeid': salesofficeid,
    };
    var apiResult = await http
        //.post("http://172.27.11.41/apimimos/index.php/api/Umum/lookup", body: data);
        .post(apiURL + "/Frontliner/brandcompetitor", body: data);
    var jsonObject = json.decode(apiResult.body);
    var getDataApi = jsonObject['data'];
    // var xmgs = jsonObject['message'];
    // print(getDataApi);
    var xstatus = jsonObject['status'];
    if (xstatus) {
      _deleteAllDataBrandCompetitor();
      for (var item in getDataApi) {
        Database db = await _dbprovider.database;
        await db.rawInsert(
            "INSERT INTO competitor(sobid,salesofficeid,materialgroupid,competitorbrand) VALUES(?,?,?,?)",
            [
              item['sobid'],
              item['salesofficeid'],
              item['materialgroupid'],
              item['competitorbrand']
            ]);
      }
    }
  }
  //=========== end competitor

  // == refresh data
  _refreshtotaldata() {
    _getDataLookup().then((vallookup) => setState(() {
          _nDataLookup = vallookup;
        }));
    _getDataMaterialFL().then((valmaterial) => setState(() {
          _nDataMaterialFL = valmaterial;
        }));
    _getdatacompetitor().then((valcompetitor) => setState(() {
          _nDataCompetitor = valcompetitor;
        }));
  }
  // == end refresh data
}

const List<ListItem> listMenuItemDownload = const <ListItem>[
  const ListItem(
      judul: 'Data Kompetitor',
      lambang: Icons.smoking_rooms,
      urut: '1',
      ndata: " data 0"),
  const ListItem(
      judul: 'Data Material',
      lambang: Icons.add_shopping_cart,
      urut: '2',
      ndata: ' data 0'),
  const ListItem(
      judul: 'Data Lookup', lambang: Icons.chat, urut: '3', ndata: ' data 0'),
];
