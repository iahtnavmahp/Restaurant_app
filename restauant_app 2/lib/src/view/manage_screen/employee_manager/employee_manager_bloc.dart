import 'dart:async';

import 'package:restauant_app/src/data_network/data_network.dart';
import 'package:restauant_app/src/model/user_model.dart';
import 'package:restauant_app/src/model/user_model_v2.dart';

class EmployeeManagerBloc {
  DataNetwork _dataNetwork = DataNetwork();

  StreamController _controllerListUser = StreamController();

  Stream get streamListUser => _controllerListUser.stream;

  dispose() {
    _controllerListUser.close();
  }

  Future<List<UserModelV2>> getListUser() async {
    List<UserModelV2> listData = [];
    await _dataNetwork.getListUser(
        limit: 15,
        offset: 0,
        dataSuccess: (dataSuccess) {
          print(dataSuccess);
          listData.addAll(dataSuccess);
          _controllerListUser.sink.add(listData);
          return;
        },
        error: (error) {
          return;
        });
    return listData;
  }
}
