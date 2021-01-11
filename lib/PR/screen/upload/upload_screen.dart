import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mimos/PR/model/default/upload_model.dart';
import 'package:mimos/PR/screen/upload/upload_vm.dart';
import 'package:mimos/utils/widget/circle_icon.dart';
import 'package:mimos/utils/widget/textfield/text_input_field.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  var _vm = UploadVM();

  @override
  void initState() {
    super.initState();
    _vm.init();
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
    return ChangeNotifierProvider<UploadVM>(
      create: (_) => _vm,
      child: Consumer<UploadVM>(
        builder: (c, vm, _) {
          return _initWidget();
        },
      ),
    );
  }

  Widget _initWidget() {
    return Column(
      children: [
        Expanded(
            child: Container(
          child: _vm.uploads.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemCount: _vm.uploads.length,
                  separatorBuilder: (c, i) {
                    return Divider(
                      color: Colors.grey,
                      height: 1.0,
                    );
                  },
                  itemBuilder: (c, i) {
                    print("status: ${_vm.uploads[i].status}");
                    var data = _vm.uploads[i];
                    return ListTile(
                      leading: CircleIcon(
                        data.icon,
                        color: data.color,
                        backgroundColor: Colors.white,
                      ),
                      title: Text(data.getGroup()),
                      subtitle: Text(
                        data.message,
                        style: TextStyle(
                            fontSize: 12,
                            color: data.status == UPLOAD_STATUS.NEED_SYNC
                                ? Colors.red[700]
                                : (data.status == UPLOAD_STATUS.DONE || data.status == UPLOAD_STATUS.EMPTY)
                                    ? Colors.green[700]
                                    : Colors.grey[700]),
                      ),
                      trailing: data.status == UPLOAD_STATUS.LOADING
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ))
                          : data.status == UPLOAD_STATUS.SUCCESS
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green[600],
                                )
                              : data.status == UPLOAD_STATUS.FAILED
                                  ? Icon(
                                      Icons.error,
                                      color: Colors.red[600],
                                    )
                                  : SizedBox(),
                    );
                  },
                ),
        )),
        Divider(
          color: Colors.grey,
          height: 1,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: MaterialButton(
            padding: EdgeInsets.fromLTRB(18, 12, 22, 12),
            onPressed: () {
              if (!_vm.loading) {
                _vm.upload();
              }
            },
            elevation: 6,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _vm.loading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ))
                    : Icon(
                        Icons.cloud_upload,
                        size: 18,
                        color: Colors.white,
                      ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  _vm.loading ? "Uploading Data..." : "Upload Semua Data",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
            color: _vm.loading ? Colors.grey : Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }

  _dialogError(String message) {
    AlertDialog alert = AlertDialog(
      title: Text("Error Download"),
      content: Container(
        child: Text(message),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"))
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