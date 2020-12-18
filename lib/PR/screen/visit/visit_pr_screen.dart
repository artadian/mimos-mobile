import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/screen/transaction/transaction_pr_screen.dart';
import 'package:mimos/PR/screen/visit/item/visit_item.dart';
import 'package:mimos/PR/screen/visit/visit_pr_vm.dart';
import 'package:mimos/utils/widget/button/button_card.dart';
import 'package:mimos/utils/widget/circle_icon.dart';
import 'package:mimos/utils/widget/dialog/default_dialog.dart';
import 'package:mimos/utils/widget/text_icon.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mimos/helper/extension.dart';

class VisitPRScreen extends StatefulWidget {
  @override
  _VisitPRScreenState createState() => _VisitPRScreenState();
}

class _VisitPRScreenState extends State<VisitPRScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Daftar Kunjungan"),
      ),
      body: _initProvider(),
    ));
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<VisitPRVM>(
      create: (_) => VisitPRVM()..init(),
      child: Consumer<VisitPRVM>(
        builder: (c, vm, _) {
          return _initWidget(vm);
        },
      ),
    );
  }

  Widget _initWidget(VisitPRVM vm) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: vm.etSearch,
            decoration: InputDecoration(
                hintText: "Search", suffixIcon: Icon(Icons.search)),
            onChanged: (val){
              vm.loadListVisit(search: val);
            },
          ),
        ),
        Expanded(
          child: SmartRefresher(
              enablePullDown: true,
              header: WaterDropHeader(
                waterDropColor: Colors.blue,
              ),
              controller: vm.refreshController,
              onRefresh: vm.onRefresh,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  itemCount: vm.listCustomer.length,
                  itemBuilder: (c, i) {
                    var data = vm.listCustomer[i];
                    return VisitItem(
                      leading: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.person_pin,
                            color: Colors.blue,
                            size: 32,
                          )),
                      title: data.name,
                      subtitle1: "${data.customerno} [${data.priceid}]",
                      subtitle2: data.tanggalkunjungan.dateView(),
                      footer1: data.address,
                      footer2: data.city,
                      onTap: () {
                        _dialogCreateVisit(vm, data);
                      },
                    );
                  })),
        ),
      ],
    );
  }

  _dialogCreateVisit(VisitPRVM vm, CustomerPR data) {
    var alert = DefaultDialog(
      title: "Mulai Kunjungan",
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
                        "Batal Kunjungan",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _dialogReasonChoice(vm);
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
                        "Kunjungi Toko",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionPRScreen()),
                        );
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

  _dialogReasonChoice(VisitPRVM vm) {
    AlertDialog alert = AlertDialog(
      title: Text("Pilih Alasan"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: vm.listReason.length,
              itemBuilder: (c, i) {
                var reason = vm.listReason[i].lookupdesc;
                return ListTile(
                  title: Text(reason),
                  onTap: () {},
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
