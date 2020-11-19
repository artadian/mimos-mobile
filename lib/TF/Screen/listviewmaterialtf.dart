import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/TF/Model/materialmodeltf.dart';
import 'package:mimos/TF/Bloc/materialbloctf.dart';
import 'package:mimos/TF/UC/kartucustomer.dart';
import 'package:flutter/services.dart';

class ListViewMaterialTF extends StatelessWidget {
  final MaterialBlocTF _materialBloc = MaterialBlocTF();
  //final DismissDirection _dismissDirection = DismissDirection.horizontal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF54C5F8),
        title: Text("DATA ITEM BARANG"),
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
                  child: getMaterialWidget()))),
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
                    _materialBloc.getMaterialTF();
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
                    _showMaterialSearchSheet(context);
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
  

  void _showMaterialSearchSheet(BuildContext context) {
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
                                hintText: 'berdasarkan nama brg',
                                labelText: 'Cari Item Brg',
                                labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                              validator: (String value) {
                                return value.contains("'")
                                    ? "Tidak Boleh tanda petik (')"
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
                                  _materialBloc.getMaterialTF(
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

  Widget getMaterialWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (todos)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: _materialBloc.materialTF,
      builder: (BuildContext context, AsyncSnapshot<List<MaterialModelTF>> snapshot) {
        return getMaterialCardWidget(snapshot);
      },
    );
  }

  Widget getMaterialCardWidget(AsyncSnapshot<List<MaterialModelTF>> snapshot) {
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
                MaterialModelTF _material = snapshot.data[itemPosition];
                //---- ini udah bisa
                Color _warna = Colors.transparent;
                // _material.customerno != "3320000021"
                //     ? _warna = Colors.green
                //     : _warna = Colors.blueAccent;

                return new KartuCustomer(
                    namacustomer: _material.materialname,
                    kodecustomer: _material.materialid,
                    alamatcustomer: _material.pac.toString() + " / " + _material.slof.toString() + " / " + _material.bal.toString(),
                    kotacustomer: _material.materialgroupdescription,
                    logo: Icon(Icons.smoking_rooms,size:45,color: MyPalette.ijoMimos,),
                    tglkunjungan: _material.materialgroupid,
                    // lambangaksi:
                    //     Icon(Icons.local_grocery_store, color: _warna)
                         lambangaksi: IconButton(
                          icon: Icon(Icons.store, color: _warna),
                          onPressed: () {
                          })
                        );
               
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
    _materialBloc.getMaterialTF();
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

  Widget noTodoMessageWidget() {
    return Container(
      child: Text(
        "Material not found...",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }

  dispose() {
    /*close the stream in order
    to avoid memory leaks
    */

    _materialBloc.dispose();
  }
}
