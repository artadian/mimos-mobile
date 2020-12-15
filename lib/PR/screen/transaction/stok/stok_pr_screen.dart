import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/PR/screen/transaction/stok/item/stok_item.dart';
import 'package:mimos/PR/screen/transaction/stok/stok_pr_vm.dart';
import 'package:mimos/utils/widget/button/button_icon_rounded.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StokPRScreen extends StatefulWidget {
  @override
  _StokPRScreenState createState() => _StokPRScreenState();
}

class _StokPRScreenState extends State<StokPRScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cek STOCK"),
          shadowColor: Colors.transparent,
        ),
        body: _initProvider(),
      ),
    );
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<StokPRVM>(
      create: (_) => StokPRVM(),
      child: Consumer<StokPRVM>(
        builder: (c, vm, _) => _initWidget(vm),
      ),
    );
  }

  Widget _header(StokPRVM vm) {
    return Container(
      padding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "ARJUN",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
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
            padding: EdgeInsets.only(top: 5),
            width: double.maxFinite,
            child: Text(
              "Senin, 20 Agustus 2020",
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(color: MyPalette.ijoMimos),
    );
  }

  Widget _body(StokPRVM vm) {
    return Column(
      children: [
        _header(vm),
        Expanded(child: SmartRefresher(
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
                itemCount: 10,
                separatorBuilder: (c, i){
                  return Divider(color: Colors.grey, height: 1.0,);
                },
                itemBuilder: (c, i) {
                  return StokItem(
                    title: "WDAN12 16500 385 2019 JI",
                    subtitle: "9000001127",
                    slof: 10,
                    onTap: (){},
                    onDelete: (){},
                  );
                }))),
      ],
    );
  }

  Widget _initWidget(StokPRVM vm) {
    return Container(
      child: Stack(
        children: [
          Expanded(child: _body(vm)),
          Positioned(
            bottom: 16,
            right: 16,
            child: ButtonIconRounded(
              icon: Icons.add_circle_outline,
              text: "Tambah Item",
              onPressed: () {
                Navigator.of(context).pushNamed(STOK_FROM_SCREEN_PR);
              },
            ),
          )
        ],
      ),
    );
  }
}
