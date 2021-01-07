import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/PR/screen/trial/trial_pr_vm.dart';
import 'package:mimos/utils/widget/button/button_icon_rounded.dart';
import 'package:mimos/utils/widget/text_icon.dart';
import 'package:provider/provider.dart';

class TrialPRScreen extends StatefulWidget {
  @override
  _TrialPRScreenState createState() => _TrialPRScreenState();
}

class _TrialPRScreenState extends State<TrialPRScreen> {
  var _vm = TrialPRVM();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Trial"),
        shadowColor: Colors.transparent,
      ),
      floatingActionButton: ButtonIconRounded(
          icon: Icons.add_circle_outline,
          text: "Tambah Item",
          onPressed: () {
            Navigator.of(context).pushNamed(TRIAL_FROM_SCREEN_PR);
          },
        ),
      body: _initProvider(),
    ));
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<TrialPRVM>(
      create: (_) => _vm,
      child: Consumer<TrialPRVM>(
        builder: (c, vm, _) => _initWidget(),
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

  Widget _header() {
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
                SizedBox(width: 10,),
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

  Widget _initWidget() {
    return Container(
      child: ListView(
        children: [
          _header(),
          ListView.builder(
              itemCount: 15,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (c, i) {
                return ListTile(
                  title: Text("Test $i"),
                );
              })
        ],
      ),
    );
  }
}
