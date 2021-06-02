import 'package:flutter/material.dart';
import 'package:mimos/PR/model/app_version.dart';
import 'package:mimos/PR/repo/auth_repo.dart';
import 'package:mimos/Screen/homescreen.dart';
import 'package:mimos/Screen/loginscreen.dart';
import 'package:mimos/helper/session_manager.dart';
import 'package:mimos/utils/widget/dialog/default_dialog.dart';
import 'package:package_info/package_info.dart';
import 'package:mimos/helper/extension.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreenVM with ChangeNotifier {
  var authRepo = AuthRepo();
  PackageInfo packageInfo;
  BuildContext context;

  init(BuildContext context) async {
    this.context = context;
    packageInfo = await PackageInfo.fromPlatform();
    if (await isLogin()) {
      // CEK VERSION
      cekVersionApps();
    } else {
      // LOGIN
      var root = MaterialPageRoute(builder: (context) => LogInScreen());
      Navigator.pushReplacement(context, root);
    }
  }

  Future<bool> isLogin() async {
    if (await session.getUserId() == null) {
      return false;
    } else {
      return true;
    }
  }

  cekVersionApps() async {
    var res = await authRepo.appVersion(await session.getUserId());
    if (res.status) {
      print("$runtimeType: ${res.data.toJson()}");
      if (res.data.version_code > packageInfo.version.toInt(defaultVal: 0)) {
        _dialogNewApps(res.data);
      } else {
        _gotoHome();
      }
    } else {
      _gotoHome();
    }
  }

  _dialogNewApps(AppVersion data) {
    var alert = DefaultDialog(
      title: "Update Aplikasi",
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      withClose: false,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Apps Version: ${data.version_name}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5,),
            Text(
              "New Update:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 3,),
            Text(data.release_log),
          ],
        ),
      ),
      actions: [
        if (!data.force_update)
          OutlineButton(
            onPressed: () {
              Navigator.of(context).pop();
              _gotoHome();
            },
            child: Text(
              "CLOSE",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        RaisedButton(
          onPressed: () {
            _launchDownload(data.link);
          },
          child: Text("UPDATE"),
          color: Colors.green,
        ),
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _launchDownload(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _gotoHome();
    }
  }

  _gotoHome(){
    var root = MaterialPageRoute(builder: (context) => HomeScreen());
    Navigator.pushReplacement(context, root);
  }

}
