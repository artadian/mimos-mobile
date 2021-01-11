import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/PR/dao/customer_pr_dao.dart';
import 'package:mimos/PR/dao/db_dao.dart';
import 'package:mimos/PR/dao/posm_dao.dart';
import 'package:mimos/PR/dao/posm_detail_dao.dart';
import 'package:mimos/PR/dao/sellin_dao.dart';
import 'package:mimos/PR/dao/sellin_detail_dao.dart';
import 'package:mimos/PR/dao/stock_dao.dart';
import 'package:mimos/PR/dao/stock_detail_dao.dart';
import 'package:mimos/PR/dao/trial_dao.dart';
import 'package:mimos/PR/dao/visibility_dao.dart';
import 'package:mimos/PR/dao/visibility_detail_dao.dart';
import 'package:mimos/PR/dao/visit_dao.dart';
//import 'package:mimos/Screen/cekupload.dart';
//import 'package:mimos/Screen/downloadscreen.dart';
import 'package:mimos/Screen/loginscreen.dart';
import 'package:mimos/Constant/listmenu.dart';
import 'package:mimos/helper/session_manager.dart';
import 'package:mimos/utils/widget/button/button_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  //HomeScreen(this.userName);
  final String userName;
  final String userId;
  final String userRoleID;
  final String roleName;
  final String salesOfficeId;
  final String salesOfficeName;

  HomeScreen(
      {Key key,
        this.userName,
        this.userId,
        this.userRoleID,
        this.roleName,
        this.salesOfficeId,
        this.salesOfficeName})
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
            lambang: Icons.cloud_download,
            warna: Colors.blue,
            judul: "DOWNLOAD",
            itemid: "101"));
        _myServiceList.add(new MyMenuItem(
            lambang: Icons.person_pin_circle,
            warna: Colors.deepPurple,
            judul: "KUNJUNGAN",
            itemid: "102"));
        _myServiceList.add(new MyMenuItem(
            lambang: Icons.mobile_screen_share,
            warna: Colors.purple,
            judul: "TRIAL",
            itemid: "103"));
        _myServiceList.add(new MyMenuItem(
            lambang: Icons.assignment,
            warna: Colors.green,
            judul: "RINGKASAN",
            itemid: "104"));
        _myServiceList.add(new MyMenuItem(
            lambang: Icons.cloud_upload,
            warna: Colors.orange,
            judul: "UPLOAD",
            itemid: "105"));
        _myServiceList.add(new MyMenuItem(
            lambang: Icons.exit_to_app,
            warna: Colors.red,
            judul: "LOGOUT",
            itemid: "0"));
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
              child: new ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  _buildHeaderMenu(widthScreen),
                  _buildMenuItem(widthScreen),
                ],
              ),
            )));
    //--- end new home
  }

  Widget _buildHeaderMenu(double xLebar) {
    return Container(
      margin: EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blue[400], Colors.blue[700], Colors.blue[900]],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter),
        borderRadius: BorderRadius.circular(30),
      ),
      child: new Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 25, 20, 20),
            child: Column(
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
                    Text(session.username().toUpperCase(),
                        style: new TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    //
                  ],
                ),
                SizedBox(
                  height: 5,
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
                    Text(session.userId(),
                        style: new TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ],
                ),
                SizedBox(
                  height: 5,
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
                    Text(session.roleName(),
                        style: new TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    // Text(
                    //     "Sales Office ID " + widget.salesOfficeId.toString()),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Text(session.salesOfficeName(),
                        style: new TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildMenuItem(double width) {
    return new Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
        child: GridView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _myServiceList.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width ~/ 110),
            itemBuilder: (context, position) {
              return _rowService(_myServiceList[position]);
            }));
  }

  Widget _rowService(MyMenuItem mymenuitem) {
    return ButtonCard(
      elevation: 2.0,
      paddingText: 10,
      borderRadius: 10,
      child: CircleAvatar(
        child: Icon(
          mymenuitem.lambang,
          color: Colors.white,
        ),
        backgroundColor: mymenuitem.warna,
      ),
      childBottom: Text(
        mymenuitem.judul,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
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
        } else if (mymenuitem.itemid.toString() == "99") {
          Navigator.of(context).pushNamed(DOWNLOAD_SCREEN_PR);
        } else if (mymenuitem.itemid.toString() == "101") {
          Navigator.of(context).pushNamed(DOWNLOAD_SCREEN_PR);
        } else if (mymenuitem.itemid.toString() == "102") {
          Navigator.of(context).pushNamed(VISIT_SCREEN_PR);
        } else if (mymenuitem.itemid.toString() == "103") {
          Navigator.of(context).pushNamed(TRIAL_SCREEN_PR);
        } else if (mymenuitem.itemid.toString() == "104") {
          Navigator.of(context).pushNamed(REPORT_SCREEN_PR);
        } else if (mymenuitem.itemid.toString() == "105") {
          Navigator.of(context).pushNamed(UPLOAD_SCREEN_PR);
        } else {
          _logOut();
        }
      },
    );
  }

  _logOut() async {
    session.destroy();
    await _clearDb();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LogInScreen()),
            (Route<dynamic> route) => false);
  }

  _clearDb() async {
    var dbDao = DbDao();
    await dbDao.truncateAll();
  }

}
