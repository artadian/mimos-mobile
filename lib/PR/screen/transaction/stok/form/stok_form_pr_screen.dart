import 'package:flutter/material.dart';
import 'package:mimos/PR/screen/transaction/stok/stok_pr_vm.dart';
import 'package:mimos/utils/widget/button/bottom_action.dart';
import 'package:mimos/utils/widget/textfield/dropdown_textformfield.dart';
import 'package:mimos/utils/widget/textfield/text_input_field.dart';
import 'package:provider/provider.dart';
import 'package:mimos/helper/extension.dart';

class StokFormPRScreen extends StatefulWidget {
  @override
  _StokFormPRScreenState createState() => _StokFormPRScreenState();
}

class _StokFormPRScreenState extends State<StokFormPRScreen> {
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
                  Navigator.of(context).pop();
                })
          ],
        ),
        body: _initProvider(),
      ),
    );
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<StokPRVM>(
      create: (_) => StokPRVM(),
      child: Consumer<StokPRVM>(
        builder: (c, vm, _) => _initWidget(vm),
      ),
    );
  }

  Widget _initWidget(StokPRVM vm) {
    return Form(
      key: vm.keyForm,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: _formInputTest(),
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

  _formInputTest() {
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = _screenWidth < 600 ? 1 : 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 60;
    var _aspectRatio = _width / cellHeight;

    return GridView.count(
      crossAxisCount: _crossAxisCount,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.all(10.0),
      childAspectRatio: _aspectRatio,
      children: [
        DropdownTextFormField(
//          controller: vm.product,
          labelText: "Pilih Barang",
//          onSaved: (val) => vm.model.NAMA_PRODUK = val,
          validator: (val) {
            if (val.length < 1)
              return 'Filed is required';
            else
              return null;
          },
          onTap: () {},
        ),
        TextInputField(
          readOnly: true,
//          controller: vm.tglBeli,
//          onSaved: (val) => vm.model.TGL_PEMBELIAN = val,
          labelText: "Tanggal Beli",
          onTap: () {},
        ),
        TextInputField(
//          controller: vm.hargaBeliPokok,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.HARGA_BELI_POKOK = val,
          labelText: "Jumlah Bal",
          suffixText: "Bal",
          validator: (String val) {
//            int numb = val.clearMoneyInt();
//            if (val.length < 1 || val.toString() == "0")
//              return 'Filed is required';
//            else if (numb < 10000)
//              return 'Harga tidak boleh kurang dari 10.000';
//            else if (numb > 100000)
//              return 'Harga tidak boleh lebih dari 100.000';
//            else
            return null;
          },
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
        ),
      ],
    );
  }

  _formInput() {
    return ListView(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      children: [
        DropdownTextFormField(
//          controller: vm.product,
          labelText: "Pilih Barang",
//          onSaved: (val) => vm.model.NAMA_PRODUK = val,
          validator: (val) {
            if (val.length < 1)
              return 'Filed is required';
            else
              return null;
          },
          onTap: () {},
        ),
        SizedBox(
          height: 8,
        ),
        TextInputField(
          readOnly: true,
//          controller: vm.tglBeli,
//          onSaved: (val) => vm.model.TGL_PEMBELIAN = val,
          labelText: "Tanggal Beli",
          onTap: () {},
        ),
        SizedBox(
          height: 8,
        ),
        TextInputField(
//          controller: vm.hargaBeliPokok,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.HARGA_BELI_POKOK = val,
          labelText: "Jumlah Bal",
          suffixText: "Bal",
          validator: (String val) {
//            int numb = val.clearMoneyInt();
//            if (val.length < 1 || val.toString() == "0")
//              return 'Filed is required';
//            else if (numb < 10000)
//              return 'Harga tidak boleh kurang dari 10.000';
//            else if (numb > 100000)
//              return 'Harga tidak boleh lebih dari 100.000';
//            else
            return null;
          },
        ),
        SizedBox(
          height: 8,
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
        ),
      ],
    );
  }
}
