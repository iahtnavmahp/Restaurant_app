
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/view/splash_screen/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashBloc bloc = SplashBloc();

  @override
  void initState() {
    super.initState();
    bloc.isCheckLoginApp(context: context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: Adaptive.w(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Wellcome",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: ColorCustom.colorTheem),
            ),
            Container(
                margin: EdgeInsets.only(top: Adaptive.w(15)),
                child: Image.asset(
                  "assets/icon/ic_splash.png",
                  width: Adaptive.w(45),
                )),
            Container(
              width: size.width,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: Adaptive.w(15)),
              child: SpinKitWave(
                color: ColorCustom.colorTheem,
                size: 30.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
