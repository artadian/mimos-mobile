import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/sellin_detail.dart';
import 'package:mimos/PR/screen/transaction/penjualan/form/penjualan_form_screen.dart';
import 'package:mimos/PR/screen/transaction/penjualan/item/sellin_item.dart';
import 'package:mimos/PR/screen/transaction/penjualan/penjualan_vm.dart';
import 'package:mimos/utils/layout/add_item_screen.dart';
import 'package:mimos/utils/layout/block_transparent_screen.dart';
import 'package:mimos/utils/layout/empty_screen.dart';
import 'package:mimos/utils/widget/button/button_icon_rounded.dart';
import 'package:mimos/utils/widget/my_toast.dart';
import 'package:provider/provider.dart';
import 'package:mimos/helper/extension.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PenjualanScreen extends StatefulWidget {
  @override
  _PenjualanScreenState createState() => _PenjualanScreenState();
}

class _PenjualanScreenState extends State<PenjualanScreen> {
  var _vm = PenjualanVM();

  @override
  Widget build(BuildContext context) {
    final CustomerPR customer = ModalRoute.of(context).settings.arguments;
    _vm.init(context, customer);
    return WillPopScope(
      onWillPop: () async {
        if (_vm.sellin.sellinno == null) {
          MyToast.showToast("NOTA tidak boleh kosong / Pilih Simpan",
              backgroundColor: Colors.red);
          _vm.focusNode.requestFocus();
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("PENJUALAN"),
            shadowColor: Colors.transparent,
          ),
          body: _initProvider(customer),
        ),
      ),
    );
  }

  Widget _initProvider(CustomerPR customer) {
    return ChangeNotifierProvider<PenjualanVM>(
      create: (_) => _vm,
      child: Consumer<PenjualanVM>(
        builder: (c, vm, _) {
          if (_vm.loading)
            return Center(
              child: CircularProgressIndicator(),
            );

          return Stack(
            children: [
              _initWidget(),
              if (!_vm.sellin.needSync)
                BlockTransparentScreen(
                  onTap: () {
                    _dialogBlock();
                  },
                ),
            ],
          );
        },
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

  Widget _nota() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        child: Row(
          children: [
            Text(
              "NOTA: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Expanded(
              child: TextFormField(
                autofocus: false,
                focusNode: _vm.focusNode,
                controller: _vm.etNota,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  isDense: true,
                  suffix: Icon(
                    Icons.edit,
                    size: 18,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _header(),
        _nota(),
        (_vm.listSellinDetail.isEmpty)
            ? Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    AddItemScreen(
                      onTap: () {
                        _clearFocus();
                        _gotoForm();
                      },
                    )
                  ],
                ),
              )
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
                      itemCount: _vm.listSellinDetail.length,
//                      separatorBuilder: (c, i) {
//                        return Divider(
//                          color: Colors.grey,
//                          height: 1.0,
//                        );
//                      },
                      itemBuilder: (c, i) {
                        SellinDetail data = _vm.listSellinDetail[i];
                        return SellinItem(
                          title: data.materialname,
                          subtitle: data.materialid,
                          pac: data.pac,
                          slof: data.slof,
                          bal: data.bal,
                          introdeal: data.qtyintrodeal,
                          price: data.price.toString(),
                          onTap: () {
                            _gotoForm(id: data.id);
                          },
                          onDelete: () {
                            _dialogDeleteItem(data);
                          },
                        );
                      }),
                ),
              ),
      ],
    );
  }

  _clearFocus() {
    _vm.focusNode.unfocus();
  }

  Widget _initWidget() {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        _clearFocus();
      },
      child: Container(
        child: Column(
          children: [
            Expanded(child: _body()),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _vm.amount.toString().toMoney(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonIconRounded(
                    padding: EdgeInsets.fromLTRB(10, 5, 15, 5),
                    icon: Icons.delete_forever,
                    text: "HAPUS",
                    color: Colors.red,
                    onPressed: () {
                      _clearFocus();
                      _dialogDeleteConfirm();
                    },
                  ),
                  ButtonIconRounded(
                    padding: EdgeInsets.fromLTRB(3, 5, 8, 5),
                    icon: Icons.add_circle_outline,
                    text: "ITEM",
                    color: Colors.blue,
                    onPressed: () {
                      _clearFocus();
                      _gotoForm();
                    },
                  ),
                  ButtonIconRounded(
                    padding: EdgeInsets.fromLTRB(10, 5, 15, 5),
                    icon: Icons.save,
                    text: "SIMPAN",
                    color: Colors.green,
                    onPressed: () {
                      _vm.save();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _gotoForm({int id}) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PenjualanFormScreen(
            sellin: _vm.sellin, id: id, priceid: _vm.customer.priceid),
      ),
    );

    if (result != null) {
      _vm.loadSellinHead();
    }
  }

  _dialogDeleteConfirm() {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text("Delete"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hapus Data Penjualan:"),
            SizedBox(
              height: 10,
            ),
            Text(
              "${_vm.customer.name} ?",
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
                Navigator.of(context).pop();
                _vm.deleteAll(_vm.sellin.id);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red[600]))),
        ],
      ),
    );
  }

  _dialogDeleteItem(SellinDetail data) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text("Delete"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hapus Item:"),
            SizedBox(
              height: 10,
            ),
            Text(
              "${data.materialname} ?",
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
                Navigator.of(context).pop();
                _vm.delete(data.id);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red[600]))),
        ],
      ),
    );
  }

  _dialogBlock() {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text("Warning"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tidak bisa merubah data"),
            SizedBox(
              height: 10,
            ),
            Text(
              "Harap hubungi admin untuk merubah data penjualan",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok')),
        ],
      ),
    );
  }
}
