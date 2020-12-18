import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mimos/PR/screen/download/download_pr_vm.dart';
import 'package:mimos/utils/widget/circle_icon.dart';
import 'package:mimos/utils/widget/textfield/text_input_field.dart';
import 'package:provider/provider.dart';

class DownloadPRScreen extends StatefulWidget {
  @override
  _DownloadPRScreenState createState() => _DownloadPRScreenState();
}

class _DownloadPRScreenState extends State<DownloadPRScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Download Data"),
      ),
      body: _initProvider(),
    ));
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<DownloadPRVM>(
      create: (_) => DownloadPRVM()..init(),
      child: Consumer<DownloadPRVM>(
        builder: (c, vm, _) {
          return _initWidget(vm);
        },
      ),
    );
  }

  Widget _initWidget(DownloadPRVM vm) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          child: TextInputField(
            readOnly: true,
            controller: vm.etDate,
            labelText: "Pilih Tanggal Download",
            onTap: () {
              _selectDate(vm);
            },
          ),
        ),
        Expanded(
            child: Container(
          child: ListView.separated(
            itemCount: vm.listItemDownload.length,
            separatorBuilder: (c, i) {
              return Divider(
                color: Colors.grey,
                height: 1.0,
              );
            },
            itemBuilder: (c, i) {
              print("status: ${vm.listItemDownload[i].status}");
              var menu = vm.listItemDownload[i];
              return ListTile(
                leading: CircleIcon(
                  menu.icon,
                  color: menu.color,
                  backgroundColor: Colors.white,
                ),
                title: Text(menu.title),
                subtitle: Text("Total Data: ${menu.countData}"),
                trailing: menu.status == 0
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ))
                    : menu.status == 1
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : menu.status == -1
                            ? Icon(
                                Icons.error,
                                color: Colors.red,
                              )
                            : SizedBox(),
              );
            },
          ),
        )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: MaterialButton(
            padding: EdgeInsets.fromLTRB(18, 12, 22, 12),
            onPressed: () {
              if (!vm.loading) {
                vm.downloadAll();
              }
            },
            elevation: 6,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                vm.loading
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
                  vm.loading ? "Downloading Data..." : "Download Semua Data",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
            color: vm.loading ? Colors.grey : Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(DownloadPRVM vm) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: vm.selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != vm.selectedDate) {
      vm.etDate.text = DateFormat("dd MMMM yyyy").format(picked);
    }
  }
}
