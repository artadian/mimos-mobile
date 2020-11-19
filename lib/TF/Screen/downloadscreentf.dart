import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Screen/homescreen.dart';
import 'package:mimos/TF/Dao/introdealdaotf.dart';
import 'package:mimos/TF/Dao/materialdaotf.dart';
import 'package:mimos/TF/Dao/pricedaotf.dart';
import 'package:mimos/TF/UC/kartumenu.dart';
import 'package:mimos/Constant/listmenu.dart';
import 'package:mimos/TF/dao/customerdaotf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mimos/Screen/homescreen_old.dart';

class DownloadScreenTF extends StatefulWidget {
  @override
  _DownloadScreenTFState createState() => _DownloadScreenTFState();
}

class _DownloadScreenTFState extends State<DownloadScreenTF> {
  SharedPreferences sharedPreferences;
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
            ));
    Navigator.pushReplacement(context, root);
  }

  int _nDataCust;
  int _nDataMaterial;
  int _nDataHarga;
  // int _nDataUom;
  // int _nDataSloc;
  // int _nDataShipingPoint ;
  int _nDataIntrodeal;

//============== ok
  CustomerDaoTF _cunstomerDao = CustomerDaoTF();
  _getDataCustomer() {
    return _cunstomerDao.countData();

    /// format future <int>
  }

  MaterialDaoTF _materialDao = MaterialDaoTF();
  _getDataMaterialTF() {
    return _materialDao.countDataMaterialTF();
  }

  PriceDaoTF _priceDao = PriceDaoTF();
  _getDataPriceTF() {
    return _priceDao.countDataPriceTF();
  }

  IntrodealDaoTF _introdealDaoTF = IntrodealDaoTF();
  _getDataIntrodeal() {
    return _introdealDaoTF.countDataIntrodealTF();
  }
  //CustomerBloc _customerBloc = CustomerBloc();
//  _cariNCust() async {
//   final _xN = await _customerBloc.getJumlahDataCustomer();
//   // _xN format future <dynamic>
//   return _xN;
// }
// Future<int> _fetcn() async {
//     var snapshot = await _customerBloc.getJumlahDataCustomer().instance
//         .collection('data')
//         //.document(id)
//         .get();

//     return snapshot;
//   }

  @override
  void initState() {
    super.initState();
    _getDataCustomer().then((val) => setState(() {
          _nDataCust = val;
        }));
    _getDataMaterialTF().then((valM) => setState(() {
          _nDataMaterial = valM;
        }));

    _getDataPriceTF().then((valH) => setState(() {
          _nDataHarga = valH;
        }));

    _getDataIntrodeal().then((valI) => setState(() {
          _nDataIntrodeal = valI;
        }));
    //  _fetcn().then((val) => print("Id that was loaded: $val"));
// print("bloc " + _fetcn().toString());
// print("DAO " + _getDataCustomer().toString());
//          _fetcn().then((val) => setState((){
//           _nDataCust=val;
//         }) );
  }

  @override
  void dispose() {
    super.dispose();
    //_cunstomerDao.dispose();
  }
  //final CustomerBloc _customerBloc = CustomerBloc();

  // final _dbProvider = DatabaseProvider.dbProvider;
  // Future<int> _getCount() async {
  //   //database connection
  //   final db = await _dbProvider.database;
  //   // Database db = await this.database;
  //   var x = await db.rawQuery("SELECT COUNT (*) from customer");
  //   int count = Sqflite.firstIntValue(x);
  //   //print(count);
  //   return count;
  // }

//===========
// final List<ListItem> listItemDownload =[
//   ListItem(judul:'',lambang:Icons.people,urut: '1',ndata: '1' ),

