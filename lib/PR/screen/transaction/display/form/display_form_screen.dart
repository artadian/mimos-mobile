import 'package:flutter/material.dart';
import 'package:mimos/PR/model/visibility_model.dart';
import 'package:mimos/PR/screen/transaction/display/form/display_form_vm.dart';
import 'package:mimos/utils/widget/button/bottom_action.dart';
import 'package:mimos/utils/widget/dialog/default_dialog.dart';
import 'package:mimos/utils/widget/textfield/dropdown_textformfield.dart';
import 'package:mimos/utils/widget/textfield/text_input_field.dart';
import 'package:provider/provider.dart';
import 'package:mimos/helper/extension.dart';

class DisplayFormScreen extends StatefulWidget {
  final VisibilityModel visibilityModel;
  final int id;
  final String priceid;

  DisplayFormScreen({this.visibilityModel, this.id, this.priceid});

  @override
  _DisplayFormScreenState createState() => _DisplayFormScreenState();
}

class _DisplayFormScreenState extends State<DisplayFormScreen> {
  var _vm = DisplayFormVM();

  @override
  void initState() {
    super.initState();
    _vm.init(context, widget.visibilityModel, widget.id, widget.priceid);
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Input Display"),
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
    return ChangeNotifierProvider<DisplayFormVM>(
      create: (_) => _vm,
      child: Consumer<DisplayFormVM>(
        builder: (c, vm, _) {
          return _initWidget();
        },
      ),
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
          onSaved: (val) => _vm.visibilityDetail.materialname = val,
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
          controller: _vm.pac,
          keyboardType: TextInputType.number,
          onSaved: (String val) {
            if(val.isNotEmpty){
              return _vm.visibilityDetail.pac = val.toInt() ?? 0;
            }else{
              return _vm.visibilityDetail.pac = 0;
            }
          },
          labelText: "Jumlah Pac",
          suffixText: "Pac",
          prefixIcon: Icon(Icons.ad_units),
        ),
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
}
