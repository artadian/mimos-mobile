import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mimos/PR/model/default/download_model.dart';
import 'package:mimos/PR/screen/download/download_vm.dart';
import 'package:mimos/utils/widget/circle_icon.dart';
import 'package:mimos/utils/widget/textfield/text_input_field.dart';
import 'package:provider/provider.dart';

class DownloadScreen extends StatefulWidget {
  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  var _vm = DownloadVM();

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
        title: Text("Download Data"),
        actions: [
          IconButton(
              icon: Icon(Icons.delete_sweep),
              onPressed: () {
                _dialogClearDB();
              })
        ],
      ),
      body: _initProvider(),
    ));
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<DownloadVM>(
      create: (_) => _vm,
      child: Consumer<DownloadVM>(
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
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          child: TextInputField(
            readOnly: true,
            controller: _vm.etDate,
            labelText: "Pilih Tanggal Download",
            onTap: () {
              _selectDate();
            },
          ),
        ),
        Expanded(
            child: Container(
          child: _vm.downloads.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemCount: _vm.downloads.length,
                  separatorBuilder: (c, i) {
                    return Divider(
                      color: Colors.grey,
                      height: 1.0,
                    );
                  },
                  itemBuilder: (c, i) {
                    print("status: ${_vm.downloads[i].status}");
                    var data = _vm.downloads[i];
                    return ListTile(
                      leading: CircleIcon(
                        data.icon,
                        color: data.color,
                        backgroundColor: Colors.white,
                      ),
                      title: Text(data.title),
                      subtitle: Text("Total Data: ${data.countData}"),
                      trailing: data.status == DOWNLOAD_STATUS.LOADING
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ))
                          : data.status == DOWNLOAD_STATUS.SUCCESS
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green[600],
                                )
                              : data.status == DOWNLOAD_STATUS.FAILED
                                  ? Icon(
                                      Icons.error,
                                      color: Colors.red[600],
                                    )
                                  : SizedBox(),
                    );
                  },
                ),
        )),
        Divider(color: Colors.grey, height: 2,),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: MaterialButton(
            padding: EdgeInsets.fromLTRB(18, 12, 22, 12),
            onPressed: () {
              if (!_vm.loading) {
                _vm.downloadAll();
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
                        Icons.download_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  _vm.loading ? "Downloading Data..." : "Download Semua Data",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
            color: _vm.loading ? Colors.grey : Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _vm.selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != _vm.selectedDate) {
      _vm.selectDate(picked);
    }
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

  _dialogClearDB() {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text("Truncate"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Semua data di HP akan di hapus permanent. Hapus semua data ?",
              ),
              SizedBox(height: 10,),
              Text(
                "Enter Password:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _vm.password,
              )
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel')),
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                _vm.clearDb();
              },
              child: Text('Hapus', style: TextStyle(color: Colors.red[600]))),
        ],
      ),
    );
  }
}
