import 'package:flutter/material.dart';
import 'package:mimos/PR/model/lookup.dart';
import 'package:mimos/PR/screen/trial/form/trial_form_vm.dart';
import 'package:mimos/utils/widget/button/bottom_action.dart';
import 'package:mimos/utils/widget/dialog/default_dialog.dart';
import 'package:mimos/utils/widget/textfield/dropdown_textformfield.dart';
import 'package:mimos/utils/widget/textfield/text_input_field.dart';
import 'package:provider/provider.dart';
import 'package:mimos/helper/extension.dart';

class TrialFormScreen extends StatefulWidget {
  final int id;

  TrialFormScreen({this.id});

  @override
  _TrialFormScreenState createState() => _TrialFormScreenState();
}

class _TrialFormScreenState extends State<TrialFormScreen> {
  var _vm = TrialFormVM();

  @override
  void initState() {
    _vm.init(context, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          var res = await _dialogClose();
          return res;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Input Trial"),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    var res = await _dialogClose();
                    if (res) {
                      Navigator.of(context).pop("refresh");
                    }
                  })
            ],
          ),
          body: _initProvider(),
        ),
      ),
    );
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<TrialFormVM>(
      create: (_) => _vm,
      child: Consumer<TrialFormVM>(builder: (c, vm, _) => _initWidget()),
    );
  }

  Widget _initWidget() {
    if (_vm.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Form(
      key: _vm.keyForm,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: _formInput(),
              ),
              BottomAction(
                onPressed: () {
                  _vm.save();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  _formInput() {
    return SingleChildScrollView(
      child: Column(
        children: [
          DropdownButtonFormField(
            value: _vm.model.trialtype,
            items: _vm.listType.map((map) {
              Lookup data = Lookup.fromJson(map);
              return DropdownMenuItem(
                value: data.lookupvalue,
                child: Text(data.lookupdesc),
              );
            }).toList(),
            onChanged: _vm.onChangeType,
            decoration: InputDecoration(
              labelText: "Pilih Tipe",
              prefixIcon: Icon(Icons.category),
            ),
            validator: (String val) {
              if (val == null)
                return 'Filed is required';
              else
                return null;
            },
          ),
          TextInputField(
            controller: _vm.location,
            onSaved: (val) => _vm.model.location = val,
            prefixIcon: Icon(Icons.location_on),
            labelText: "Location",
            emptyValidator: true,
          ),
          TextInputField(
            controller: _vm.name,
            onSaved: (val) => _vm.model.name = val,
            prefixIcon: Icon(Icons.person),
            labelText: "Name",
            emptyValidator: true,
          ),
          TextInputField(
            controller: _vm.phone,
            onSaved: (val) => _vm.model.phone = val,
            keyboardType: TextInputType.phone,
            prefixIcon: Icon(Icons.phone),
            labelText: "Phone",
          ),
          TextInputField(
            controller: _vm.age,
            onSaved: (String val) => _vm.model.age = val.toInt(defaultVal: 0),
            keyboardType: TextInputType.number,
            prefixIcon: Icon(Icons.cake),
            labelText: "Age",
            emptyValidator: true,
          ),
          DropdownTextFormField(
            controller: _vm.product,
            labelText: "Pilih Produk",
            prefixIcon: Icon(Icons.shopping_basket),
            onSaved: (val) => _vm.model.materialname = val,
            validator: (val) {
              if (val.length < 1)
                return 'Filed is required';
              else
                return null;
            },
            onTap: () {
              _dialogProductChoice();
            },
          ),
          TextInputField(
            controller: _vm.qty,
            onSaved: (String val) => _vm.model.qty = val.toInt(defaultVal: 0),
            keyboardType: TextInputType.number,
            prefixIcon: Icon(Icons.margin),
            labelText: "Qty",
            enabled: !_vm.typeSwitching,
            onChanged: (String val){
              _vm.getAmount();
            },
            emptyValidator: true,
          ),
          TextInputField(
            controller: _vm.price,
            enabled: false,
            onSaved: (String val) =>
                _vm.model.price = val.clearMoney().toDouble(defaultVal: 0.0),
            keyboardType: TextInputType.number,
            prefixIcon: Icon(Icons.attach_money),
            labelText: "Price",
            emptyValidator: true,
          ),
          TextInputField(
            controller: _vm.amount,
            enabled: false,
            onSaved: (String val) =>
                _vm.model.amount = val.clearMoney().toDouble(defaultVal: 0.0),
            keyboardType: TextInputType.number,
            prefixIcon: Icon(Icons.money),
            labelText: "Total Price",
            emptyValidator: true,
          ),
          DropdownTextFormField(
            controller: _vm.brandBefore,
            labelText: "Brand Before",
            prefixIcon: Icon(Icons.label_important),
            onSaved: (val) => _vm.model.competitorbrandname = val,
            validator: (val) {
              if (val.length < 1)
                return 'Filed is required';
              else
                return null;
            },
            onTap: () {
              _dialogBrandCompetitorChoice();
            },
          ),
          DropdownButtonFormField(
            value: _vm.model.knowing,
            items: _vm.listKnowing.map((map) {
              Lookup data = Lookup.fromJson(map);
              return DropdownMenuItem(
                value: data.lookupvalue,
                child: Text(data.lookupdesc),
              );
            }).toList(),
            onChanged: _vm.onChangeKnowing,
            decoration: InputDecoration(
              labelText: "Pilih Knowing",
              prefixIcon: Icon(Icons.ad_units),
            ),
            validator: (String val) {
              if (val == null)
                return 'Filed is required';
              else
                return null;
            },
          ),
          DropdownButtonFormField(
            value: _vm.model.taste,
            items: _vm.listTaste.map((map) {
              Lookup data = Lookup.fromJson(map);
              return DropdownMenuItem(
                value: data.lookupvalue,
                child: Text(data.lookupdesc),
              );
            }).toList(),
            onChanged: _vm.onChangeTaste,
            decoration: InputDecoration(
              labelText: "Pilih Taste",
              prefixIcon: Icon(Icons.stop_circle_sharp),
            ),
            validator: (String val) {
              if (val == null)
                return 'Filed is required';
              else
                return null;
            },
          ),
          DropdownButtonFormField(
            value: _vm.model.packaging,
            items: _vm.listPackaging.map((map) {
              Lookup data = Lookup.fromJson(map);
              return DropdownMenuItem(
                value: data.lookupvalue,
                child: Text(data.lookupdesc),
              );
            }).toList(),
            onChanged: _vm.onChangePackaging,
            decoration: InputDecoration(
              labelText: "Pilih Packaging",
              prefixIcon: Icon(Icons.archive),
            ),
            validator: (String val) {
              if (val == null)
                return 'Filed is required';
              else
                return null;
            },
          ),
          TextInputField(
            controller: _vm.outletName,
            onSaved: (val) => _vm.model.outletname = val,
            prefixIcon: Icon(Icons.store),
            labelText: "Customer Outlet Name",
            emptyValidator: true,
          ),
          TextInputField(
            controller: _vm.outletAddress,
            onSaved: (val) => _vm.model.outletaddress = val,
            prefixIcon: Icon(Icons.assistant_navigation),
            labelText: "Customer Outlet Address",
          ),
          TextInputField(
            controller: _vm.notes,
            onSaved: (val) => _vm.model.notes = val,
            prefixIcon: Icon(Icons.sticky_note_2_outlined),
            labelText: "Notes",
          ),
        ]
            .map((e) => Padding(
                  padding: EdgeInsets.only(bottom: 5, left: 16, right: 16),
                  child: e,
                ))
            .toList(),
      ),
    );
  }

  _dialogProductChoice() {
    var alert = DefaultDialog(
      title: "Pilih Produk",
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _vm.listProduct.length,
            itemBuilder: (c, i) {
              var data = _vm.listProduct[i];
              return ListTile(
                title: Text(
                  data.materialname,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _vm.materialPick(data);
                },
              );
            }),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _dialogBrandCompetitorChoice() {
    var alert = DefaultDialog(
      title: "Pilih Brand Competitor",
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _vm.listBrandCompetitor.length,
            itemBuilder: (c, i) {
              var data = _vm.listBrandCompetitor[i];
              return ListTile(
                title: Text(
                  data.competitorbrandname,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _vm.brandPick(data);
                },
              );
            }),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _dialogClose() async {
    var data = await showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text("Keluar"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Keluar dari input trial ?",
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel')),
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Keluar', style: TextStyle(color: Colors.red[600]))),
        ],
      ),
    );
    return data;
  }
}
