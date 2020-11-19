import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Screen/homescreen.dart';
//import 'package:mimos/Constant/listmenu.dart';
//import 'package:mimos/TF/Model/customermodeltf.dart';
import 'package:mimos/TF/Model/konsumenmodelsqllite.dart';
import 'package:mimos/TF/Bloc/kunjharinibloctf.dart';
import 'package:mimos/TF/Screen/dialogvisitscreentf.dart';
//import 'package:mimos/TF/UC/kartupenjualancustomer.dart';
import 'package:mimos/TF/UC/kartucustomer.dart';
import 'package:flutter/services.dart';
//import 'package:mimos/TF/Ui/dialogvisttf.dart';
//import 'dart:async';
import 'package:mimos/Screen/homescreen_old.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mimos/TF/Screen/visitingscreentf.dart';
//import 'package:mimos/db/database.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class VisitScreenTF extends StatefulWidget {
  @override
  _VisitScreenTFState createState() => _VisitScreenTFState();
}

class _VisitScreenTFState extends State<VisitScreenTF> {
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

  goToDialog(
      String customerno, customername, tglkunjungan, priceid, alamat, trx) {
    var root = MaterialPageRoute(
        builder: (context) => new DialogVisitScreenTF(
              customerno: customerno.toString(),
              customername: customername.toString(),
              tglkunjungan: tglkunjungan.toString(),
              priceid: priceid.toString(),
              alamat: alamat.toString(),
              trx: trx.toString(),
            ));
    Navigator.pushReplacement(context, root);
  }

  goToVisitingScreen(
      String customerno, customername, tglkunjungan, priceid, alamat, userid) {
    var root = MaterialPageRoute(
        builder: (context) => new VisitingScreenTF(
              customerno: customerno.toString(),
              customername: customername.toString(),
              tglkunjungan: tglkunjungan.toString(),
              priceid: priceid.toString(),
              alamat: alamat.toString(),
              userid: userid.toString(),
            ));
    Navigator.pushReplacement(context, root);
  }

  final KunjunganHariIniBlocTF _customerBloc = KunjunganHariIniBlocTF();
  Future<String> _getDataUserID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("userid") ?? "No UserID";
  }

  //final _dbProvider = DatabaseProvider.dbProvider;
  String _userID;
  @override
  void initState() {
    super.initState();
    _getDataUserID().then((val) => setState(() {
          _userID = val;
        }));
  }

  // List _cities = ["sby", "jkt", "bdg"];

  // List<DropdownMenuItem<String>> _getDDLItems() {
  //   List<DropdownMenuItem<String>> items = new List();
  //   for (String city in _cities) {
  //     items.add(new DropdownMenuItem<String>(
  //       value: city,
  //       child: new Text(city),
  //     ));
  //   }
  //   // print(items);
  //   return items;
  // }

  @override
  void dispose() {
    _customerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF54C5F8),
        title: Text("DAFTAR KUNJUNGAN"),
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
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [MyPalette.ijoMimos, MyPalette.ijoMimos],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight))),
      ),
      body: SafeArea(
          child: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
              child: Container(
                  //This is where the magic starts
                  // child: Text("List customer"),
                  child: getCustomerSWidget()))),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: Colors.grey, width: 0.3),
          )),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.blueAccent,
                    size: 28,
                  ),
                  onPressed: () {
                    //just re-pull UI for testing purposes
                    //_customerBloc.getCustomerS();
                    _customerBloc.getRingkasanPenjualanHariIniByNamaCust();
                  }),
              Expanded(
                child: Text(
                  "Refresh",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      //     fontFamily: 'RobotoMono',
                      fontStyle: FontStyle.normal,
                      fontSize: 19),
                ),
              ),
              Wrap(children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 28,
                    color: Colors.indigoAccent,
                  ),
                  onPressed: () {
                    _showCustomerSearchSheet(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                ),
              ])
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Padding(
      //   padding: EdgeInsets.only(bottom: 25),
      //   child: FloatingActionButton(
      //     elevation: 5.0,
      //     onPressed: () {
      //       _showAddCustomerSheet(context);
      //     },
      //     backgroundColor: Colors.white,
      //     child: Icon(
      //       Icons.add,
      //       size: 32,
      //       color: Colors.indigoAccent,
      //     ),
      //   ),
      // )
    );
  }

