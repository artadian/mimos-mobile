import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
//import 'package:mimos/TF/Model/customermodeltf.dart';
import 'package:mimos/TF/Bloc/customerbloctf.dart';
import 'package:mimos/TF/Model/konsumenmodelsqllite.dart';
import 'package:mimos/TF/UC/kartucustomer.dart';
import 'package:flutter/services.dart';
//import 'package:mimos/db/database.dart';

class ListViewCustomerTF extends StatelessWidget {
  final CustomerBlocTF _customerBloc = CustomerBlocTF();
  //final _dbProvider = DatabaseProvider.dbProvider;
  //final DismissDirection _dismissDirection = DismissDirection.horizontal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF54C5F8),
        title: Text("DATA KUNJUNGAN"),
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
              // RaisedButton.icon(
              //     onPressed: () {
              //       _customerBloc.getCustomerS();
              //     },
              //     icon: Icon(Icons.refresh,color: Colors.blueAccent),
              //     color: Colors.white,
              //     label: Text("Refresh")),

              IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.blueAccent,
                    size: 28,
                  ),
                  onPressed: () {
                    //just re-pull UI for testing purposes
                    _customerBloc.getCustomerS();
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
                )
              ])
            ],
          ),
        ),
      ),
    );
  }

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
                                hintText: 'berdasarkan nama',
                                labelText: 'Cari Konsumen',
                                labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                              validator: (String value) {
                                return value.contains("'")
                                    ? "tidak boleh tanda petik (')"
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
                                  _customerBloc.getCustomerS(
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

  //----- akses sqlite
  // Future<List<KonsumenModelSQLite>> _getAllCustomer() async {
  //   final db = await _dbProvider.database;
  //   List<Map<String, dynamic>> result;
  //   //result = await db.query("customer", columns: columns);
  //   result = await db.rawQuery(
  //       "select * from customer ORDER BY tanggalkunjungan ASC,name ASC");
  //   List<KonsumenModelSQLite> todos = result.isNotEmpty
  //       ? result
  //           .map((item) => KonsumenModelSQLite.createCustomerFromJson(item))
  //           .toList()
  //       : [];
  //   return todos;
  // }
  //-----

  Widget getCustomerSWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (todos)
    and construct the UI (with state) based on the stream
    */
    // return FutureBuilder(
    //     future: _getAllCustomer(),
    //     builder: (BuildContext context,
    //         AsyncSnapshot<List<KonsumenModelSQLite>> snapshot) {
    //       return getCustomerCardWidget(snapshot);
    //     });
    return StreamBuilder(
     stream: _customerBloc.customerS,
      builder: (BuildContext context,
          AsyncSnapshot<List<KonsumenModelSQLite>> snapshot) {
        return getCustomerCardWidget(snapshot);
      },
    );
  }

  Widget getCustomerCardWidget(
      AsyncSnapshot<List<KonsumenModelSQLite>> snapshot) {
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
                //---- ini udah bisa
                Color _warnaWsp = Colors.transparent;
                 _customer.wspclass == "G"
                     ? _warnaWsp = Colors.amber
                    :  _customer.wspclass == "S" ? _warnaWsp = Colors.grey : _customer.wspclass == "B" ? _warnaWsp = Colors.brown : _warnaWsp = Colors.transparent;
                return new KartuCustomer(
                    namacustomer: _customer.name + " " + _customer.userid,
                    kodecustomer:
                        _customer.customerno + " [" + _customer.priceid + "]",
                    alamatcustomer:_customer.address.length > 30 ? _customer.address.substring(0, 26) + " ..." :_customer.address,
                    // kotacustomer: _customer.city + " " + _customer.id.toString(),
                    kotacustomer: _customer.city,
                    //logo: Icons.perm_contact_calendar,
                    logo: Icon(Icons.perm_contact_calendar,size:45,color: MyPalette.ijoMimos,),
                    tglkunjungan: _customer.tanggalkunjungan,
                    // lambangaksi:
                    //     Icon(Icons.local_grocery_store, color: _warna)
                         lambangaksi: IconButton(
                          icon: Icon(Icons.store, color: _warnaWsp),
                          onPressed: () {
                          })
                        );
              },
            )
          : Container(
              child: Center(
              //this is used whenever there 0 Todo
              //in the data base
              child: noCustomerMessageWidget(),
              //child: Text("Data Customer not found"),
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
    _customerBloc.getCustomerS();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Loading...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget noCustomerMessageWidget() {
    return Container(
      child: Text(
        "Daftar tidak ada",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }

  dispose() {
    /*close the stream in order
    to avoid memory leaks
    */
    _customerBloc.dispose();
  }
}
