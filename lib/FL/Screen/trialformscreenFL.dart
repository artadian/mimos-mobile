import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';

class TrialFormScreenFL extends StatefulWidget {
  @override
  _TrialFormScreenFLState createState() => _TrialFormScreenFLState();
}

class _TrialFormScreenFLState extends State<TrialFormScreenFL> {
  String _valGender;
  List _listGender = ["Male", "Female"]; //Array gender
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
                      new ListTile(
                          title: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.perm_identity),
                          labelText: 'Type',
                        ),
                        child: DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            isDense: true,
                            hint: Text("Select Type"),
                            value: _valGender,
                            items: _listGender.map((value) {
                              return DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _valGender = value;
                              });
                            },
                          ),
                        ),
                      )),
                      new ListTile(
                        title: new TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.location_on),
                            labelText: 'Location',
                          ),
                        ),
                      ),
                      new ListTile(
                        title: new TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.perm_identity),
                            labelText: 'Name',
                          ),
                        ),
                      ),
                      new ListTile(
                        title: new TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.phone),
                            labelText: 'Phone',
                          ),
                        ),
                      ),
                      new ListTile(
                        title: new TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.cake),
                            labelText: 'Age',
                          ),
                        ),
                      ),
                      new ListTile(
                          title: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.perm_identity),
                          labelText: 'Material',
                        ),
                        child: DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            isDense: true,
                            hint: Text("Select The Material"),
                            value: _valGender,
                            items: _listGender.map((value) {
                              return DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _valGender = value;
                              });
                            },
                          ),
                        ),
                      )),
                      new ListTile(
                        title: new TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.confirmation_num),
                            labelText: 'Qty',
                          ),
                        ),
                      ),
                      new ListTile(
                        title: new TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.attach_money),
                            labelText: 'Price',
                          ),
                        ),
                      ),
                      new ListTile(
                        title: new TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.monetization_on_rounded),
                            labelText: 'Total',
                          ),
                        ),
                      ),
                      new ListTile(
                          title: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.perm_identity),
                          labelText: 'Brand Before',
                        ),
                        child: DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            isDense: true,
                            hint: Text("Select The Answer"),
                            value: _valGender,
                            items: _listGender.map((value) {
                              return DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _valGender = value;
                              });
                            },
                          ),
                        ),
                      )),
                      new ListTile(
                          title: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.perm_identity),
                          labelText: 'Know Product',
                        ),
                        child: DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            isDense: true,
                            hint: Text("Select The Answer"),
                            value: _valGender,
                            items: _listGender.map((value) {
                              return DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _valGender = value;
                              });
                            },
                          ),
                        ),
                      )),
                      new ListTile(
                          title: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.perm_identity),
                          labelText: 'Taste',
                        ),
                        child: DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            isDense: true,
                            hint: Text("Select The Answer"),
                            value: _valGender,
                            items: _listGender.map((value) {
                              return DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _valGender = value;
                              });
                            },
                          ),
                        ),
                      )),
                      new ListTile(
                          title: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.perm_identity),
                          labelText: 'Packaging',
                        ),
                        child: DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            isDense: true,
                            hint: Text("Select The Answer"),
                            value: _valGender,
                            items: _listGender.map((value) {
                              return DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _valGender = value;
                              });
                            },
                          ),
                        ),
                      )),
                      new ListTile(
                        title: new TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.store),
                            labelText: 'Outlet Name',
                          ),
                        ),
                      ),
                      new ListTile(
                        title: new TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.store),
                            labelText: 'Outlet Address',
                          ),
                        ),
                      ),
                      new ListTile(
                        title: new TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.book),
                            labelText: 'Notes',
                          ),
                        ),
                      ),
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
}
