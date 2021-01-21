import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/PR/model/trial.dart';
import 'package:mimos/PR/screen/trial/item/trial_item.dart';
import 'package:mimos/PR/screen/trial/trial_vm.dart';
import 'package:mimos/utils/layout/empty_screen.dart';
import 'package:mimos/utils/widget/button/button_icon_rounded.dart';
import 'package:mimos/utils/widget/text_icon.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TrialScreen extends StatefulWidget {
  @override
  _TrialScreenState createState() => _TrialScreenState();
}

class _TrialScreenState extends State<TrialScreen> {
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
      create: (_) => TrialVM()..init(),
      child: Consumer<TrialVM>(
        builder: (c, vm, _) => _initWidget(vm),
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

  Widget _header(TrialVM vm) {
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
              text: "20,000,000",
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
                      value: "100",
                      icon: Icons.all_inbox,
                      iconColor: Colors.red),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: _headerItem(
                      title: "Pack Sold",
                      value: "200",
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

  Widget _body(TrialVM vm) {
    return Column(
      children: [
        _header(vm),
        (vm.listTrial.isEmpty)
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
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: vm.listTrial.length,
                      itemBuilder: (c, i) {
                        Trial data = vm.listTrial[i];
                        return TrialItem(
                          title: data.name,
                          subtitle1: data.materialname,
                          subtitle2: data.qty.toString(),
                        );
                      }),
                ),
              ),
      ],
    );
  }

  Widget _initWidget(TrialVM vm) {
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
                Navigator.of(context).pushNamed(TRIAL_FROM_SCREEN_PR);
              },
            ),
          )
        ],
      ),
    );
  }
}
