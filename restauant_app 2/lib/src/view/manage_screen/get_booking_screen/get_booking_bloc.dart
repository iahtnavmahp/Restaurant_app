import 'dart:async';

import 'package:restauant_app/src/data_network/data_network.dart';
import 'package:restauant_app/src/model/booking_model.dart';

class GetBookingBloc {
  DataNetwork _dataNetwork = DataNetwork();
  StreamController _controllerGetAllBooking = StreamController();

  Stream get streamAllBooking => _controllerGetAllBooking.stream;

  dispose() {
    _controllerGetAllBooking.close();
  }

  Future<List<BookingModel>> getAllBooking() async {
    List<BookingModel> listData = [];

    await _dataNetwork.getAllBooking(dataSuccess: (data) {
      listData.addAll(data);
      _controllerGetAllBooking.sink.add(data);
      return;
    }, error: (error) {
      return;
    });
    return listData;
  }
}