//  Future <void> _dialogVisitCall(
//       BuildContext context, customerno, customername, tglkunjungan,priceid)   {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           //return DialogVisit(customerno:customerno, customername:customername, tglkunjungan:tglkunjungan);
//           return DialogVisitTF(customerno:customerno, customername:customername, tglkunjungan:tglkunjungan,priceid: priceid,);
//         });
//   }
  //  void _showAddCustomerSheet(BuildContext context) {
  //   final _todoDescriptionFormController = TextEditingController();
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (builder) {
  //         return new Padding(
  //           padding: EdgeInsets.only(
  //               bottom: MediaQuery.of(context).viewInsets.bottom),
  //           child: new Container(
  //             color: Colors.transparent,
  //             child: new Container(
  //               height: 230,
  //               decoration: new BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: new BorderRadius.only(
  //                       topLeft: const Radius.circular(10.0),
  //                       topRight: const Radius.circular(10.0))),
  //               child: Padding(
  //                 padding: EdgeInsets.only(
  //                     left: 15, top: 25.0, right: 15, bottom: 30),
  //                 child: ListView(
  //                   children: <Widget>[
  //                     Row(
  //                       mainAxisSize: MainAxisSize.min,
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: <Widget>[
  //                         Expanded(
  //                           child: TextFormField(
  //                             controller: _todoDescriptionFormController,
  //                             textInputAction: TextInputAction.newline,
  //                             maxLines: 4,
  //                             style: TextStyle(
  //                                 fontSize: 21, fontWeight: FontWeight.w400),
  //                             autofocus: true,
  //                             decoration: const InputDecoration(
  //                                 hintText: 'I have to...',
  //                                 labelText: 'New Todo',
  //                                 labelStyle: TextStyle(
  //                                     color: Colors.indigoAccent,
  //                                     fontWeight: FontWeight.w500)),
  //                             validator: (String value) {
  //                               if (value.isEmpty) {
  //                                 return 'Empty description!';
  //                               }
  //                               return value.contains('')
  //                                   ? 'Do not use the @ char.'
  //                                   : null;
  //                             },
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: EdgeInsets.only(left: 5, top: 15),
  //                           child: CircleAvatar(
  //                             backgroundColor: Colors.indigoAccent,
  //                             radius: 18,
  //                             child: IconButton(
  //                               icon: Icon(
  //                                 Icons.save,
  //                                 size: 22,
  //                                 color: Colors.white,
  //                               ),
  //                               onPressed: () {
  //                                 // final newTodo = Customer(
  //                                 //     name:
  //                                 //         _todoDescriptionFormController
  //                                 //             .value.text);
  //                                 // if (newTodo.name.isNotEmpty) {
  //                                 //   /*Create new Todo object and make sure
  //                                 //   the Todo description is not empty,
  //                                 //   because what's the point of saving empty
  //                                 //   Todo
  //                                 //   */
  //                                 //   _customerBloc.addCustomer(newTodo);

  //                                 //   //dismisses the bottomsheet
  //                                 //   Navigator.pop(context);
  //                                 // }
  //                               },
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }

  void _showCustomerSearchSheet(BuildContext context) {
    final _todoSearchDescriptionFormController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: new Container(
              color: Colors.transparent,
              child: new Container(
                height: 230,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _todoSearchDescriptionFormController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: 'berdasarkan nama konsumen',
                                labelText: 'Cari Konsumen',
                                labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                              validator: (String value) {
                                return value.contains("'")
                                    ? "tidak boleh menggunakan tanda petik (')"
                                    : null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              radius: 18,
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  /*This will get all todos
                                  that contains similar string
                                  in the textform
                                  */
                                  // _customerBloc.getCustomerS(
                                  //     query:
                                  //         _todoSearchDescriptionFormController
                                  //             .value.text);
                                  _customerBloc
                                      .getRingkasanPenjualanHariIniByNamaCust(
                                          query:
                                              _todoSearchDescriptionFormController
                                                  .value.text);
                                  //dismisses the bottomsheet
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget getCustomerSWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (todos)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      //stream: _customerBloc.customerS,
      stream: _customerBloc.ringkasanPenjualanHariIni,
      builder: (BuildContext context,
          AsyncSnapshot<List<KonsumenModelSQLite>> snapshot) {
        return getCustomerCardWidget(snapshot, context);
      },
    );
  }

  Widget getCustomerCardWidget(
      AsyncSnapshot<List<KonsumenModelSQLite>> snapshot, context) {
    /*Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator*/
    if (snapshot.hasData) {
      /*Also handles whenever there's stream
      but returned returned 0 records of Todo from DB.
      If that the case show user that you have empty Todos
      */
      return snapshot.data.length != 0
          ? ListView.builder(
              // print(snapshot.data.length.toString()),
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemPosition) {
                KonsumenModelSQLite _customer = snapshot.data[itemPosition];
                // hijau ada penjualan
                //biru belum transakasi visit
                // merah dikunjungi tapi gagal dengan ada reason
                // orange dikunjungi tetapi tidak beli
                //---- ini udah bisa
                // print(_customer.visittrxid.toString());
                Color _warna = Colors.blueAccent;
                _customer.visittrxid == "null"
                    ? _warna = Colors.blueAccent
                    : _customer.lookupdescvisitreason != "null"
                        ? _warna = Colors.red
                        : _customer.lookupdescbuyreason != "null"
                            ? _warna = Colors.orange
                            : _customer.notbuyreason == "-1"
                                ? _warna = Colors.orange
                                : _warna = Colors.green;
                // : _warna = Colors.green;
                Color _warnaWsp = Colors.transparent;
                _customer.wspclass == "G"
                    ? _warnaWsp = Colors.amber
                    : _customer.wspclass == "S"
                        ? _warnaWsp = Colors.grey
                        : _customer.wspclass == "B"
                            ? _warnaWsp = Colors.brown
                            : _warnaWsp = Colors.transparent;
                return InkWell(
                  splashColor: Colors.blueAccent,
                  onTap: () {
                    // goToDialog(_customer.customerno, _customer.name,
                    //     _customer.tanggalkunjungan, _customer.priceid,_customer.address);
                    nextScreen(
                        _customer.customerno,
                        _customer.name,
                        _customer.tanggalkunjungan,
                        _customer.priceid,
                        _customer.address,
                        _userID,
                        _customer.visittrxid.toString(),
                        _customer.lookupdescvisitreason.toString());
                  },
                  //child: new KartuPenjualanCustomer(
                  child: new KartuCustomer(
                      namacustomer: _customer.name,
                      kodecustomer:
                          _customer.customerno + " [" + _customer.priceid + "]",
                      alamatcustomer: _customer.address.length > 30
                          ? _customer.address.substring(0, 26) + "..."
                          : _customer.address,
                      kotacustomer: _customer.city,
                      //logo: Icons.perm_contact_calendar,
                      // logo: Icon(Icons.perm_contact_calendar,size:45,color: MyPalette.ijoMimos,),
                      logo: Icon(
                        Icons.perm_contact_calendar,
                        size: 45,
                        color: _warna,
                      ),
                      tglkunjungan: _customer.tanggalkunjungan,
                      // penjualan: "Rp.999.999",
                      // datanota: "Nota : ",
                      lambangaksi: IconButton(
                          icon: Icon(Icons.store, color: _warnaWsp),
                          onPressed: () {
                            nextScreen(
                                _customer.customerno,
                                _customer.name,
                                _customer.tanggalkunjungan,
                                _customer.priceid,
                                _customer.address,
                                _userID,
                                _customer.visittrxid.toString(),
                                _customer.lookupdescvisitreason.toString());
                            // goToDialog(_customer.customerno, _customer.name,
                            // _customer.tanggalkunjungan, _customer.priceid,_customer.address);
                          })
                      //Icon(Icons.local_grocery_store, color: _warna)
                      ),
                );
                // final Widget dismissibleCard = new Dismissible(
                //   background: Container(
                //     child: Padding(
                //       padding: EdgeInsets.only(left: 10),
                //       child: Align(
                //         alignment: Alignment.centerLeft,
                //         child: Text(
                //           "Deleting",
                //           style: TextStyle(color: Colors.white),
                //         ),
                //       ),
                //     ),
                //     color: Colors.redAccent,
                //   ),
                //   onDismissed: (direction) {
                //     /*The magic
                //     delete Todo item by ID whenever
                //     the card is dismissed
                //     */
                //     _customerBloc.deleteTodoByCustomerNo(_customer.customerno);
                //   },
                //   direction: _dismissDirection,
                //   key: new ObjectKey(_customer),
                //   child: Card(
                //       shape: RoundedRectangleBorder(
                //         side: BorderSide(color: Colors.grey[200], width: 0.5),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       color: Colors.white,
                //       child: ListTile(
                //         leading: InkWell(
                //           onTap: () {
                //             //Reverse the value
                //             // todo.isDone = !todo.isDone;
                //             /*
                //             Another magic.
                //             This will update Todo isDone with either
                //             completed or not
                //           */
                //             _customerBloc.updateCustomer(_customer);
                //           },
                //           child: Container(
                //             decoration: BoxDecoration(),
                //             child: Padding(
                //               padding: const EdgeInsets.all(15.0),
                //               child: Icon(
                //                 Icons.done,
                //                 size: 26.0,
                //                 color: Colors.indigoAccent,
                //               ),
                //               // child: todo.isDone
                //               //     ? Icon(
                //               //         Icons.done,
                //               //         size: 26.0,
                //               //         color: Colors.indigoAccent,
                //               //       )
                //               //     : Icon(
                //               //         Icons.check_box_outline_blank,
                //               //         size: 26.0,
                //               //         color: Colors.tealAccent,
                //               //       ),
                //             ),
                //           ),
                //         ),
                //         title: Text(

                //           _customer.name,
                //           style: TextStyle(
                //             fontSize: 16.5,

                //             // fontFamily: 'RobotoMono',
                //             fontWeight: FontWeight.w500,
                //             // decoration: todo.isDone
                //             //     ? TextDecoration.lineThrough
                //             //     : TextDecoration.none
                //           ),
                //         ),

                //       )),
                // );
                // return dismissibleCard;
              },
            )
          : Container(
              child: Center(
              //this is used whenever there 0 Todo
              //in the data base
              child: noTodoMessageWidget(),
            ));
    } else {
      return Center(
        /*since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the use know the app is currently
        processing*/
        child: loadingData(),
      );
    }
  }

  Widget loadingData() {
    //pull todos again
    _customerBloc.getRingkasanPenjualanHariIniByNamaCust();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Proses...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget noTodoMessageWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Daftar kunjungan",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
          ),
          Text(
            "Tanggal  " +
                DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
          ),
          Text(
            "TIDAK ADA",
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w500, color: Colors.red),
          ),
          // Text(
          //   "Daftar kunjungan \ntanggal  " +
          //       DateFormat("yyyy-MM-dd").format(DateTime.now()).toString() +
          //       " \nTidak ada",
          //   style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
          // ),
        ],
      ),
    );
  }

  //- cek apakah  material sudah ada penjualan
