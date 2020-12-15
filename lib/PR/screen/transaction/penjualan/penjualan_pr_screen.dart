import 'package:flutter/material.dart';
import 'package:mimos/PR/screen/transaction/penjualan/penjualan_pr_vm.dart';
import 'package:provider/provider.dart';

class PenjualanPRScreen extends StatefulWidget {
  @override
  _PenjualanPRScreenState createState() => _PenjualanPRScreenState();
}

class _PenjualanPRScreenState extends State<PenjualanPRScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Penjualan"),
          ),
          body: _initProvider(),
        ));
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<PenjualanPRVM>(
      create: (_) => PenjualanPRVM(),
      child: Consumer<PenjualanPRVM>(
        builder: (c, vm, _) => _initWidget(vm),
      ),
    );
  }

  Widget _initWidget(PenjualanPRVM vm) {
    return Container();
  }
}