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
  var _vm = TrialFormVM();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Input Trial"),
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
    return ChangeNotifierProvider<TrialFormVM>(
      create: (_) => _vm,
      child: Consumer<TrialFormVM>(
        builder: (c, vm, _) => _initWidget(),
      ),
    );
  }

  Widget _initWidget() {
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
                onPressed: () {},
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
        TextInputField(
          readOnly: true,
          controller: _vm.type,
          onSaved: (val) => _vm.model.trialtype = val,
          prefixIcon: Icon(Icons.category),
          labelText: "Pilih Tipe",
          onTap: () {},
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
          prefixIcon: Icon(Icons.phone),
          labelText: "Phone",
        ),
        TextInputField(
          controller: _vm.age,
          onSaved: (val) => _vm.model.age = val,
          prefixIcon: Icon(Icons.cake),
          labelText: "Age",
        ),
        DropdownTextFormField(
          controller: _vm.product,
          onSaved: (val) => _vm.model.materialid = val,
          labelText: "Pilih Barang",
          prefixIcon: Icon(Icons.shopping_basket),
//          enabled: !vm.edit,
          validator: (val) {
            if (val.length < 1)
              return 'Filed is required';
            else
              return null;
          },
          onTap: () {
//            _dialogProductChoice(vm);
          },
        ),
        TextInputField(
          controller: _vm.qty,
          onSaved: (val) => _vm.model.qty = val,
          keyboardType: TextInputType.number,
          prefixIcon: Icon(Icons.margin),
          labelText: "Qty",
        ),
        TextInputField(
          controller: _vm.price,
          onSaved: (val) => _vm.model.price = val,
          keyboardType: TextInputType.number,
          prefixIcon: Icon(Icons.attach_money),
          labelText: "Price",
        ),
        TextInputField(
          controller: _vm.amount,
          onSaved: (val) => _vm.model.amount = val,
          keyboardType: TextInputType.number,
          prefixIcon: Icon(Icons.money),
          labelText: "Total Price",
        ),
        TextInputField(
          controller: _vm.brandBefore,
//          onSaved: (val) => _vm.model. = val,
          keyboardType: TextInputType.number,
          prefixIcon: Icon(Icons.label_important),
          labelText: "Brand Before",
        ),
        TextInputField(
          controller: _vm.knowProduct,
          onSaved: (val) => _vm.model.knowing = val,
          keyboardType: TextInputType.number,
          prefixIcon: Icon(Icons.ad_units),
          labelText: "Know Product",
        ),
        TextInputField(
          controller: _vm.taste,
          onSaved: (val) => _vm.model.taste = val,
          keyboardType: TextInputType.number,
          prefixIcon: Icon(Icons.stop_circle_sharp),
          labelText: "Taste",
        ),
        TextInputField(
          controller: _vm.type,
          onSaved: (val) => _vm.model.trialtype = val,
          keyboardType: TextInputType.number,
          prefixIcon: Icon(Icons.archive),
          labelText: "Packaging",
        ),
        TextInputField(
          controller: _vm.outletName,
          onSaved: (val) => _vm.model.outletname = val,
          keyboardType: TextInputType.number,
          prefixIcon: Icon(Icons.store),
          labelText: "Outlet Name",
        ),
        TextInputField(
          controller: _vm.outletAddress,
          onSaved: (val) => _vm.model.outletaddress = val,
          keyboardType: TextInputType.number,
          prefixIcon: Icon(Icons.assistant_navigation),
          labelText: "Outlet Address",
        ),
        TextInputField(
          controller: _vm.notes,
          onSaved: (val) => _vm.model.notes = val,
          keyboardType: TextInputType.number,
          prefixIcon: Icon(Icons.sticky_note_2_outlined),
          labelText: "Notes",
        ),
      ],
    );
  }
}
