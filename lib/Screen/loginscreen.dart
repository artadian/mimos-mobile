//import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Screen/homescreen.dart';
import 'package:mimos/Screen/homescreen_old.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
//import 'package:mimos/Response/loginresponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController userController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  //LoginResponse loginResponse = new LoginResponse();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: true,
        body: new ListView(
          shrinkWrap: true,
          reverse: false,
          children: <Widget>[
            new SizedBox(
              height: 20.0,
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                      child: new Text("MIMOS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.left),
                    )
                  ],
                ),
                new SizedBox(
                  height: 30.0,
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(
                      "assets/images/mimos_icon.png",
                      height: 150.0,
                      width: 210.0,
                      fit: BoxFit.scaleDown,
                    )
                  ],
                ),
                new Center(
                    child: new Center(
                  child: new Stack(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: new Form(
                            // autovalidate: false,
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: new TextFormField(
                                    controller: userController,
                                    autofocus: false,
                                    decoration: new InputDecoration(
                                      labelText: "Identitas Pengguna",
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.only(right: 7.0),
                                          child: new Image.asset(
                                            "assets/images/user_icon.png",
                                            height: 25.0,
                                            width: 25.0,
                                            fit: BoxFit.scaleDown,
                                          )),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                                new Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0, top: 5.0),
                                    child: new TextFormField(
                                      obscureText: true,
                                      autofocus: false,
                                      controller: passwordController,
                                      decoration: new InputDecoration(
                                          labelText: "Password",
                                          prefixIcon: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 7.0),
                                              child: new Image.asset(
                                                "assets/images/password_icon.png",
                                                height: 25.0,
                                                width: 25.0,
                                                fit: BoxFit.scaleDown,
                                              ))),
                                      keyboardType: TextInputType.text,
                                    )),
                                new Padding(
                                  padding: EdgeInsets.only(
                                      left: 0.0, top: 45.0, bottom: 20.0),
                                  child: new RaisedButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    onPressed: () {
                                      if (!(userController.value.text
                                              .trim()
                                              .toString()
                                              .length >
                                          1)) {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Identitas pengguna belum terisi",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,

                                            //backgroundColor: Colors.red,
                                            textColor: Colors.red,
                                            fontSize: 16.0,
                                            timeInSecForIosWeb: 1);
                                      } else if (!(passwordController.value.text
                                              .trim()
                                              .toString()
                                              .length >
                                          1)) {
                                        Fluttertoast.showToast(
                                            msg: "Password belum terisi",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            timeInSecForIosWeb: 1);
                                      } else {
                                        /* Fluttertoast.showToast(
                                              msg:
                                              "You have successfull logedin to " +
                                                  email_controller.value.text
                                                      .toString(),
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1);
*/
                                        // email_controller.clear();
                                        //password_controller.clear();
                                        //Navigator.of(context).pop(LOGIN_SCREEN);
                                        //--- tes
                                        // var root = MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         new HomeScreen(user_controller
                                        //             .value.text
                                        //             .toString()));
                                        // //  Navigator.of(context).pop(LOGIN_SCREEN);
                                        // Navigator.pushReplacement(
                                        //     context, root);
                                        //-- end tes
                                        //    _logIn(userController.text,
                                        // passwordController.text, context);
                                        login(userController.text,
                                            passwordController.text);
                                      }
                                    },
                                    child: new Text(
                                      "Login",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    color: Color.fromRGBO(0, 153, 130, 1.0),
                                    textColor: Colors.white,
                                    elevation: 5.0,
                                    padding: EdgeInsets.only(
                                        left: 80.0,
                                        right: 80.0,
                                        top: 15.0,
                                        bottom: 15.0),
                                  ),
                                ),
                                // new Column(
                                //   children: <Widget>[
                                //     new FlatButton(
                                //       onPressed: () {
                                //         // Navigator
                                //         //     .of(context)
                                //         //     .pushNamed(SIGN_UP_SCREEN);
                                //       },
                                //       child: new Padding(
                                //           padding: EdgeInsets.only(top: 20.0),
                                //           child: new Text(
                                //             "Don't Have An Account",
                                //             style: TextStyle(
                                //                 decoration:
                                //                 TextDecoration.underline,
                                //                 fontSize: 15.0),
                                //           )),
                                //     )
                                //   ],
                                // )
                              ],
                            ),
                          )),
                    ],
                  ),
                ))
              ],
            )
          ],
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed

    super.dispose();
    userController.dispose();
    passwordController.dispose();
  }

  login(String userid, pass) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Identifikasi pengguna"),
            backgroundColor: Colors.grey[200],
            //contentPadding: EdgeInsets.fromLTRB(20, 100, 20, 100),
            content: Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text("Proses ke server")
                ],
              ),
            ),
          );
        });

    Map data = {
      'UserID': userid,
      'Password': pass
      //'X-API-KEY': 'DIMAS'
    };
    var apiResult = await http
        // .post("http://172.27.10.14/apimimos/index.php/api/login", body: data);
        .post(apiURL + "/login", body: data);
    var jsonObject = json.decode(apiResult.body);
    //var userdata = (jsonObject['data'] as Map<String, dynamic>);
    var userdata = jsonObject['data'];
    var xmgs = jsonObject['message'];
    var xstatus = jsonObject['status'];
    //print(userdata[0]['userid'].toString());
    if (xstatus) {
      Navigator.pop(context);
      SharedPreferences sharedPreferencesLogin =
          await SharedPreferences.getInstance();
      sharedPreferencesLogin.setString(
          "userid", userdata[0]['userid'].toString());
      sharedPreferencesLogin.setString(
          "username", userdata[0]['username'].toString());
      sharedPreferencesLogin.setString(
          "userroleid", userdata[0]['userroleid'].toString());
      sharedPreferencesLogin.setString(
          "rolename", userdata[0]['rolename'].toString());
      sharedPreferencesLogin.setString(
          "salesofficeid", userdata[0]['salesofficeid'].toString());
      sharedPreferencesLogin.setString(
          "salesgroupid", userdata[0]['salesgroupid'].toString());
      sharedPreferencesLogin.setString(
          "salesdistrictid", userdata[0]['salesdistrictid'].toString());
      sharedPreferencesLogin.setString(
          "regionid", userdata[0]['regionid'].toString());
      sharedPreferencesLogin.setString(
          "salesofficetype", userdata[0]['salesofficetype'].toString());
      sharedPreferencesLogin.setString(
          "salesofficetypename", userdata[0]['salesofficetypename'].toString());
      sharedPreferencesLogin.setString(
          "salesofficename", userdata[0]['salesofficename'].toString());
      var root = MaterialPageRoute(
          builder: (context) => new HomeScreen());
      //new HomeScreen(userName :userdata[0].userName.toString(),userId:userdata[0].userId.toString()));
      Navigator.pushReplacement(context, root);
    } else {
      Navigator.pop(context);
      var restmessage = xmgs;
      Alert(
          context: context,
          type: AlertType.error,
          title: "Identifikasi pengguna",
          desc: restmessage,
          buttons: [
            DialogButton(
              radius: BorderRadius.circular(30.0),
              child: Text(
                "Gagal",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Color.fromRGBO(200, 0, 0, 1.0),
            )
          ]).show();
    }
  }

  // Future _logIn(String userid, pass, context) async {
  //   SharedPreferences sharedPreferencesLogin =
  //       await SharedPreferences.getInstance();
  //   var jsonResponse;
  //   jsonResponse = await loginResponse.getUserLoginFromAPI(userid, pass);
  //   //var strMsg = jsonResponse.msg;
  //   //print(strMsg);
  //   if (jsonResponse.status) {
  //     //var userdata = (jsonResponse.data as Map<String, dynamic>);
  //     var userdata = jsonResponse.data;
  //     sharedPreferencesLogin.setString("userid", userdata[0].userId);
  //     sharedPreferencesLogin.setString("username", userdata[0].userName);
  //     sharedPreferencesLogin.setString("userroleid", userdata[0].userRoleId);
  //     sharedPreferencesLogin.setString("rolename", userdata[0].roleName);
  //     sharedPreferencesLogin.setString(
  //         "salesofficeid", userdata[0].salesOfficeId);
  //     sharedPreferencesLogin.setString(
  //         "salesgroupid", userdata[0].salesGroupId);
  //     sharedPreferencesLogin.setString(
  //         "salesdistrictid", userdata[0].salesDistrictId);
  //     sharedPreferencesLogin.setString("regionid", userdata[0].regionId);
  //     //home
  //     var root = MaterialPageRoute(
  //         builder: (context) =>
  //             //new HomeScreen(userdata[0].userName.toString()));
  //             new HomeScreen(
  //                 userName: userdata[0].userName.toString(),
  //                 userId: userdata[0].userId.toString(),
  //                 userRoleID: userdata[0].userRoleId.toString(),
  //                 roleName: userdata[0].roleName.toString(),
  //                 salesOfficeId: userdata[0].salesOfficeId.toString()));
  //     //new HomeScreen(userName :userdata[0].userName.toString(),userId:userdata[0].userId.toString()));
  //     Navigator.pushReplacement(context, root);
  //     //-- end home
  //     // Navigator.of(context).pushAndRemoveUntil(
  //     //     MaterialPageRoute(builder: (BuildContext context) => HomePage()),
  //     //     (Route<dynamic> route) => false);
  //   } else {
  //     var restmessage = jsonResponse.message;
  //     Alert(
  //             context: context,
  //             type: AlertType.error,
  //             title: "Authentication",
  //             desc: restmessage)
  //         .show();
  //   }
  // }
}