//   _cekInputdialogPVisit(customerno, tglkunjungan, userid) async {
//     Database db = await _dbProvider.database;
//     String strSQL;
//     strSQL = "select count(customerno) from visittf v  where v.customerno = '" +
//         customerno +
//         "' and v.tglkunjungan ='" +
//         tglkunjungan +
//         "' and v.userid ='" +
//         userid +
//         "'";
// //print(strSQL);
//     int count = Sqflite.firstIntValue(await db.rawQuery(strSQL));
//     //print(count);
//     return count;
//   }

  void nextScreen(customerno, name, tanggalkunjungan, priceid, address, userid,
      trxid, reason) {
    if (trxid != "null") {
      if (reason != "null") {
        // bearti data tidak di kunjungi dengan ada raeson
        goToDialog(
            customerno, name, tanggalkunjungan, priceid, address, "edit");
      } else {
        goToVisitingScreen(
            customerno, name, tanggalkunjungan, priceid, address, userid);
      }
    } else {
      goToDialog(customerno, name, tanggalkunjungan, priceid, address, "new");
    }
    //   // diusahakan dari value listcustomer aja biar gak perlu koneksi lagi
    //   _cekInputdialogPVisit(customerno, tanggalkunjungan, userid).then((val) =>
    //       setState(() {
    //         //print(val);
    //         if (val > 0) {
    //           goToVisitingScreen(
    //               customerno, name, tanggalkunjungan, priceid, address, userid);
    //         } else {
    //           goToDialog(customerno, name, tanggalkunjungan, priceid, address);
    //         }
    //       }));
  }
}
