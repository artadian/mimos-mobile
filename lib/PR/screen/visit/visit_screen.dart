import 'package:flutter/material.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/screen/transaction/transaction_screen.dart';
import 'package:mimos/PR/screen/visit/item/visit_item.dart';
import 'package:mimos/PR/screen/visit/visit_vm.dart';
import 'package:mimos/helper/extension.dart';
import 'package:mimos/utils/layout/empty_screen.dart';
import 'package:mimos/utils/widget/button/button_card.dart';
import 'package:mimos/utils/widget/dialog/default_dialog.dart';
import 'package:mimos/utils/widget/text_icon.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisitScreen extends StatefulWidget {
  @override
  _VisitScreenState createState() => _VisitScreenState();
}

class _VisitScreenState extends State<VisitScreen> {
  var _vm = VisitVM();

  @override
  void initState() {
    super.initState();
    _vm.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Daftar Kunjungan"),
        ),
        body: _initProvider(),
      ),
    );
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<VisitVM>(
      create: (_) => _vm,
      child: Consumer<VisitVM>(
        builder: (c, vm, _) {
          return _initWidget();
        },
      ),
    );
  }

  Widget _initWidget() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _vm.etSearch,
            decoration: InputDecoration(
                hintText: "Search", suffixIcon: Icon(Icons.search)),
            onChanged: (val) {
              _vm.loadListVisit(search: val);
            },
          ),
        ),
        (_vm.listCustomer.isEmpty)
            ? EmptyScreen()
            : Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  header: WaterDropHeader(
                    waterDropColor: Colors.blue,
                  ),
                  controller: _vm.refreshController,
                  onRefresh: _vm.onRefresh,
                  child: ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      itemCount: _vm.listCustomer.length,
                      itemBuilder: (c, i) {
                        var data = _vm.listCustomer[i];
                        return VisitItem(
                          leading: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.person_pin,
                                color: (data.idvisit != null &&
                                        (data.notvisitreason != null &&
                                            data.notvisitreason != "0"))
                                    ? Colors.red
                                    : data.idvisit != null
                                        ? Colors.green
                                        : Colors.blue,
                                size: 32,
                              )),
                          title: data.name,
                          subtitle1: "${data.customerno} [${data.priceid}]",
                          subtitle2: data.tanggalkunjungan.dateView(),
                          footer1: data.address,
                          footer2: data.city,
                          onTap: () {
                            if (data.idvisit != null) {
                              if (data.notvisitreason != null &&
                                  data.notvisitreason != "0") {
                                _dialogCreateVisit(data);
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TransactionScreen(data)),
                                );
                              }
                            } else {
                              _dialogCreateVisit(data);
                            }
                          },
                        );
                      }),
                ),
              ),
      ],
    );
  }

  _dialogCreateVisit(CustomerPR data) {
    print(data.toJsonView());
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
                        _dialogReasonChoice(data);
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
                      onPressed: () async {
                        Navigator.of(context).pop();
                        _vm.saveVisit(data);
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

  _dialogReasonChoice(CustomerPR data) {
    AlertDialog alert = AlertDialog(
      title: Text("Pilih Alasan"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: _vm.listReason.length,
            itemBuilder: (c, i) {
              var reason = _vm.listReason[i];
              return ListTile(
                title: Text(reason.lookupdesc),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  _vm.saveVisit(data, idReason: reason.lookupid);
                },
              );
            },
          )
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
