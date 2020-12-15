import 'package:flutter/material.dart';
import 'package:mimos/PR/screen/download/download_pr_vm.dart';
import 'package:mimos/utils/widget/circle_icon.dart';
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
      create: (_) => DownloadPRVM(),
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
        Expanded(
            child: Container(
          child: ListView(
            children: ListTile.divideTiles(
              context: context,
              color: Colors.grey,
              tiles: [
                ListTile(
                  leading: CircleIcon(
                    Icons.person,
                    color: Colors.red,
                    backgroundColor: Colors.white,
                  ),
                  title: Text("Download Kunjungan"),
                  subtitle: Text("Total Data: 20"),
                ),
                ListTile(
                  leading: CircleIcon(
                    Icons.widgets,
                    color: Colors.green,
                    backgroundColor: Colors.white,
                  ),
                  title: Text("Download Item Barang"),
                  subtitle: Text("Total Data: 20"),
                ),
                ListTile(
                  leading: CircleIcon(
                    Icons.monetization_on,
                    color: Colors.blue,
                    backgroundColor: Colors.white,
                  ),
                  title: Text("Download Harga Barang"),
                  subtitle: Text("Total Data: 20"),
                ),
                ListTile(
                  leading: CircleIcon(
                    Icons.assignment_turned_in,
                    color: Colors.orange,
                    backgroundColor: Colors.white,
                  ),
                  title: Text("Download Introdeal"),
                  subtitle: Text("Total Data: 20"),
                ),
                ListTile(
                  leading: CircleIcon(
                    Icons.assignment_ind,
                    color: Colors.purple,
                    backgroundColor: Colors.white,
                  ),
                  title: Text("Download Kompetitor"),
                  subtitle: Text("Total Data: 20"),
                ),
                ListTile(
                  leading: CircleIcon(
                    Icons.margin,
                    color: Colors.cyan,
                    backgroundColor: Colors.white,
                  ),
                  title: Text("Download Material"),
                  subtitle: Text("Total Data: 20"),
                ),
                ListTile(
                  leading: CircleIcon(
                    Icons.album,
                    color: Colors.lime,
                    backgroundColor: Colors.white,
                  ),
                  title: Text("Download Lookup"),
                  subtitle: Text("Total Data: 20"),
                ),
              ],
            ).toList(),
          ),
        )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: MaterialButton(
            padding: EdgeInsets.fromLTRB(18, 12, 22, 12),
            onPressed: () {},
            elevation: 6,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.download_rounded,
                  size: 18,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Download Semua Data",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
            color: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
          ),
        ),
      ],
    );
  }
}
