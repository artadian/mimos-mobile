import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Screen/homescreen.dart';
import 'package:mimos/Screen/homescreen_old.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadScreenFL extends StatefulWidget {
  @override
  _UploadScreenFLState createState() => _UploadScreenFLState();
}

class _UploadScreenFLState extends State<UploadScreenFL> {
  SharedPreferences sharedPreferences;
  goToHome() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var root = MaterialPageRoute(
        builder: (context) => new HomeScreen(
              userName: sharedPreferences.getString("username").toString(),
              userId: sharedPreferences.getString("userid").toString(),
              userRoleID: sharedPreferences.getString("userroleid").toString(),
              roleName: sharedPreferences.getString("rolename").toString(),
              salesOfficeId:
                  sharedPreferences.getString("salesofficeid").toString(),
            ));
    Navigator.pushReplacement(context, root);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF54C5F8),
        title: Text("UPLOAD DATA"),
        leading: new Container(),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: () {
                goToHome();
              })
          //   IconButton(
          //     icon: new Icon(Icons.cloud_download),
          //      onPressed: () async {
          //   await _dialogCall(context);
          // },
          //     // onPressed: () {
          //     //   _prosesDownload(context);
          //     // },
          //   ),
        ],
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [MyPalette.ijoMimos, MyPalette.ijoMimos],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight))),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
