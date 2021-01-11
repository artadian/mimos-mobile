import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/posm_detail.dart';
import 'package:mimos/PR/model/view/posm_detail_view.dart';
import 'package:mimos/PR/screen/transaction/posm/form/posm_form_screen.dart';
import 'package:mimos/PR/screen/transaction/posm/item/posm_item.dart';
import 'package:mimos/PR/screen/transaction/posm/posm_vm.dart';
import 'package:mimos/utils/layout/empty_screen.dart';
import 'package:mimos/utils/widget/button/button_icon_rounded.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mimos/helper/extension.dart';

class PosmScreen extends StatefulWidget {
  @override
  _PosmScreenState createState() => _PosmScreenState();
}

class _PosmScreenState extends State<PosmScreen> {
  var _vm = PosmVM();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CustomerPR customer = ModalRoute.of(context).settings.arguments;
    _vm.init(customer);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("POSM"),
          shadowColor: Colors.transparent,
        ),
        body: _initProvider(),
      ),
    );
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<PosmVM>(
      create: (_) => _vm,
      child: Consumer<PosmVM>(
        builder: (c, vm, _) => _initWidget(),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            _vm.customer.name ?? "-",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              "${_vm.customer.address} ${_vm.customer.city}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            width: double.maxFinite,
            child: Text(
              _vm.customer.tanggalkunjungan.dateView() ?? "-",
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(color: MyPalette.ijoMimos),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _header(),
        (_vm.listPosmDetail.isEmpty)
            ? EmptyScreen()
            : Expanded(
          child: SmartRefresher(
            physics: ScrollPhysics(),
            enablePullDown: true,
            header: WaterDropHeader(
              waterDropColor: Colors.blue,
            ),
            controller: _vm.refreshController,
            onRefresh: _vm.onRefresh,
            child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: _vm.listPosmDetail.length,
//                separatorBuilder: (c, i) {
//                  return Divider(
//                    color: Colors.grey,
//                    height: 1.0,
//                  );
//                },
                itemBuilder: (c, i) {
                  PosmDetailView data = _vm.listPosmDetail[i];
                  return PosmItem(
                    title: data.materialgroupdesc,
                    subtitle: "${data.typedesc} : ${data.qty}",
                    status: data.statusdesc,
                    qty: data.qty.toString(),
                    condition: data.conditiondesc,
                    notes: data.notes,
                    onTap: () {
                      _gotoForm(id: data.id);
                    },
                    onDelete: () {
                      _dialogDeleteConfirm(data);
                    },
                  );
                }),
          ),
        ),
      ],
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
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PosmFormScreen(
                posm: _vm.posm, id: id, priceid: _vm.customer.priceid)));

    print("result: $result");
    if (result != null) {
      _vm.loadPosmHead();
    }
  }

  _dialogDeleteConfirm(PosmDetailView data) {
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
                "${data.materialgroupname} ?",
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
                child: Text('Delete',
                    style: TextStyle(color: Colors.red[600]))),
          ],
        ));
  }
}