// ];
  var listItemDownload = listMenuItemDownload;

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Colors.lightBlue,
            onPressed: () {
              // _dialogCall(context);
              //  Navigator.push(context,
              //           MaterialPageRoute(builder: (context) {
              //         return ProsesDownloadData();
              //       }));
              Navigator.of(context).pushNamed(PROSES_DOWNLOAD_DATA_TF);
            },
            child: Icon(Icons.cloud_download),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF54C5F8),
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
          //   IconButton(
          //     icon: new Icon(Icons.cloud_download),
          //      onPressed: () async {
          //   await _dialogCall(context);
          // },
          //     // onPressed: () {
          //     //   _prosesDownload(context);
          //     // },
          //   ),
        ],
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [MyPalette.ijoMimos, MyPalette.ijoMimos],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight))),
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
                _nData = _nDataCust;
              } else if (listItemDownload[index].urut.toString() == "2") {
                _nData = _nDataMaterial;
              } else if (listItemDownload[index].urut.toString() == "3") {
                _nData = _nDataHarga;
              } else if (listItemDownload[index].urut.toString() == "6") {
                _nData = _nDataIntrodeal;
              }
              return new GestureDetector(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    if (listItemDownload[index].urut.toString() == "1") {
                      //Navigator.of(context).pushReplacementNamed(PROSES_DOWNLOAD_DATA_TF);
                      Navigator.of(context).pushNamed(LIST_VIEW_CUSTOMER_TF);
                      // return ListViewCustomer();
                    } else if (listItemDownload[index].urut.toString() == "2") {
                      // return ListViewCustomer();
                      Navigator.of(context).pushNamed(LIST_VIEW_MATERIAL_TF);
                    } else if (listItemDownload[index].urut.toString() == "3") {
                      // return ListViewCustomer();
                      Navigator.of(context).pushNamed(LIST_VIEW_PRICE_TF);
                      // } else if (listItemDownload[index].urut.toString() ==
                      //     "4") {
                      //  // return ListViewCustomer();
                      //   Navigator.of(context).pushReplacementNamed(PROSES_DOWNLOAD_DATA_TF);
                    } else if (listItemDownload[index].urut.toString() == "6") {
                      // return ListViewCustomer();
                      Navigator.of(context).pushNamed(LIST_VIEW_INTRODEAL_TF);
                    } else {
                      // return LogInScreen();
                      Navigator.of(context).pushReplacementNamed(LOGIN_SCREEN);
                    }
                    // }));
                  },
                  child: new KartuMenu(
                    judul: listItemDownload[index].judul,
                    logo: listItemDownload[index].lambang,
                    //ndata: listItemDownload[index].ndata,
                    ndata: _nData.toString() + " Data",
                    // lambangaksi: Icons.list,
                    //urut: listItemDownload[index].urut,
                  ));
            },
          ))
        ],
      ),
    );
  }

  // Future<void> _dialogCall(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         //return MyDialog();
  //         return DialogDownloadData();
  //       });
  // }
}

//===========

const List<ListItem> listMenuItemDownload = const <ListItem>[
  const ListItem(
      judul: 'Data Kunjungan',
      lambang: Icons.people,
      urut: '1',
      ndata: " data 0"),
  const ListItem(
      judul: 'Data Item Barang',
      lambang: Icons.add_shopping_cart,
      urut: '2',
      ndata: ' data 0'),
  const ListItem(
      judul: 'Data Harga',
      lambang: Icons.attach_money,
      urut: '3',
      ndata: ' data 0'),
  //const ListItem(
  // judul: 'Uom', lambang: Icons.extension, urut: '4', ndata: ' data 0'),
  // const ListItem(
  //     judul: 'SLoc', lambang: Icons.store, urut: '5', ndata: ' data 0'),
  // const ListItem(
  //     judul: 'Shipping Point',
  //     lambang: Icons.local_shipping,
  //     urut: '5',
  //     ndata: ' data 0'),
  const ListItem(
      judul: 'Data Introdeal',
      lambang: Icons.chat,
      urut: '6',
      ndata: ' data 0'),
];
