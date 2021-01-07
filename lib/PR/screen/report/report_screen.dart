import 'package:flutter/material.dart';
import 'package:mimos/PR/model/sellin_detail.dart';
import 'package:mimos/PR/screen/report/item/report_box_item.dart';
import 'package:mimos/PR/screen/report/item/report_sellin_item.dart';
import 'package:mimos/PR/screen/report/item/report_visit_item.dart';
import 'package:mimos/PR/screen/report/report_vm.dart';
import 'package:mimos/helper/sellin_helper.dart';
import 'package:mimos/utils/layout/empty_screen.dart';
import 'package:provider/provider.dart';
import 'package:mimos/helper/extension.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  var _vm = ReportVM();

  @override
  void initState() {
    super.initState();
    _vm.init();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Ringkasan"),
      ),
      body: _initProvider(),
    ));
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<ReportVM>(
      create: (_) => _vm,
      child: Consumer<ReportVM>(
        builder: (c, vm, _) {
          return _initWidget();
        },
      ),
    );
  }

  _initWidget() {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "RENCANA KUNJUNGAN",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              _vm.kunjungan.toString(),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: ReportVisitItem(
                title: "Telah Dikunjungi",
                value: _vm.dikunjungi.toString(),
                color: Colors.green,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ReportVisitItem(
                title: "Tidak Dikunjungi",
                value: _vm.tidakDikunjungi.toString(),
                color: Colors.red,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ReportVisitItem(
                title: "Tanpa Penjualan",
                value: _vm.tanpaPenjualan.toString(),
                color: Colors.orange,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: ReportBoxItem(
              title: "Nota Penjualan",
              value: _vm.notaPenjualan.toString(),
            )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: ReportBoxItem(
              title: "Total Pac Terjual",
                  value: _vm.totalPacTerjual.toString(),
            )),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        _totalPenjualan(),
        SizedBox(
          height: 10,
        ),
        (_vm.listSellinDetail.isEmpty)
        ? EmptyScreen()
        : ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: _vm.listSellinDetail.length,
            itemBuilder: (c, i) {
              SellinDetail data = _vm.listSellinDetail[i];
              return ReportSellinItem(
                elevation: 6,
                title: data.materialname,
                subtitle: data.materialid,
                pac: data.pac,
                slof: data.slof,
                bal: data.bal,
                introdeal: data.qtyintrodeal,
                price: data.price.toString().toMoney(),
                totalPrice: data.sellinvalue.toString().toMoney(),
              );
            })
      ],
    );
  }

  Widget _totalPenjualan() {
    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.attach_money, color: Colors.white),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5)),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Penjualan",
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  "Rp. " + _vm.totalPenjualan.toString().toMoney(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
