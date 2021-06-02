import 'package:flutter/material.dart';
import 'package:mimos/PR/model/stock.dart';
import 'package:mimos/PR/screen/transaction/stok/form/stock_form_vm.dart';
import 'package:mimos/utils/widget/button/bottom_action.dart';
import 'package:mimos/utils/widget/dialog/default_dialog.dart';
import 'package:mimos/utils/widget/my_toast.dart';
import 'package:mimos/utils/widget/textfield/dropdown_textformfield.dart';
import 'package:mimos/utils/widget/textfield/text_input_field.dart';
import 'package:provider/provider.dart';
import 'package:mimos/helper/extension.dart';

class StokFormScreen extends StatefulWidget {
  final Stock stock;
  final int id;
  final String priceid;

  StokFormScreen({this.stock, this.id, this.priceid});

  @override
  _StokFormScreenState createState() => _StokFormScreenState();
}

class _StokFormScreenState extends State<StokFormScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Input Cek Stok"),
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
    return ChangeNotifierProvider<StokFormVM>(
      create: (_) => StokFormVM()..init(context, widget.stock, widget.id, widget.priceid),
      child: Consumer<StokFormVM>(
        builder: (c, vm, _) {
          return _initWidget(vm);
        },
      ),
    );
  }

  Widget _initWidget(StokFormVM vm) {
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
//                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  _formInput(StokFormVM vm) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        DropdownTextFormField(
          controller: vm.product,
          labelText: "Pilih Barang",
          prefixIcon: Icon(Icons.shopping_basket),
          onSaved: (val) => vm.stockDetail.materialname = val,
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
          controller: vm.pac,
          keyboardType: TextInputType.number,
          onTap: () => vm.pac.selection = TextSelection(
              baseOffset: 0, extentOffset: vm.pac.value.text.length),
          onSaved: (String val) {
            if(val.isNotEmpty){
              return vm.stockDetail.pac = val.toInt() ?? 0;
            }else{
              return vm.stockDetail.pac = 0;
            }
          },
          labelText: "Jumlah Pac",
          suffixText: "Pac",
          prefixIcon: Icon(Icons.ad_units),
        ),
        TextInputField(
          controller: vm.slof,
          keyboardType: TextInputType.number,
          onTap: () => vm.slof.selection = TextSelection(
              baseOffset: 0, extentOffset: vm.slof.value.text.length),
          onSaved: (String val) {
            if(val.isNotEmpty){
              return vm.stockDetail.slof = val.toInt() ?? 0;
            }else{
              return vm.stockDetail.slof = 0;
            }
          },
          labelText: "Jumlah Slof",
          suffixText: "Slof",
          prefixIcon: Icon(Icons.apps),
        ),
        TextInputField(
          controller: vm.bal,
          keyboardType: TextInputType.number,
          onTap: () => vm.bal.selection = TextSelection(
              baseOffset: 0, extentOffset: vm.bal.value.text.length),
          onSaved: (String val) {
            if(val.isNotEmpty){
              return vm.stockDetail.bal = val.toInt() ?? 0;
            }else{
              return vm.stockDetail.bal = 0;
            }
          },
          labelText: "Jumlah Bal",
          suffixText: "Bal",
          prefixIcon: Icon(Icons.archive),
        ),
      ],
    );
  }

  _dialogProductChoice(StokFormVM vm) {
    var alert = DefaultDialog(
      title: "Pilih Product",
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  vm.materialPick(data);
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
