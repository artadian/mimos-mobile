import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/PR/model/trial.dart';
import 'package:mimos/PR/screen/trial/form/trial_form_screen.dart';
import 'package:mimos/PR/screen/trial/item/trial_item.dart';
import 'package:mimos/PR/screen/trial/trial_vm.dart';
import 'package:mimos/utils/layout/empty_screen.dart';
import 'package:mimos/utils/widget/button/button_icon_rounded.dart';
import 'package:mimos/utils/widget/span_text.dart';
import 'package:mimos/utils/widget/text_icon.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mimos/helper/extension.dart';

class TrialScreen extends StatefulWidget {
  @override
  _TrialScreenState createState() => _TrialScreenState();
}

class _TrialScreenState extends State<TrialScreen> {
  var _vm = TrialVM();

  @override
  void initState() {
    _vm.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Trial"),
        shadowColor: Colors.transparent,
      ),
      body: _initProvider(),
    ));
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<TrialVM>(
      create: (_) => _vm,
      child: Consumer<TrialVM>(
        builder: (c, vm, _) => _initWidget(),
      ),
    );
  }

  Widget _headerItem(
      {String title, String value, IconData icon, Color iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextIcon(
            icon: icon,
            iconColor: iconColor,
            text: value ?? "",
            iconSize: 22,
            fontSize: 20,
          ),
          Text(
            title ?? "",
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextIcon(
              icon: Icons.monetization_on_outlined,
              iconColor: Colors.green,
              text: _vm.amount.toString().toMoney(),
              iconSize: 26,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            Text(
              "Total Amount",
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: _headerItem(
                      title: "Total Trial",
                      value: _vm.totalTrial.toString().toMoney(),
                      icon: Icons.all_inbox,
                      iconColor: Colors.red),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: _headerItem(
                      title: "Pack Sold",
                      value: _vm.packSold.toString().toMoney(),
                      icon: Icons.widgets,
                      iconColor: Colors.blue),
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      decoration: BoxDecoration(color: MyPalette.ijoMimos),
    );
  }

  Widget _body() {
    return SmartRefresher(
      physics: ScrollPhysics(),
      enablePullDown: true,
      header: WaterDropMaterialHeader(
        offset: 10,
      ),
      controller: _vm.refreshController,
      onRefresh: _vm.onRefresh,
      child: ListView(
        children: [
          _header(),
          (_vm.listTrial.isEmpty)
              ? EmptyScreen()
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: _vm.listTrial.length,
                  itemBuilder: (c, i) {
                    Trial data = _vm.listTrial[i];
                    return TrialItem(
                      title: data.name,
                      titleEnd: SpanText(
                        data.lookupdesc,
                        fontWeight: FontWeight.bold,
                        color: data.lookupdesc.toLowerCase() == "switching"
                            ? Colors.blue
                            : Colors.green,
                      ),
                      subtitle1: data.outletname,
                      subtitle2Left: data.materialname,
                      subtitle2Right: " : (${data.qty} Pack)",
                      footer1: data.location,
                      onTap: () {
                        _gotoForm(id: data.id);
                      },
                      trailing: InkWell(
                        onTap: () {
                          _dialogDeleteConfirm(data);
                        },
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                      ),
                    );
                  })
        ],
      ),
    );
  }

  Widget _initWidget() {
    return Container(
      child: Stack(
        children: [
          _body(),
          Positioned(
            bottom: 16,
            right: 16,
            child: ButtonIconRounded(
              icon: Icons.add_circle_outline,
              text: "Tambah Item",
              onPressed: () {
                _gotoForm();
              },
            ),
          )
        ],
      ),
    );
  }

  _gotoForm({int id}) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TrialFormScreen(id: id)));

    print("result: $result");
    if (result != null) {
      _vm.loadData();
    }
  }

  _dialogDeleteConfirm(Trial data) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text("Delete"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hapus Data:"),
            SizedBox(
              height: 10,
            ),
            Text(
              "${data.name} ?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel')),
          FlatButton(
              onPressed: () {
                _vm.delete(data.id);
                Navigator.of(context).pop();
              },
              child: Text('Delete', style: TextStyle(color: Colors.red[600]))),
        ],
      ),
    );
  }
}
