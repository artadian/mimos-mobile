import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
//import 'package:mimos/Screen/cekupload.dart';
//import 'package:mimos/Screen/downloadscreen.dart';
import 'package:mimos/Screen/loginscreen.dart';
import 'package:mimos/Constant/listmenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  //HomeScreen(this.userName);
  final String userName;
  final String userId;
  final String userRoleID;
  final String roleName;
  final String salesOfficeId;
  HomeScreen(
      {Key key,
      this.userName,
      this.userId,
      this.userRoleID,
      this.roleName,
      this.salesOfficeId})
      : super(key: key);
  // HomeScreen({Key key, this.userName, this.userId}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences sharedPreferences;
  Future<String> _getRoleUserID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("userroleid") ?? "No Role ID";
  }

  //MenuItem menuiItem;
  String userRoleID = "";
  //var listMenuHome = listMenuItemTF;
  List<MyMenuItem> _myServiceList = [];
  @override
  void initState() {
    super.initState();
    // userRoleID = widget.userId;
    _getRoleUserID().then((val) => setState(() {
          userRoleID = val;
          // userrole 1 Taskforce
          // userrole 2 Promotor
          // userrole 3 Frontliner
          if (userRoleID == "1") {
            // listMenuHome = listMenuItemTF;
            _myServiceList.add(new MyMenuItem(
                lambang: Icons.cloud_download,
                warna: MyPalette.biru,
                judul: "DOWNLOAD",
                itemid: "11"));
            _myServiceList.add(new MyMenuItem(
                lambang: Icons.person_pin_circle,
                warna: MyPalette.ijoMimos,
                judul: "KUNJUNGAN",
                itemid: "12"));
            _myServiceList.add(new MyMenuItem(
                lambang: Icons.description,
                warna: MyPalette.ijoMimos,
                judul: "RINGKASAN",
                itemid: "13"));
            _myServiceList.add(new MyMenuItem(
                lambang: Icons.cloud_upload,
                warna: Colors.orange,
                judul: "UPLOAD",
                itemid: "14"));
            _myServiceList.add(new MyMenuItem(
                lambang: Icons.exit_to_app,
                warna: MyPalette.merah,
                judul: "LOGOUT",
                itemid: "0"));
          } else if (userRoleID == "5") {
            //listMenuHome = listMenuItemTF;
          } else if (userRoleID == "2") {
            _myServiceList.add(new MyMenuItem(
                lambang: Icons.exit_to_app,
                warna: MyPalette.merah,
                judul: "LOGOUT",
                itemid: "0"));
            //listMenuHome = listMenuItemPromotor;
          } else if (userRoleID == "6") {
            //listMenuHome = listMenuItemPromotorL;
          } else if (userRoleID == "3") {
            _myServiceList.add(new MyMenuItem(
                lambang: Icons.cloud_download,
                warna: Colors.lightBlueAccent,
                judul: "DOWNLOAD",
                itemid: "31"));
            _myServiceList.add(new MyMenuItem(
                lambang: Icons.person_add_alt,
                warna: Colors.lightBlueAccent,
                judul: "TRIAL",
                itemid: "32"));
            _myServiceList.add(new MyMenuItem(
                lambang: Icons.cloud_upload,
                warna: Colors.lightBlueAccent,
                judul: "UPLOAD",
                itemid: "33"));
            _myServiceList.add(new MyMenuItem(
                lambang: Icons.exit_to_app,
                warna: Colors.lightBlueAccent,
                judul: "LOGOUT",
                itemid: "0"));
            //listMenuHome = listMenuItemFL;
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double appBarHeight = kToolbarHeight;
    final double paddingBottom = mediaQueryData.padding.bottom;
    final double heightScreen =
        mediaQueryData.size.height - paddingBottom - appBarHeight;

    //--- new home
    return SafeArea(
        child: new Scaffold(
            body: Container(
      //color: Colors.blue[50],
      child: new ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          new Column(
            children: <Widget>[
              //Text("data"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildHeaderMenu(heightScreen / 3, widthScreen),
              ),
              _buildMenuItem(heightScreen / 3 * 2),
            ],
          )
        ],
      ),
    )));
    //--- end new home
  }

  Widget _buildHeaderMenu(double xTinggi, double xLebar) {
    return new Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Container(
            // padding: EdgeInsets.all(10),
            // margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: xTinggi - 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blue],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35)),
              // bottomRight: Radius.circular(30),
              // bottomLeft: Radius.circular(30)),
            ),
            child: new Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: xLebar,
                  height: xTinggi,
                  // decoration: BoxDecoration(
                  //   // boxShadow: [
                  //   //   BoxShadow(
                  //   //       color: Colors.grey, blurRadius: 25, spreadRadius: 5)
                  //   // ],
                  //   color: Colors.white,
                  //   //border: Border.all(color: Colors.greenAccent),
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  margin: EdgeInsets.fromLTRB(20, 25, 20, 30),
                  // padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image(
                            image: AssetImage('assets/images/mimos_icon.png'),
                            height: 40,
                            width: 40,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text("MIMO",
                              style: new TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 13,
                          ),
                          Text(widget.userName.toUpperCase(),
                              style: new TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                          //
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.perm_contact_cal,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 13,
                          ),
                          Text(widget.userId,
                              style: new TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.work,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 13,
                          ),
                          Text(widget.roleName.toString(),
                              style: new TextStyle(
                                fontSize: 18,
                                // fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                          // Text(
                          //     "Sales Office ID " + widget.salesOfficeId.toString()),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ]);
  }

  Widget _buildMenuItem(double xtinggi) {
    return new Container(
        height: xtinggi,
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //       colors: [Colors.blue, Colors.white],
        //       begin: FractionalOffset.bottomCenter,
        //       end: FractionalOffset.topCenter),
        //   borderRadius: BorderRadius.only(
        //       bottomLeft: Radius.circular(10),
        //       bottomRight: Radius.circular(10)),
        // ),
        child: GridView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: _myServiceList.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, position) {
              return _rowMyService(_myServiceList[position]);
            }));
  }

  Widget _rowMyService(MyMenuItem mymenuitem) {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new InkWell(
            // behavior: HitTestBehavior.opaque,
            onTap: () {
              if (mymenuitem.itemid.toString() == "99") {
                //  showModalBottomSheet<void>(
                //   context: context,
                //   builder: (context) {
                //     return _buildMenuBottomSheet();
                //   });
              } else if (mymenuitem.itemid.toString() == "11") {
                Navigator.of(context).pushNamed(DOWNLOAD_SCREEN_TF);
              } else if (mymenuitem.itemid.toString() == "12") {
                Navigator.of(context).pushNamed(VISIT_SCREEN_TF);
              } else if (mymenuitem.itemid.toString() == "13") {
                Navigator.of(context).pushNamed(RINGKASAN_SCREEN_TF);
              } else if (mymenuitem.itemid.toString() == "14") {
                Navigator.of(context).pushNamed(UPLOAD_SCREEN);
              } else if (mymenuitem.itemid.toString() == "31") {
                Navigator.of(context).pushNamed(DOWNLOAD_SCREEN_FL);
              } else if (mymenuitem.itemid.toString() == "32") {
                Navigator.of(context).pushNamed(TRIAL_SCREEN_FL);
              } else if (mymenuitem.itemid.toString() == "33") {
                Navigator.of(context).pushNamed(UPLOAD_SCREEN_FL);
              } else {
                _logOut();
              }
            },
            child: new Container(
              height: 120,
              width: 120,
              padding: EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 7,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Icon(
                      mymenuitem.lambang,
                      color: mymenuitem.warna,
                      size: 54.0,
                    ),
                    new Text(mymenuitem.judul,
                        style: new TextStyle(
                            fontSize: 15.0, color: Colors.lightBlueAccent))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _logOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LogInScreen()),
        (Route<dynamic> route) => false);
  }
}
