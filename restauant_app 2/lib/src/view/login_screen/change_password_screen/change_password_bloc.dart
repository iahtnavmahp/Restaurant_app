import 'dart:async';

import 'package:restauant_app/src/utils/base/base_import.dart';

class ChangePasswordBloc{


  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerNewPassword = TextEditingController();
  TextEditingController controllerPasswordConfig = TextEditingController();

  StreamController _controllerPassword = StreamController();
  StreamController _controllerNewPassword = StreamController();
  StreamController _controllerPasswordConfig = StreamController();



  Stream get streamPassword => _controllerPassword.stream;
  Stream get streamNewPassword => _controllerNewPassword.stream;
  Stream get streamNewPasswordConfig => _controllerPasswordConfig.stream;

  dispose(){
    _controllerPassword.close();
    _controllerNewPassword.close();
    _controllerPasswordConfig.close();
  }

  bool isCheckLogin() {
    if (controllerPassword.text == "") {
      _controllerPassword.sink.add("${Constant.errorPassword}");
      return false;
    }
    _controllerPassword.sink.add("");

    if (controllerNewPassword.text == "") {
      _controllerNewPassword.sink.add("${Constant.errorPasswordNew}");
      return false;
    }
    _controllerNewPassword.sink.add("");

    if (controllerPasswordConfig.text == "" || controllerPasswordConfig.text != controllerNewPassword.text) {
      _controllerPasswordConfig.sink.add("${Constant.errorPasswordNL}");
      return false;
    }
    _controllerPasswordConfig.sink.add("");

    return true;
  }

}