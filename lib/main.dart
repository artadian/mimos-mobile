import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Screen/splashscreen.dart';
import 'package:mimos/helper/session_manager.dart';
import 'package:mimos/routes.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await session.init();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIMOS',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          accentColor: Colors.black,
          primaryColor: MyPalette.ijoMimos,
          primaryColorDark: Colors.black),
      home: new SplashScreen(),
      routes: Routes.generate(),
    );
  }
}


