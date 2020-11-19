import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';

class TrialScreenFL extends StatefulWidget {
  @override
  _TrialScreenFLState createState() => _TrialScreenFLState();
}

class _TrialScreenFLState extends State<TrialScreenFL> {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double appBarHeight = kToolbarHeight;
    final double paddingBottom = mediaQueryData.padding.bottom;
    final double heightScreen =
        mediaQueryData.size.height - paddingBottom - appBarHeight;
    return Scaffold(
        appBar: AppBar(
          title: Text("Trial"),
          backgroundColor: Colors.blue,
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              backgroundColor: Colors.orange[400],
              onPressed: () {
                Navigator.of(context).pushNamed(TRIAL_FORM_SCREEN_FL);
              },
              child: Icon(Icons.add_box),
            ),
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                _buildHeaderMenu(heightScreen / 3, widthScreen),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            // leading: Icon(
                            //   Icons.ac_unit,
                            //   color: Colors.amber,
                            //   size: 45,
                            // ),
                            title: Text(
                                "Location "
                                ": Lokasi",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text("Name : ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16)),
                                    Text("USER",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Material : ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16)),
                                    Text("Diplomat Evo 16 ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Total PAC : ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16)),
                                    Text("15 Pac ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Total Amount : ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16)),
                                    Text("Rp.150.000 ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16)),
                                  ],
                                ),
                              ],
                            ),
                            isThreeLine: true,
                            trailing: FittedBox(
                              fit: BoxFit.fill,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                    size: 40,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        )));
    //--- end new home,
  }

  Widget _buildHeaderMenu(double xTinggi, double xLebar) {
    return new Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Container(
            height: xTinggi - 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blue],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: new Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: xLebar,
                  height: xTinggi,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: new Card(
                            color: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Container(
                                  child: new Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Text("Total Trial",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                  new Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      // shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "100",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                  new SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              )),
                            ),
                          )),
                          Expanded(
                              child: new Card(
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Container(
                                  child: new Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Text("Pack Sold",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                  new Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      // shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "200",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                  new SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              )),
                            ),
                          )),
                          Expanded(
                              child: new Card(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Container(
                                  child: new Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    "Total Amount",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                  new Container(
                                    decoration: BoxDecoration(
                                      // color: Colors.redAccent,
                                      // shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "20.000.000",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                  new SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              )),
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ]);
  }
}
