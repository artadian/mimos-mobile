import 'package:flutter/material.dart';
import 'package:mimos/PR/screen/transaction/stok/stock_vm.dart';
import 'package:mimos/PR/screen/trial/form/trial_form_vm.dart';
import 'package:mimos/utils/widget/button/bottom_action.dart';
import 'package:mimos/utils/widget/textfield/dropdown_textformfield.dart';
import 'package:mimos/utils/widget/textfield/text_input_field.dart';
import 'package:provider/provider.dart';
import 'package:mimos/helper/extension.dart';

class TrialFormPRScreen extends StatefulWidget {
  @override
  _TrialFormPRScreenState createState() => _TrialFormPRScreenState();
}

class _TrialFormPRScreenState extends State<TrialFormPRScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Input Trial"),
          ),
          body: _initProvider(),
        ));
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<TrialFormVM>(
      create: (_) => TrialFormVM(),
      child: Consumer<TrialFormVM>(
        builder: (c, vm, _) => _initWidget(vm),
      ),
    );
  }

  Widget _initWidget(TrialFormVM vm) {
    return Form(
      key: vm.keyForm,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: _formInput(),
              ),
              BottomAction(
                onPressed: (){},
              ),
            ],
          ),
        ],
      ),
    );
  }

  _formInput() {
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = _screenWidth < 600 ? 1 : 2;
    var _width = ( _screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) / _crossAxisCount;
    var cellHeight = 60;
    var _aspectRatio = _width /cellHeight;

    return GridView.count(
      crossAxisCount: _crossAxisCount,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.all(10.0),
      childAspectRatio: _aspectRatio,
      children: [
        TextInputField(
          readOnly: true,
//          controller: vm.tglBeli,
//          onSaved: (val) => vm.model.TGL_PEMBELIAN = val,
          labelText: "Tanggal Beli",
          onTap: () {

          },
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
        ),
        TextInputField(
//          controller: vm.volumeJual,
          keyboardType: TextInputType.number,
//          onSaved: (val) => vm.model.VOLUME_PENJUALAN = val,
          labelText: "Jumlah Slof",
          suffixText: "Slof",
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
