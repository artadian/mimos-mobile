import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/PR/screen/transaction/transaction_pr_screen.dart';
import 'package:mimos/PR/screen/visit/item/visit_item.dart';
import 'package:mimos/PR/screen/visit/visit_pr_vm.dart';
import 'package:mimos/utils/widget/button/button_card.dart';
import 'package:mimos/utils/widget/circle_icon.dart';
import 'package:mimos/utils/widget/dialog/default_dialog.dart';
import 'package:mimos/utils/widget/text_icon.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
      create: (_) => VisitPRVM(),
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
            decoration: InputDecoration(
                hintText: "Search", suffixIcon: Icon(Icons.search)),
            onChanged: (val) {},
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
                  itemCount: 10,
                  itemBuilder: (c, i) {
                    return VisitItem(
                      leading: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.person_pin,
                            color: Colors.blue,
                            size: 32,
                          )),
                      title: "ANDITA",
                      subtitle1: "3320000013 [Z2]",
                      subtitle2: "Senin, 20 Desember 2020",
                      footer1: "perum Wisma Kedungasem H/1",
                      footer2: "SURABAYA",
                      onTap: () {
                        _dialogCreateVisit(context);
                      },
                    );
                  })),
        ),
      ],
    );
  }

  _dialogCreateVisit(BuildContext context) {
    var alert = DefaultDialog(
      title: "Mulai Kunjungan",
      content: Container(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextIcon(
                text: "ANDITA",
                icon: Icons.store,
                fontWeight: FontWeight.bold,
              ),
              TextIcon(
                text: "3320000013 [Z2]",
                icon: Icons.padding,
              ),
              TextIcon(
                text: "Senin, 20 Desember 2020",
                icon: Icons.calendar_today_rounded,
              ),
              TextIcon(
                text: "Perum Wisma Kedungasem H/1 SURABAYA",
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
                        _dialogReasonChoice(context);
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

  _dialogReasonChoice(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Pilih Alasan"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (c, i) {
                return ListTile(
                  title: Text("Toko Sudah tidak ada $i"),
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
