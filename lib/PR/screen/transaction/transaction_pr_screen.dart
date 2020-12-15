import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/PR/screen/transaction/transaction_pr_vm.dart';
import 'package:mimos/utils/widget/button/button_rect_color.dart';
import 'package:provider/provider.dart';

class TransactionPRScreen extends StatefulWidget {
  @override
  _TransactionPRScreenState createState() => _TransactionPRScreenState();
}

class _TransactionPRScreenState extends State<TransactionPRScreen> {
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
        body: _initProvider(),
      ),
    );
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<TransactionPRVM>(
      create: (_) => TransactionPRVM()..init(),
      child: Consumer<TransactionPRVM>(
        builder: (c, vm, _) => _initWidget(vm),
      ),
    );
  }

  Widget _initWidget(TransactionPRVM vm) {
    return Container(
      child: ListView(
        children: [
          _header(vm),
          _buildMenuItem(vm),
        ],
      ),
    );
  }

  Widget _header(TransactionPRVM vm) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "ARJUN",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "3320000013 [Z2]",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              "Jl. Rungkut Asri Utara 5/8",
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
              "Senin, 20 Agustus 2020",
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

  Widget _buildMenuItem(TransactionPRVM vm) {
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
                  Navigator.of(context).pushNamed(menu.route);
                },
              );
            }));
  }
}
