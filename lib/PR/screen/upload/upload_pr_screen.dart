import 'package:flutter/material.dart';
import 'package:mimos/PR/screen/upload/upload_pr_vm.dart';
import 'package:provider/provider.dart';

class UploadPRScreen extends StatefulWidget {
  @override
  _UploadPRScreenState createState() => _UploadPRScreenState();
}

class _UploadPRScreenState extends State<UploadPRScreen> {
  var _vm = UploadPRVM();

  @override
  void initState() {
    super.initState();
  }

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
      create: (_) => _vm,
      child: Consumer<UploadPRVM>(
        builder: (c, vm, _) => _initWidget(),
      ),
    );
  }

  Widget _initWidget() {
    return Container(
      child: RaisedButton(
        child: Text("Upload"),
        onPressed: (){
          _vm.uploadVisit();
        },
      ),
    );
  }
}
