import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Screen/splashscreen/splashscreen.dart';
import 'package:mimos/helper/session_manager.dart';
import 'package:mimos/routes.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await session.init();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://b1bbfaf327424f48a5a80f4e0ac8f20b@o509156.ingest.sentry.io/5602891';
    },
    appRunner: () => runApp(MyApp()),
  );
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
