import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:restauant_app/src/data_network/data_network.dart';
import 'package:restauant_app/src/model/booking_model.dart';
import 'package:restauant_app/src/model/tables_model.dart';
import 'package:restauant_app/src/utils/animation/push_screen_switch_let.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/dialog_custom/dialog_loading.dart';
import 'package:restauant_app/src/view/order_food_screen/order_food_screen.dart';

class CreateBookingBloc {
  DataNetwork _dataNetwork = DataNetwork();

  TextEditingController controllerCustomerName = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerAmountOfPeople = TextEditingController();
  TextEditingController controllerNote = TextEditingController();

  StreamController _controllerName = StreamController();
  StreamController _controllerPhone = StreamController();
  StreamController _controllerAmountOfPeople = StreamController();

  Stream get streamName => _controllerName.stream;

  Stream get streamPhone => _controllerPhone.stream;

  Stream get streamAmountOfPeople => _controllerAmountOfPeople.stream;

  dispose() {
    _controllerName.close();
    _controllerPhone.close();
    _controllerAmountOfPeople.close();
  }

  createBooking({
    BuildContext context,
    TablesModel dataModel,
  }) async {
    BookingModel dataBooking;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    DialogLoading.showLoading(context);
    await _dataNetwork.createBooking(
        customerName: controllerCustomerName.text,
        customerPhone: controllerPhone.text,
        idTable: dataModel.id,
        note: controllerNote.text,
        location: dataModel.location.toString(),
        numberInParty: controllerAmountOfPeople.text,
        posivition: dataModel.posivition.toString(),
        seating: dataModel.seating.toString(),
        tableNumber: dataModel.tableNumber.toString(),
        userCheckin: sharedPreferences.getString(Constant.KEY_FULLNAME),
        dataSuccess: (dataSuccess) {
          print(dataSuccess);
          dataBooking = dataSuccess;

          updateStatusTable(id: dataModel.id);
          DialogLoading.hiddenLoading(context);
          Navigator.push(
              context,
              PushScreenSwitchRight(
                  enterPage: OrderFoodScreen(
                bookingModel: dataBooking,
                    tablesModel: dataModel,
              )));

          return;
        },
        error: (error) {
          DialogLoading.hiddenLoading(context);
          return;
        });
  }

  bool isCheckForm({int seating}) {
    if (controllerCustomerName.text.isEmpty) {
      _controllerName.sink.add("Bạn chưa nhập tên khách hàng");
      return false;
    }
    _controllerName.sink.add("");

    if (controllerPhone.text.isEmpty || controllerPhone.text.length < 10 || controllerPhone.text.length > 11) {
      _controllerPhone.sink.add("Số điện thoại định dạng sai");
      return false;
    }
    _controllerPhone.sink.add("");


    if (controllerAmountOfPeople.text.isEmpty) {
      _controllerAmountOfPeople.sink.add("Bạn chưa nhập số người");
      return false;
    }else if(seating < int.parse(controllerAmountOfPeople.text)){
      _controllerAmountOfPeople.sink.add("Số người không được nhập quá $seating người");
      return false;
    }
    _controllerAmountOfPeople.sink.add("");


    return true;
  }

  updateStatusTable({int id}) async {
    await _dataNetwork.updateStatusTable(
        idTable: id,
        status: true,
        dataSuccess: (dataSuccess) {
          return;
        },
        error: (error) {
          return;
        });
  }

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
