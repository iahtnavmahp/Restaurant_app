import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:restauant_app/src/data_network/data_network.dart';
import 'package:restauant_app/src/model/user_model.dart';
import 'package:restauant_app/src/utils/animation/push_screen_switch_let.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/dialog_custom/dialog_loading.dart';
import 'package:restauant_app/src/utils/animation/push_screen_switch_right.dart';
import 'package:restauant_app/src/view/home_screen/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:restauant_app/src/view/login_screen/login_screen.dart';
import 'package:restauant_app/src/view/manage_screen/manage_screen.dart';

class LoginBloc {
  DataNetwork _dataNetwork = DataNetwork();
  SharedPreferences sharedPreferences;

  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  StreamController _controllerUsername = StreamController();
  StreamController _controllerPassword = StreamController();

  Stream get streamUsername => _controllerUsername.stream;

  Stream get streamPassword => _controllerPassword.stream;

  dispose() {
    _controllerPassword.close();
    _controllerUsername.close();
  }

  login(BuildContext context) async {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ManageScreen()));
    sharedPreferences = await SharedPreferences.getInstance();
    if (isCheckLogin()) {
      DialogLoading.showLoading(context);

      await _dataNetwork.logIn(
        context,
        username: controllerUsername.text,
        password: controllerPassword.text,
        dataSuccess: (data) {
          print(data);
          UserModel userModel = data;
          sharedPreferences.setString(Constant.KEY_USER, userModel.username ?? "");
          sharedPreferences.setString(Constant.KEY_EMAIL, userModel.email ?? "");
          sharedPreferences.setString(Constant.KEY_ROLES, userModel.roles[0]);
          sharedPreferences.setString(Constant.KEY_ACCESSTOKEN, userModel.accessToken);
          sharedPreferences.setString(Constant.KEY_FULLNAME, userModel.name ?? "");
          DialogLoading.hiddenLoading(context);
          if (userModel.roles[0] == "ROLE_ADMIN") {
            Navigator.push(context, PushScreenSwitchRight(enterPage: ManageScreen()));
          } else if (userModel.roles[0] == "ROLE_USER") {
            Navigator.push(context, PushScreenSwitchRight(enterPage: HomeScreen()));
          }
          return;
        },
        error: (err) {
          showToast(message: "Tài khoản hoặc mật khẩu không chính xác");
          DialogLoading.hiddenLoading(context);

          return;
        },
      );
    }
  }

  bool isCheckLogin() {
    if (controllerUsername.text == "") {
      _controllerUsername.sink.add("${Constant.errorUsername}");
      return false;
    }
    _controllerUsername.sink.add("");

    if (controllerPassword.text == "") {
      _controllerPassword.sink.add("${Constant.errorPassword}");
      return false;
    } else {
      if (controllerPassword.text.length < 6) {
        _controllerPassword.sink.add("Mật khẩu của bạn không được dưới 6 ký tự");
        return false;
      }
    }
    _controllerPassword.sink.add("");

    return true;
  }

  showToast({String message}) {
    Fluttertoast.showToast(
        msg: "$message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
