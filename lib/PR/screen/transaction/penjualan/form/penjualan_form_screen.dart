import 'package:flutter/material.dart';
import 'package:mimos/PR/model/sellin.dart';
import 'package:mimos/PR/screen/transaction/penjualan/form/penjualan_form_vm.dart';
import 'package:mimos/helper/extension.dart';
import 'package:mimos/utils/widget/button/bottom_action.dart';
import 'package:mimos/utils/widget/dialog/default_dialog.dart';
import 'package:mimos/utils/widget/textfield/dropdown_textformfield.dart';
import 'package:mimos/utils/widget/textfield/text_input_field.dart';
import 'package:provider/provider.dart';

class PenjualanFormScreen extends StatefulWidget {
  final Sellin sellin;
  final int id;
  final String priceid;

  PenjualanFormScreen({this.sellin, this.id, this.priceid});

  @override
  _PenjualanFormScreenState createState() => _PenjualanFormScreenState();
}

class _PenjualanFormScreenState extends State<PenjualanFormScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Input Order"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        ),
        body: _initProvider(),
      ),
    );
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<PenjualanFormVM>(
      create: (_) => PenjualanFormVM()..init(context, widget.sellin, widget.id, widget.priceid),
      child: Consumer<PenjualanFormVM>(
        builder: (c, vm, _) => _initWidget(vm),
      ),
    );
  }

  Widget _initWidget(PenjualanFormVM vm) {
    return Form(
      key: vm.keyForm,
      autovalidateMode: vm.autovalidateMode,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: _formInput(vm),
              ),
              BottomAction(
                onPressed: () async {
                  await vm.save();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  _formInput(PenjualanFormVM vm) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        DropdownTextFormField(
          controller: vm.product,
          labelText: "Pilih Barang",
          prefixIcon: Icon(Icons.shopping_basket),
          onSaved: (val) => vm.sellinDetail.materialname = val,
          enabled: !vm.edit,
          validator: (val) {
            if (val.length < 1)
              return 'Filed is required';
            else
              return null;
          },
          onTap: () {
            _dialogProductChoice(vm);
          },
        ),
        TextInputField(
          controller: vm.price,
          keyboardType: TextInputType.number,
          enabled: false,
          onSaved: (String val) {
            if(val.isNotEmpty){
              return vm.sellinDetail.price = val.clearMoney().toDouble() ?? 0.0;
            }else{
              return vm.sellinDetail.price = 0.0;
            }
          },
          labelText: "Harga",
          prefixText: "Rp. ",
          suffixText: "/ Pac",
          prefixIcon: Icon(Icons.monetization_on_rounded),
        ),
        TextInputField(
          controller: vm.introdeal,
          keyboardType: TextInputType.number,
          enabled: false,
          onSaved: (String val) {
            if(val.isNotEmpty){
              return vm.sellinDetail.qtyintrodeal = val.toInt() ?? 0;
            }else{
              return vm.sellinDetail.qtyintrodeal = 0;
            }
          },
          labelText: "Introdeal",
          prefixText: "Bonus: ",
          suffixText: "Pac",
          prefixIcon: Icon(Icons.add_box),
        ),
        TextInputField(
          controller: vm.pac,
          keyboardType: TextInputType.number,
          onSaved: (String val) {
            if(val.isNotEmpty){
              return vm.sellinDetail.pac = val.toInt() ?? 0;
            }else{
              return vm.sellinDetail.pac = 0;
            }
          },
          labelText: "Jumlah Pac",
          suffixText: "Pac",
          prefixIcon: Icon(Icons.ad_units),
        ),
        TextInputField(
          controller: vm.slof,
          keyboardType: TextInputType.number,
          onSaved: (String val) {
            if(val.isNotEmpty){
              return vm.sellinDetail.slof = val.toInt() ?? 0;
            }else{
              return vm.sellinDetail.slof = 0;
            }
          },
          labelText: "Jumlah Slof",
          suffixText: "Slof",
          prefixIcon: Icon(Icons.apps),
        ),
        TextInputField(
          controller: vm.bal,
          keyboardType: TextInputType.number,
          onSaved: (String val) {
            if(val.isNotEmpty){
              return vm.sellinDetail.bal = val.toInt() ?? 0;
            }else{
              return vm.sellinDetail.bal = 0;
            }
          },
          labelText: "Jumlah Bal",
          suffixText: "Bal",
          prefixIcon: Icon(Icons.archive),
        ),
      ],
    );
  }

  _dialogProductChoice(PenjualanFormVM vm) {
    var alert = DefaultDialog(
      title: "Pilih Product",
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: vm.listProduct.length,
            itemBuilder: (c, i) {
              var data = vm.listProduct[i];
              return ListTile(
                title: Text(
                  data.materialname,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  vm.materialPick(data);
                },
              );
            }),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"))
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
