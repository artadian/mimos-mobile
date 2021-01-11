import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Screen/home_screen_old.dart';
import 'package:mimos/Screen/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mimos/Screen/homescreen_old.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  //var x = true;

  AnimationController animationController;
  Animation<double> animation;
  SharedPreferences sharedPreferences;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // cek apakah sudah login
    //Navigator.of(context).pushReplacementNamed(LOGIN_SCREEN);
    //Navigator.of(context).pushReplacementNamed(HOME_SCREEN);
    checkLoginStatus();
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("userid") == null) {
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (BuildContext context) => LOGIN_SCREEN()),
      //     (Route<dynamic> route) => false);
      Navigator.of(context).pushReplacementNamed(LOGIN_SCREEN);
    } else {
      var root = MaterialPageRoute(
          builder: (context) => new HomeScreen(
                userName: sharedPreferences.getString("username").toString(),
                userId: sharedPreferences.getString("userid").toString(),
                userRoleID:
                    sharedPreferences.getString("userroleid").toString(),
                roleName: sharedPreferences.getString("rolename").toString(),
                salesOfficeName:
                    sharedPreferences.getString("salesofficename").toString(),
                salesOfficeId:
                    sharedPreferences.getString("salesofficeid").toString(),
              ));
      Navigator.pushReplacement(context, root);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              /// logo perusahaan
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                // child: new Image.asset(
                //   'assets/images/powered_by.png',
                //   height: 25.0,
                //   fit: BoxFit.scaleDown,
                // )
                child: Text(
                  "IT DIVISION",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(0, 99, 0, 1.0),
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /// logo perusahaan
              new Image.asset(
                'assets/images/logo.png',
                width: animation.value * 250,
                height: animation.value * 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
