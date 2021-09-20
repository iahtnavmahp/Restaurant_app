import 'dart:async';

import 'package:restauant_app/src/utils/animation/push_screen_switch_right.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/view/home_screen/home_screen.dart';
import 'package:restauant_app/src/view/login_screen/login_screen.dart';
import 'package:restauant_app/src/view/manage_screen/manage_screen.dart';

class SplashBloc{
  isCheckLoginApp({BuildContext context}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var duration = Duration(seconds: 4);

    return new Timer(duration, () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      FocusScope.of(context).requestFocus(new FocusNode());
      print(sharedPreferences.getString(Constant.KEY_ROLES));
      try {
        if (sharedPreferences.getString(Constant.KEY_ROLES) == "ROLE_ADMIN") {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ManageScreen()));
        } else if (sharedPreferences.getString(Constant.KEY_ROLES) == "ROLE_USER") {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      } catch (err) {
        pref.clear();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        throw err;
      }
    });
  }

  logOut({BuildContext context})async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    Navigator.of(context).pushAndRemoveUntil(PushScreenSwitchLeft(enterPage: LoginScreen()), (Route<dynamic> route) => false);

  }
}