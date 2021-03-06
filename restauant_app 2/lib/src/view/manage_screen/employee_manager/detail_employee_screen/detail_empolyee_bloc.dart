import 'dart:async';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:restauant_app/src/data_network/data_network.dart';
import 'package:restauant_app/src/model/user_model_v2.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';

class DetailEmpolyeeBloc {
  DataNetwork _dataNetwork = DataNetwork();

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerDate = TextEditingController();

  StreamController _controllerRoles = StreamController();
  StreamController _controllerName = StreamController();
  StreamController _controllerUsername = StreamController();
  StreamController _controllerPassword = StreamController();
  StreamController _controllerPhone = StreamController();

  Stream get streamRoles => _controllerRoles.stream;

  Stream get streamCreateName => _controllerName.stream;

  Stream get streamCreateUsername => _controllerUsername.stream;

  Stream get streamCreatePassword => _controllerPassword.stream;

  Stream get streamCreatePhone => _controllerPhone.stream;

  String dataRadio = "ROLE_USER";

  void isCheckRadioButton(String data) {
    dataRadio = data;
    _controllerRoles.sink.add(dataRadio);
  }

  dispose() {
    _controllerRoles.close();
    _controllerName.close();
    _controllerUsername.close();
    _controllerPassword.close();
    _controllerPhone.close();
  }

  setDataUser({UserModelV2 dataModel}) {
    if (dataModel != null) {
      controllerName.text = dataModel.name;
      controllerUsername.text = dataModel.username;
      controllerPassword.text = dataModel.password;
      controllerPhone.text = dataModel.phoneNumber;
    }
  }

  Future<bool> createUser() async {
    UserModelV2 userModelV2 = UserModelV2();
    bool status;
    if (isCheckLogin()) {
      await _dataNetwork.createUser(
          name: controllerName.text,
          password: controllerPassword.text,
          phoneNumber: controllerPhone.text,
          roles: dataRadio,
          username: controllerUsername.text,
          dataSuccess: (dataSuccess) {
            status = true;
            showToast("T???o nh??n vi??n th??nh c??ng");

            return;
          },
          error: (error) {
            status = false;
            showToastErr("T???o nh??n vi??n th???t b???i");

            return;
          });
    }

    return status;
  }

  Future<UserModelV2> editUser({UserModelV2 userModel}) async {
    UserModelV2 userModelV2 = UserModelV2();

    await _dataNetwork.editUser(
        id: userModel.id,
        name: controllerName.text,
        password: controllerPassword.text,
        phoneNumber: controllerPhone.text,
        roles: dataRadio,
        username: controllerUsername.text,
        address: controllerAddress.text,
        birthday: controllerDate.text,
        idRoles: dataRadio == "ROLE_USER" ? 1 : 2,
        dataSuccess: (dataSuccess) {
          showToast("S???a nh??n vi??n th??nh c??ng");

          return;
        },
        error: (error) {
          showToastErr("S???a nh??n vi??n th???t b???i");

          return;
        });
    return userModelV2;
  }

  Future<bool> deleteUser({int id}) async {
    bool status = false;
    _dataNetwork.deleteUser(
        id: id,
        dataSuccess: (dataSuccess) {
          status = true;
          showToast("Xo?? nh??n vi??n th??nh c??ng");
          return;
        },
        error: (err) {
          status = false;
          showToastErr("Xo?? nh??n vi??n th???t b???i");
          return;
        });

    return status;
  }

  bool isCheckLogin() {
    if (controllerName.text == "") {
      _controllerName.sink.add("B???n ch??a nh???p t??n nh??n vi??n");
      return false;
    }
    _controllerName.sink.add("");

    if (controllerUsername.text == "") {
      _controllerUsername.sink.add("B???n ch??a nh???p username");
      return false;
    }
    _controllerUsername.sink.add("");

    if (controllerPassword.text == "") {

      _controllerPassword.sink.add("${Constant.errorPassword}");
      return false;
    }else{
      if (controllerPassword.text.length < 6) {
        _controllerPassword.sink.add("M???t kh???u c???a b???n kh??ng ???????c d?????i 6 k?? t???");
        return false;
      }
    }
    _controllerPassword.sink.add("");

    if (controllerPhone.text == "") {
      _controllerPhone.sink.add("B???n ch??a nh???p s??? ??i???n tho???i");
      return false;
    }else{
      if (controllerPhone.text.length < 10) {
        _controllerPhone.sink.add("S??? ??i???n tho???i ph???i ????? 10 s???");
        return false;
      }
    }
    _controllerPhone.sink.add("");

    return true;
  }

  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // This is actually digest.toString()
    return hex.encode(digest.bytes);
  }
  showToast(String message) {
    Fluttertoast.showToast(
        msg: "$message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  showToastErr(String message) {
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
