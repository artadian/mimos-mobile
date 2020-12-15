import 'package:flutter/material.dart';
import 'package:mimos/PR/screen/transaction/posm/posm_pr_vm.dart';
import 'package:provider/provider.dart';

class PosmPRScreen extends StatefulWidget {
  @override
  _PosmPRScreenState createState() => _PosmPRScreenState();
}

class _PosmPRScreenState extends State<PosmPRScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("POSM"),
          ),
          body: _initProvider(),
        ));
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<PosmPRVM>(
      create: (_) => PosmPRVM(),
      child: Consumer<PosmPRVM>(
        builder: (c, vm, _) => _initWidget(vm),
      ),
    );
  }

  Widget _initWidget(PosmPRVM vm) {
    return Container();
  }
}