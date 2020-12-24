import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/sellin_detail.dart';
import 'package:mimos/PR/screen/transaction/penjualan/form/penjualan_form_screen.dart';
import 'package:mimos/PR/screen/transaction/penjualan/item/sellin_item.dart';
import 'package:mimos/PR/screen/transaction/penjualan/penjualan_vm.dart';
import 'package:mimos/utils/layout/add_item_screen.dart';
import 'package:mimos/utils/layout/empty_screen.dart';
import 'package:mimos/utils/widget/button/button_icon_rounded.dart';
import 'package:provider/provider.dart';
import 'package:mimos/helper/extension.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PenjualanScreen extends StatefulWidget {
  @override
  _PenjualanScreenState createState() => _PenjualanScreenState();
}

class _PenjualanScreenState extends State<PenjualanScreen> {
  @override
  Widget build(BuildContext context) {
    final CustomerPR customer = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("PENJUALAN"),
          shadowColor: Colors.transparent,
        ),
        body: _initProvider(customer),
      ),
    );
  }

  Widget _initProvider(CustomerPR customer) {
    return ChangeNotifierProvider<PenjualanVM>(
      create: (_) => PenjualanVM()..init(customer),
      child: Consumer<PenjualanVM>(
        builder: (c, vm, _) => _initWidget(vm),
      ),
    );
  }

  Widget _header(PenjualanVM vm) {
    return Container(
      padding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            vm.customer.name ?? "-",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              "${vm.customer.address} ${vm.customer.city}",
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
              vm.customer.tanggalkunjungan.dateView() ?? "-",
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(color: MyPalette.ijoMimos),
    );
  }

  Widget _nota(PenjualanVM vm) {
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
                controller: vm.etNota,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  isDense: true,
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

  Widget _body(PenjualanVM vm) {
    return Column(
      children: [
        _header(vm),
        _nota(vm),
        (vm.listSellinDetail.isEmpty)
            ? Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    AddItemScreen(
                      onTap: () {
                        _gotoForm(vm);
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
                  controller: vm.refreshController,
                  onRefresh: vm.onRefresh,
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: vm.listSellinDetail.length,
                      separatorBuilder: (c, i) {
                        return Divider(
                          color: Colors.grey,
                          height: 1.0,
                        );
                      },
                      itemBuilder: (c, i) {
                        SellinDetail data = vm.listSellinDetail[i];
                        return SellinItem(
                          title: data.materialid,
                          subtitle: data.materialid,
                          pac: data.pac,
                          slof: data.slof,
                          bal: data.bal,
                          introdeal: data.qtyintrodeal,
                          price: data.price.toString(),
                          onTap: () {
                            _gotoForm(vm, id: data.id);
                          },
                          onDelete: () {
                            _dialogDeleteConfirm(vm, data);
                          },
                        );
                      }),
                ),
              ),
      ],
    );
  }

  Widget _initWidget(PenjualanVM vm) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        FocusScope.of(context).unfocus();
        vm.etNota.clear();
      },
      child: Container(
        child: Column(
          children: [
            Expanded(child: _body(vm)),
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
                    "Rp. 1,280,000",
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
                    onPressed: () {},
                  ),
                  ButtonIconRounded(
                    padding: EdgeInsets.fromLTRB(3, 5, 8, 5),
                    icon: Icons.add_circle_outline,
                    text: "ITEM",
                    color: Colors.blue,
                    onPressed: () {
                      _gotoForm(vm);
                    },
                  ),
                  ButtonIconRounded(
                    padding: EdgeInsets.fromLTRB(10, 5, 15, 5),
                    icon: Icons.save,
                    text: "SIMPAN",
                    color: Colors.green,
                    onPressed: () {
                      vm.save();
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

  _gotoForm(PenjualanVM vm, {int id}) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PenjualanFormScreen(
            sellin: vm.sellin, id: id, priceid: vm.customer.priceid),
      ),
    );

    if (result != null) {
      vm.loadSellinHead();
    }
  }

  _dialogDeleteConfirm(PenjualanVM vm, SellinDetail data) {
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
                      vm.delete(data.id);
                      Navigator.of(context).pop();
                    },
                    child: Text('Delete',
                        style: TextStyle(color: Colors.red[600]))),
              ],
            ));
  }
}
