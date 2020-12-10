import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/FL/Dao/MaterialFLDao.dart';
import 'package:mimos/FL/Dao/lookupFLDao.dart';
import 'package:mimos/FL/Model/lookupModelFL.dart';
import 'package:mimos/FL/Model/materialModelFL.dart';
import 'package:mimos/db/database.dart';
import 'package:sqflite/sqflite.dart';

class TrialFormScreenFL extends StatefulWidget {
  @override
  _TrialFormScreenFLState createState() => _TrialFormScreenFLState();
}

class _TrialFormScreenFLState extends State<TrialFormScreenFL> {
  DatabaseProvider _dbprovider = DatabaseProvider();
  String _currentValueMaterial;
  String _currentValueType;
  String _currentValueBrandbefore;
  String _currentValueTaste;
  String _currentValuePackaging;
  String _currentValueKnowProduct;
  int _harga;
  int _total;
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  MaterialFLDao _materialDao = MaterialFLDao();
  LookupFLDao _lookupFLDao = LookupFLDao();
  final TextEditingController priceController = new TextEditingController();
  final TextEditingController locationController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController ageController = new TextEditingController();
  final TextEditingController qtyController =
      new TextEditingController(text: '0');
  final TextEditingController totalController = new TextEditingController();
  final TextEditingController outletnameController =
      new TextEditingController();
  final TextEditingController outletaddressontroller =
      new TextEditingController();
  final TextEditingController notesController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Trial"),
          backgroundColor: Colors.blue,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      // trial type
                      new ListTile(
                          title: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.perm_identity),
                          labelText: 'Type',
                        ),
                        child: new FutureBuilder(
                            future: _lookupFLDao.getSelectLookupType(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<LookupModelFL>> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    isDense: true,
                                    value: _currentValueType,
                                    // isExpanded: false,
                                    hint: Text("Select Type"),
                                    items: snapshot.data
                                        .map((LookupModelFL _listtracktype) =>
                                            DropdownMenuItem(
                                              value: _listtracktype.lookupvalue,
                                              child: Text(
                                                  _listtracktype.lookupdesc),
                                            ))
                                        .toList(),
                                    onChanged: (newValue) {
                                      // print(newValue);
                                      setState(() {
                                        _currentValueType = newValue;
                                      });
                                    }),
                              );
                            }),
                      )),
                      //end trial type
                      // location
                      new ListTile(
                        title: new TextFormField(
                          controller: locationController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.location_on),
                            labelText: 'Location',
                          ),
                        ),
                      ),
                      //end location
                      // name
                      new ListTile(
                        title: new TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.perm_identity),
                            labelText: 'Name',
                          ),
                        ),
                      ),
                      // end name
                      // phone
                      new ListTile(
                        title: new TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.phone),
                            labelText: 'Phone',
                          ),
                        ),
                      ),
                      // end phone
                      // age
                      new ListTile(
                        title: new TextFormField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.cake),
                            labelText: 'Age',
                          ),
                        ),
                      ),
                      //end age
                      //material
                      new ListTile(
                          title: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.perm_identity),
                          labelText: 'Material',
                        ),
                        child: new FutureBuilder(
                            future: _materialDao.getSelectMaterial(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<MaterialModelFL>> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    isDense: true,
                                    value: _currentValueMaterial,
                                    // isExpanded: false,
                                    hint: Text("Select Material"),
                                    items: snapshot.data
                                        .map((MaterialModelFL _listMaterial) =>
                                            DropdownMenuItem(
                                              value: _listMaterial.materialid,
                                              child: Text(
                                                  _listMaterial.materialname),
                                            ))
                                        .toList(),
                                    onChanged: (newValue) {
                                      // print(int.parse(priceController.text));
                                      setState(() {
                                        _currentValueMaterial = newValue;
                                        getHarga(_currentValueMaterial);
                                      });
                                    }),
                              );
                            }),
                      )),
                      //end material
                      //qty
                      new ListTile(
                        title: new TextFormField(
                          controller: qtyController,
                          // initialValue: "0",
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.confirmation_num),
                            labelText: 'Qty',
                          ),
                          onChanged: (value) {
                            if (_currentValueType == "1") {
                              print("Direct Selling");
                            } else {
                              print("Switching");
                            }
                            _total = _harga * int.parse(value);
                            setState(() {
                              totalController.text =
                                  "Rp." + oCcy.format(_total);
                            });
                          },
                          onTap: () {
                            qtyController.selection = new TextSelection(
                              baseOffset: 0,
                              extentOffset: qtyController.text.length,
                            );
                          },
                        ),
                      ),
                      //end qty
                      // price
                      new ListTile(
                        title: new TextFormField(
                          controller: priceController,
                          // keyboardType: TextInputType.number,
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.attach_money),
                            labelText: 'Price',
                          ),
                        ),
                      ),
                      // end price
                      //total
                      new ListTile(
                        title: new TextFormField(
                          controller: totalController,
                          // keyboardType: TextInputType.number,
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.monetization_on_rounded),
                            labelText: 'Total',
                          ),
                        ),
                      ),
                      // end total
                      //brand before
                      new ListTile(
                          title: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.perm_identity),
                          labelText: 'Brand Before',
                        ),
                        child: new FutureBuilder(
                            future: _lookupFLDao.getSelectLookupKnowProduct(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<LookupModelFL>> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    isDense: true,
                                    value: _currentValueBrandbefore,
                                    // isExpanded: false,
                                    hint: Text("Select Type"),
                                    items: snapshot.data
                                        .map((LookupModelFL _listbrandbefore) =>
                                            DropdownMenuItem(
                                              value:
                                                  _listbrandbefore.lookupvalue,
                                              child: Text(
                                                  _listbrandbefore.lookupdesc),
                                            ))
                                        .toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _currentValueBrandbefore = newValue;
                                      });
                                    }),
                              );
                            }),
                      )),
                      // end brand before
                      //know product
                      new ListTile(
                          title: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.perm_identity),
                          labelText: 'Know Product',
                        ),
                        child: new FutureBuilder(
                            future: _lookupFLDao.getSelectLookupKnowProduct(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<LookupModelFL>> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    isDense: true,
                                    value: _currentValueKnowProduct,
                                    // isExpanded: false,
                                    hint: Text("Select Answer"),
                                    items: snapshot.data
                                        .map((LookupModelFL _listknowproduct) =>
                                            DropdownMenuItem(
                                              value:
                                                  _listknowproduct.lookupvalue,
                                              child: Text(
                                                  _listknowproduct.lookupdesc),
                                            ))
                                        .toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _currentValueKnowProduct = newValue;
                                      });
                                    }),
                              );
                            }),
                      )),
                      //end know product
                      //taste
                      new ListTile(
                          title: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.perm_identity),
                          labelText: 'Taste',
                        ),
                        child: new FutureBuilder(
                            future: _lookupFLDao.getSelectLookupTaste(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<LookupModelFL>> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    isDense: true,
                                    value: _currentValueTaste,
                                    // isExpanded: false,
                                    hint: Text("Select Answer"),
                                    items: snapshot.data
                                        .map((LookupModelFL _listtaste) =>
                                            DropdownMenuItem(
                                              value: _listtaste.lookupvalue,
                                              child:
                                                  Text(_listtaste.lookupdesc),
                                            ))
                                        .toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _currentValueTaste = newValue;
                                      });
                                    }),
                              );
                            }),
                      )),
                      //end taste
                      //packaging
                      new ListTile(
                          title: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.perm_identity),
                          labelText: 'Packaging',
                        ),
                        child: new FutureBuilder(
                            future: _lookupFLDao.getSelectLookupPackaging(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<LookupModelFL>> snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    isDense: true,
                                    value: _currentValuePackaging,
                                    // isExpanded: false,
                                    hint: Text("Select Answer"),
                                    items: snapshot.data
                                        .map((LookupModelFL _listpackaging) =>
                                            DropdownMenuItem(
                                              value: _listpackaging.lookupvalue,
                                              child: Text(
                                                  _listpackaging.lookupdesc),
                                            ))
                                        .toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _currentValuePackaging = newValue;
                                      });
                                    }),
                              );
                            }),
                      )),
                      //end packaging
                      // outlet name
                      new ListTile(
                        title: new TextFormField(
                          controller: outletnameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.store),
                            labelText: 'Outlet Name',
                          ),
                        ),
                      ),
                      // end outlet name
                      //outlet address
                      new ListTile(
                        title: new TextFormField(
                          controller: outletaddressontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.store),
                            labelText: 'Outlet Address',
                          ),
                        ),
                      ),
                      //end outlet address
                      //notes
                      new ListTile(
                        title: new TextFormField(
                          controller: notesController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.book),
                            labelText: 'Notes',
                          ),
                        ),
                      ),
                      //end notes
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 50,
                            child: new RaisedButton.icon(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(TRIAL_SCREEN_FL);
                                },
                                icon: Icon(Icons.cancel),
                                label: Text("Cancel")),
                          ),
                          Container(
                            height: 50,
                            width: 150,
                            child: new RaisedButton.icon(
                                color: Colors.green,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.save,
                                  color: Colors.white,
                                ),
                                label: Text("Simpan",
                                    style: new TextStyle(color: Colors.white))),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  // all of function
// get Harga
  void getHarga(materialid) async {
    Database db = await _dbprovider.database;
    String strSQL;
    strSQL =
        "select price from materialfl where materialid = '" + materialid + "'";
    List<Map> result = await db.rawQuery(strSQL);
    var _xHarga;
    if (result.isNotEmpty) {
      _xHarga = result[0]['price'];
    } else {
      _xHarga = 0;
    }
    setState(() {
      if (_xHarga != null) {
        _harga = _xHarga;
      } else {
        _harga = 0;
      }

      priceController.text = "Rp." + oCcy.format(_harga);
    });
  }
// end get harga

}
