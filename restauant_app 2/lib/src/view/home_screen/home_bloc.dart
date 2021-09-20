import 'dart:async';

import 'package:restauant_app/src/data_network/data_network.dart';
import 'package:restauant_app/src/model/booking_model.dart';
import 'package:restauant_app/src/model/detail_order_model.dart';
import 'package:restauant_app/src/model/tables_model.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/dialog_custom/dialog_loading.dart';

class HomeBloc {
  DataNetwork _dataNetwork = DataNetwork();

  StreamController _controllerListHome = StreamController();
  StreamController _controllerNumber = StreamController();
  StreamController _controllerBooking = StreamController();

  Stream get streamListHome => _controllerListHome.stream;

  Stream get streamNumber => _controllerNumber.stream;

  Stream get streamBooking => _controllerBooking.stream;

  dispose() {
    _controllerListHome.close();
    _controllerNumber.close();
    _controllerBooking.close();
  }

  Future<List<TablesModel>> getListBA() async {
    List<TablesModel> listData = [];
    await _dataNetwork.getListHome(dataSuccess: (dataSuccess) {
      print(dataSuccess);
      listData.addAll(dataSuccess);
      _controllerListHome.sink.add(listData);
      return;
    }, error: (error) {
      return;
    });
    getNumberOfEmptyTables(listData);
    return listData;
  }

  Future<BookingModel> getBooking({BuildContext context, int id}) async {
    BookingModel dataModel;
    await _dataNetwork.getBookings(
        id: id,
        dataSuccess: (dataSuccess) {
          print(dataSuccess);
          dataModel = dataSuccess;
          _controllerBooking.sink.add(dataModel);
          return;
        },
        error: (error) {

          return;
        });

    return dataModel;
  }

  Future<DetailOrderModel> getDetailOrder({int id}) async {
    DetailOrderModel dataModel;
    await _dataNetwork.getDetailOrder(
        id: id,
        dataSuccess: (dataSuccess) {
          dataModel = dataSuccess;
          return;
        },
        error: (error) {
          return;
        });
    return dataModel;
  }
  getNumberOfEmptyTables(List<TablesModel> listModel) {
    List<TablesModel> listData = [];
    for (var i = 0; i < listModel.length; i++) {
      if (listModel[i].status == false) {
        listData.add(TablesModel(
          id: listModel[i].id,
          status: listModel[i].status,
          location: listModel[i].location,
          posivition: listModel[i].posivition,
          seating: listModel[i].seating,
          tableNumber: listModel[i].tableNumber,
        ));
      }
    }
    _controllerNumber.sink.add(listData.length);
  }
}
