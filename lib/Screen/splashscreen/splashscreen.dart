import 'package:flutter/material.dart';
import 'package:mimos/Screen/splashscreen/splashscreen_vm.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _vm = SplashScreenVM();
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    _vm.init(context);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _initProvider(),
    ));
  }

  Widget _initProvider() {
    return ChangeNotifierProvider<SplashScreenVM>(
      create: (_) => _vm,
      child: Consumer<SplashScreenVM>(
        builder: (c, vm, _) => _initWidgetNew(),
      ),
    );
  }

  Widget _initWidget() {
    return Stack(
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
    );
  }

  Widget _initWidgetNew() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(),
            SizedBox(),
            Container(
              width: 250,
              height: 250,
              child: Image.asset(
                'assets/images/logo.png',
                width: 250,
                height: 250,
              ),
            ),
            Stack(
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              ],
            ),
            Text(
              "IT DIVISION",
              style: TextStyle(
                  fontSize: 24,
                  color: Color.fromRGBO(0, 99, 0, 1.0),
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
