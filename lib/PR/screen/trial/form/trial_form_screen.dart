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
  @override
  _TrialFormScreenState createState() => _TrialFormScreenState();
}

class _TrialFormScreenState extends State<TrialFormScreen> {
  var _vm = TrialFormVM();

  @override
  void initState() {
    _vm.init();
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
      child: Consumer<TrialFormVM>(
        builder: (c, vm, _) => _initWidget(vm),
      ),
    );
  }

  Widget _initWidget(TrialFormVM vm) {
    return Form(
      key: _vm.keyForm,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: _formInput(vm),
              ),
              BottomAction(
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  _formInput(TrialFormVM vm) {
//    var _crossAxisSpacing = 8;
//    var _screenWidth = MediaQuery.of(context).size.width;
//    var _crossAxisCount = _screenWidth < 600 ? 1 : 2;
//    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
//        _crossAxisCount;
//    var cellHeight = 60;
//    var _aspectRatio = _width / cellHeight;

    return ListView(padding: EdgeInsets.symmetric(horizontal: 10), children: [
      DropdownButtonFormField(
        value: _vm.model.trialtype,
        items: vm.listType.map((map) {
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
      ),
      TextInputField(
        controller: _vm.name,
        onSaved: (val) => _vm.model.name = val,
        prefixIcon: Icon(Icons.person),
        labelText: "Name",
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
        onSaved: (val) => _vm.model.age = val,
        keyboardType: TextInputType.number,
        prefixIcon: Icon(Icons.cake),
        labelText: "Age",
      ),
      DropdownTextFormField(
        controller: _vm.product,
        labelText: "Pilih Barang",
        prefixIcon: Icon(Icons.shopping_basket),
        onSaved: (val) => _vm.model.materialname = val,
        enabled: !_vm.edit,
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
        onSaved: (val) => _vm.model.qty = val,
        keyboardType: TextInputType.number,
        prefixIcon: Icon(Icons.margin),
        labelText: "Qty",
        onChanged: _vm.onChangeQty,
      ),
      TextInputField(
        controller: _vm.price,
        enabled: false,
        onSaved: (val) => _vm.model.price = val,
        keyboardType: TextInputType.number,
        prefixIcon: Icon(Icons.attach_money),
        labelText: "Price",
      ),
      TextInputField(
        controller: _vm.amount,
        enabled: false,
        onSaved: (val) => _vm.model.amount = val,
        keyboardType: TextInputType.number,
        prefixIcon: Icon(Icons.money),
        labelText: "Total Price",
      ),
      DropdownTextFormField(
        controller: _vm.brandBefore,
        labelText: "Brand Before",
        prefixIcon: Icon(Icons.label_important),
        onSaved: (val) => _vm.model.materialname = val,
        enabled: !_vm.edit,
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
        items: vm.listKnowing.map((map) {
          Lookup data = Lookup.fromJson(map);
          return DropdownMenuItem(
            value: data.lookupvalue,
            child: Text(data.lookupdesc),
          );
        }).toList(),
        onChanged: (String val) {
          _vm.model.knowing = val;
        },
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
        items: vm.listTaste.map((map) {
          Lookup data = Lookup.fromJson(map);
          return DropdownMenuItem(
            value: data.lookupvalue,
            child: Text(data.lookupdesc),
          );
        }).toList(),
        onChanged: (String val) {
          _vm.model.taste = val;
        },
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
        items: vm.listPackaging.map((map) {
          Lookup data = Lookup.fromJson(map);
          return DropdownMenuItem(
            value: data.lookupvalue,
            child: Text(data.lookupdesc),
          );
        }).toList(),
        onChanged: (String val) {
          _vm.model.packaging = val;
        },
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
        labelText: "Outlet Name",
      ),
      TextInputField(
        controller: _vm.outletAddress,
        onSaved: (val) => _vm.model.outletaddress = val,
        prefixIcon: Icon(Icons.assistant_navigation),
        labelText: "Outlet Address",
      ),
      TextInputField(
        controller: _vm.notes,
        onSaved: (val) => _vm.model.notes = val,
        prefixIcon: Icon(Icons.sticky_note_2_outlined),
        labelText: "Notes",
      ),
    ]
//          .map((e) => Padding(
//                padding: EdgeInsets.only(bottom: 5),
//                child: e,
//              ))
//          .toList(),
        );
  }

  _dialogProductChoice() {
    var alert = DefaultDialog(
      title: "Pilih Product",
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
