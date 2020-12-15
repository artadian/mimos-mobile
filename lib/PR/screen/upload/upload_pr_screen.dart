import 'package:flutter/material.dart';
import 'package:mimos/PR/screen/upload/upload_pr_vm.dart';
import 'package:provider/provider.dart';

class UploadPRScreen extends StatefulWidget {
  @override
  _UploadPRScreenState createState() => _UploadPRScreenState();
}

class _UploadPRScreenState extends State<UploadPRScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Upload Data"),
      ),
      body: _initProvider(),
    ));
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<UploadPRVM>(
      create: (_) => UploadPRVM(),
      child: Consumer<UploadPRVM>(
        builder: (c, vm, _) => _initWidget(vm),
      ),
    );
  }

  Widget _initWidget(UploadPRVM vm) {
    return Container();
  }
}
