import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:restauant_app/src/data_network/data_network.dart';
import 'package:restauant_app/src/model/food_model.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';

class FoodBloc {
  DataNetwork _dataNetwork = DataNetwork();
  int number;
  dispose() {}

  showToast(String message) {
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
