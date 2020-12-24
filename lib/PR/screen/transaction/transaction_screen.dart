import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/screen/transaction/penjualan/penjualan_screen.dart';
import 'package:mimos/PR/screen/transaction/transaction_vm.dart';
import 'package:mimos/helper/extension.dart';
import 'package:mimos/utils/widget/button/button_card.dart';
import 'package:mimos/utils/widget/button/button_rect_color.dart';
import 'package:mimos/utils/widget/dialog/default_dialog.dart';
import 'package:mimos/utils/widget/my_toast.dart';
import 'package:mimos/utils/widget/text_icon.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  final CustomerPR customer;

  TransactionScreen(this.customer);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  double widthScreen;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    widthScreen = mediaQueryData.size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Kunjungan Ke Konsumen"),
        ),
        body: _initProvider(widget.customer),
      ),
    );
  }

  Widget _initProvider(CustomerPR customer) {
    return ChangeNotifierProvider<TransactionVM>(
      create: (_) => TransactionVM()..init(customer),
      child: Consumer<TransactionVM>(
        builder: (c, vm, _) => _initWidget(vm),
      ),
    );
  }

  Widget _initWidget(TransactionVM vm) {
    return Container(
      child: ListView(
        children: [
          _header(vm),
          _buildMenuItem(vm),
        ],
      ),
    );
  }

  Widget _header(TransactionVM vm) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            vm.customer.name,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${vm.customer.customerno} [${vm.customer.priceid}]",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
            padding: EdgeInsets.only(top: 10),
            width: double.maxFinite,
            child: Text(
              vm.customer.tanggalkunjungan.dateView(),
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: MyPalette.ijoMimos,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildMenuItem(TransactionVM vm) {
    return Container(
        margin: EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: GridView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: vm.listMenu.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widthScreen ~/ 100,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemBuilder: (c, i) {
              var menu = vm.listMenu[i];
              return ButtonRectColor(
                title: menu.judul,
                color: menu.warna,
                icon: menu.lambang,
                onPressed: () {
                  if (menu.itemid == "103") {
                    if (vm.sellin != null) {
                      _gotoPenjualan(vm);
                    } else {
                      _dialogCreateSellin(vm, vm.customer);
                    }
                  } else {
                    Navigator.of(context).pushNamed(menu.route,
                        arguments: vm.customer);
                  }
                },
              );
            }));
  }

  _dialogCreateSellin(TransactionVM vm, CustomerPR data) {
    print(data.toJson());
    var alert = DefaultDialog(
      title: "Transaksi Penjualan",
      content: Container(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextIcon(
                text: data.name,
                icon: Icons.store,
                fontWeight: FontWeight.bold,
              ),
              TextIcon(
                text: "${data.customerno} [${data.priceid}]",
                icon: Icons.padding,
              ),
              TextIcon(
                text: data.tanggalkunjungan.dateView(),
                icon: Icons.calendar_today_rounded,
              ),
              TextIcon(
                text: "${data.address} ${data.city}",
                icon: Icons.location_on,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ButtonCard(
                      elevation: 2.0,
                      paddingText: 10,
                      borderRadius: 5,
                      child: CircleAvatar(
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.red,
                      ),
                      childBottom: Text(
                        "Tidak Order",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _dialogReasonChoice(vm, data);
                      },
                    ),
                  ),
                  Expanded(
                    child: ButtonCard(
                      elevation: 2.0,
                      paddingText: 10,
                      borderRadius: 5,
                      child: CircleAvatar(
                        child: Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                      ),
                      childBottom: Text(
                        "Order Toko",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        vm.saveSellin();
                        Navigator.of(context).pop();
                        _gotoPenjualan(vm);
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _gotoPenjualan(TransactionVM vm) async {
    var result = await
    Navigator.of(context).pushNamed(PENJUALAN_SCREEN_PR,
        arguments: vm.customer);

    print("result: $result");
    if (result != null) {
      vm.loadSellinHead();
    }
  }

  _dialogReasonChoice(TransactionVM vm, CustomerPR data) {
    AlertDialog alert = AlertDialog(
      title: Text("Pilih Alasan"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: vm.listReason.length,
              itemBuilder: (c, i) {
                var reason = vm.listReason[i];
                return ListTile(
                  title: Text(reason.lookupdesc),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    vm.saveSellin(idReason: reason.lookupid);
                  },
                );
              })
        ],
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"))
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
