import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:get/utils.dart';
import 'package:restauant_app/src/view/login_screen/login_bloc.dart';
import 'package:restauant_app/src/view/login_screen/login_screen.dart';
import 'package:restauant_app/src/view/splash_screen/splash_screen.dart';

import 'utils/base/base_import.dart';
import 'view/home_screen/home_screen.dart';
import 'view/manage_screen/manage_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();

    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      );
    });
  }

}
