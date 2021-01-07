import 'package:flutter/material.dart';
import 'package:mimos/PR/model/lookup.dart';
import 'package:mimos/PR/model/posm.dart';
import 'package:mimos/PR/screen/transaction/posm/form/posm_form_vm.dart';
import 'package:mimos/utils/widget/button/bottom_action.dart';
import 'package:mimos/utils/widget/dialog/default_dialog.dart';
import 'package:mimos/utils/widget/textfield/dropdown_textformfield.dart';
import 'package:mimos/utils/widget/textfield/text_input_field.dart';
import 'package:provider/provider.dart';
import 'package:mimos/helper/extension.dart';

class PosmFormScreen extends StatefulWidget {
  final Posm posm;
  final int id;
  final String priceid;

  PosmFormScreen({this.posm, this.id, this.priceid});

  @override
  _PosmFormScreenState createState() => _PosmFormScreenState();
}

class _PosmFormScreenState extends State<PosmFormScreen> {
  var _vm = PosmFormVM();

  @override
  void initState() {
    super.initState();
    _vm.init(context, widget.posm, widget.id, widget.priceid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Input POSM"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop("refresh");
                })
          ],
        ),
        body: _initProvider(),
      ),
    );
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<PosmFormVM>(
      create: (_) => _vm,
      child: _initWidget(),
    );
  }

  Widget _initWidget() {
    return Form(
      key: _vm.keyForm,
      autovalidateMode: _vm.autovalidateMode,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: _formInput(),
              ),
              BottomAction(
                onPressed: () async {
                  await _vm.save();
//                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  _formInput() {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        DropdownTextFormField(
          controller: _vm.product,
          labelText: "Pilih Barang",
          prefixIcon: Icon(Icons.shopping_basket),
          onSaved: (val) => _vm.posmDetail.materialgroupdesc = val,
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
        FutureBuilder(
          future: _vm.getType(),
          builder: (c, snapshot) {
            List<Lookup> list = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());

            return DropdownButtonFormField(
              value: _vm.edit ? _vm.posmDetail.posmtypeid : null,
              items: list.map((Lookup data) {
                return DropdownMenuItem(
                  value: data.lookupvalue,
                  child: Text(data.lookupdesc),
                );
              }).toList(),
              onChanged: (String val) {
                _vm.posmDetail.posmtypeid = val;
              },
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
            );
          },
        ),
        FutureBuilder(
          future: _vm.getStatus(),
          builder: (c, snapshot) {
            List<Lookup> list = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());

            return DropdownButtonFormField(
              value: _vm.edit ? _vm.posmDetail.status : null,
              items: list.map((Lookup data) {
                return DropdownMenuItem(
                  value: data.lookupvalue,
                  child: Text(data.lookupdesc),
                );
              }).toList(),
              onChanged: _vm.changeStatus,
              decoration: InputDecoration(
                labelText: "Pilih Status",
                prefixIcon: Icon(Icons.assignment_outlined),
              ),
              validator: (String val) {
                if (val == null)
                  return 'Filed is required';
                else
                  return null;
              },
            );
          },
        ),
        Consumer<PosmFormVM>(builder: (c, vm, _) {
          if (vm.posmDetail.status == "2")
            return FutureBuilder(
              future: _vm.getCondition(),
              builder: (c, snapshot) {
                List<Lookup> list = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());

                return DropdownButtonFormField(
                  value: _vm.edit ? _vm.posmDetail.status : list[0].lookupvalue,
                  items: list.map((Lookup data) {
                    _vm.posmDetail.condition = int.parse(list[0].lookupvalue);
                    return DropdownMenuItem(
                      value: data.lookupvalue,
                      child: Text(data.lookupdesc),
                    );
                  }).toList(),
                  onChanged: (String val) {
                    _vm.posmDetail.condition = int.parse(val);
                  },
                  decoration: InputDecoration(
                    labelText: "Pilih Kondisi",
                    prefixIcon: Icon(Icons.info),
                  ),
                );
              },
            );
          else
            return SizedBox();
        }),
        TextInputField(
          controller: _vm.qty,
          keyboardType: TextInputType.number,
          onSaved: (String val) {
            if (val.isNotEmpty) {
              return _vm.posmDetail.qty = val.toInt() ?? 0;
            } else {
              return _vm.posmDetail.qty = 0;
            }
          },
          labelText: "Jumlah",
          prefixIcon: Icon(Icons.widgets_outlined),
        ),
        Consumer<PosmFormVM>(builder: (c, vm, _) {
          if (vm.posmDetail.status == "2")
            return TextInputField(
              controller: _vm.notes,
              onSaved: (val) => _vm.posmDetail.notes = val,
              labelText: "Catatan",
              prefixIcon: Icon(Icons.sticky_note_2_outlined),
            );
          else
            return SizedBox();
        }),
      ],
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
                  data.materialgroupdesc,
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
}
