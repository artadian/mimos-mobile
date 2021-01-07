import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/stock_detail.dart';
import 'package:mimos/PR/screen/transaction/stok/form/stock_form_screen.dart';
import 'package:mimos/PR/screen/transaction/stok/item/stock_item.dart';
import 'package:mimos/PR/screen/transaction/stok/stock_vm.dart';
import 'package:mimos/helper/extension.dart';
import 'package:mimos/utils/layout/empty_screen.dart';
import 'package:mimos/utils/widget/button/button_icon_rounded.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StokScreen extends StatefulWidget {
  @override
  _StokScreenState createState() => _StokScreenState();
}

class _StokScreenState extends State<StokScreen> {
  @override
  Widget build(BuildContext context) {
    final CustomerPR customer = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cek STOCK"),
          shadowColor: Colors.transparent,
        ),
        body: _initProvider(customer),
      ),
    );
  }

  Widget _initProvider(CustomerPR customer) {
    return ChangeNotifierProvider<StokVM>(
      create: (_) => StokVM()..init(customer),
      child: Consumer<StokVM>(
        builder: (c, vm, _) => _initWidget(vm),
      ),
    );
  }

  Widget _header(StokVM vm) {
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

  Widget _body(StokVM vm) {
    return Column(
      children: [
        _header(vm),
        (vm.listStockDetail.isEmpty)
            ? EmptyScreen()
            : Expanded(
                child: SmartRefresher(
                  physics: ScrollPhysics(),
                  enablePullDown: true,
                  header: WaterDropHeader(
                    waterDropColor: Colors.blue,
                  ),
                  controller: vm.refreshController,
                  onRefresh: vm.onRefresh,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: vm.listStockDetail.length,
//                      separatorBuilder: (c, i) {
//                        return Divider(
//                          color: Colors.grey,
//                          height: 1.0,
//                        );
//                      },
                      itemBuilder: (c, i) {
                        StockDetail data = vm.listStockDetail[i];
                        return StokItem(
                          title: data.materialname,
                          subtitle: data.materialid,
                          pac: data.pac,
                          slof: data.slof,
                          bal: data.bal,
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

  Widget _initWidget(StokVM vm) {
    return Container(
      child: Stack(
        children: [
          _body(vm),
          Positioned(
            bottom: 16,
            right: 16,
            child: ButtonIconRounded(
              icon: Icons.add_circle_outline,
              text: "Tambah Item",
              onPressed: () {
                _gotoForm(vm);
              },
            ),
          )
        ],
      ),
    );
  }

  _gotoForm(StokVM vm, {int id}) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StokFormScreen(
                stock: vm.stock, id: id, priceid: vm.customer.priceid)));

    print("result: $result");
    if (result != null) {
      vm.loadStockHead();
    }
  }

  _dialogDeleteConfirm(StokVM vm, StockDetail data) {
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
