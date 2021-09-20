import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:restauant_app/src/data_network/data_network.dart';
import 'package:restauant_app/src/data_network/request/request_food_order.dart';
import 'package:restauant_app/src/model/booking_model.dart';
import 'package:restauant_app/src/model/detail_order_model.dart';
import 'package:restauant_app/src/model/food_model.dart';
import 'package:restauant_app/src/model/payment_model.dart';
import 'package:restauant_app/src/model/tables_model.dart';
import 'package:restauant_app/src/utils/animation/push_screen_switch_let.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/dialog_custom/dialog_loading.dart';
import 'package:restauant_app/src/view/home_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailOrderBloc {
  DataNetwork _dataNetwork = DataNetwork();
  StreamController _controllerDetailOrder = StreamController.broadcast();
  StreamController _controllerTotalPrice = StreamController();
  StreamController _controllerListFood = StreamController();
  StreamController _controllerGetAllPayments = StreamController.broadcast();
  StreamController _controllerSetTitleComboBox = StreamController.broadcast();

  Stream get streamDetailOrder => _controllerDetailOrder.stream;

  Stream get streamListFood => _controllerListFood.stream;

  Stream get streamTotalPrice => _controllerTotalPrice.stream;

  Stream get streamGetAllPayments => _controllerGetAllPayments.stream;

  Stream get streamSetTitleComboBox => _controllerSetTitleComboBox.stream;

  dispose() {
    _controllerDetailOrder.close();
    _controllerTotalPrice.close();
    _controllerGetAllPayments.close();
    _controllerSetTitleComboBox.close();
    _controllerListFood.close();
  }

  double totalPrice = 0;
  List<FoodModel> listData = [];
  DetailOrderModel dataModelOrder;

  void getTotalPrice(double price) => _controllerTotalPrice.sink.add(price);

  void setDataComboBox(PaymentModel paymentModel) => _controllerSetTitleComboBox.sink.add(paymentModel);

  Future<DetailOrderModel> getDetailOrder({BuildContext context, int id}) async {
    await _dataNetwork.getDetailOrder(
        id: id,
        dataSuccess: (dataSuccess) {
          dataModelOrder = dataSuccess;
          _controllerDetailOrder.sink.add(dataSuccess);
          return;
        },
        error: (error) {
          Navigator.pop(context);
          return;
        });
    return dataModelOrder;
  }

  Future<List<FoodModel>> getAllOrderDetail({int id}) async {
    await _dataNetwork.getAllOrderDetail(
        id: id,
        dataSuccess: (dataSuccess) {
          listData = dataSuccess;
          for (FoodModel item in listData) {
            double priceTo = item.price * item.quantity;
            totalPrice = totalPrice + priceTo;
          }
          getTotalPrice(totalPrice);
          _controllerListFood.sink.add(dataSuccess);
          return;
        },
        error: (error) {
          return;
        });
    return listData;
  }

  Future<BookingModel> editBooking({
    BuildContext context,
    BookingModel bookingModel,
    TablesModel tablesModel,
    int methodType,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    BookingModel dataModel;
    DialogLoading.showLoading(context);
    await _dataNetwork.editBooking(
        bookingModel: bookingModel,
        tablesModel: tablesModel,
        methodType: methodType,
        userCheckout: sharedPreferences.getString(Constant.KEY_FULLNAME),
        dataSuccess: (dataSuccess) {
          DialogLoading.hiddenLoading(context);
          dataModel = dataSuccess;

          Navigator.of(context).pushAndRemoveUntil(PushScreenSwitchRight(enterPage: HomeScreen()), (Route<dynamic> route) => false);
          showToast(message: "Thanh toán thành công");
          return;
        },
        error: (error) {
          DialogLoading.hiddenLoading(context);
          return;
        });

    return dataModel;
  }

  Future<void> editOrder({
    BuildContext context,
    int idOrder,
    BookingModel bookingModel,
    TablesModel tablesModel,
    int methodType,
  }) async {
    List<RequestEditOrder> listFood = [];

    for (var i = 0; i < listData.length; i++)
      listFood.add(RequestEditOrder(
        price: listData[i].price,
        id: listData[i].id,
        imageUrl: listData[i].imageUrl,
        name: listData[i].name,
        description: listData[i].description,
        status: true,
        category_id: listData[i].id,
      ));


    DialogLoading.showLoading(context);
    print(listFood.toString());
    await _dataNetwork.editOrder(
        id: dataModelOrder.id,
        totalPrice: totalPrice,
        dataSuccess: (dataSuccess) {
          DialogLoading.hiddenLoading(context);
          editBooking(methodType: methodType, context: context, tablesModel: tablesModel, bookingModel: bookingModel);

          return;
        },
        error: (error) {
          DialogLoading.hiddenLoading(context);
          return;
        });

    return true;
  }

  Future<List<PaymentModel>> getAllPayments({BuildContext context}) async {
    List<PaymentModel> dataModel;
    DialogLoading.showLoading(context);

    await _dataNetwork.getAllPayments(dataSuccess: (dataSuccess) {
      DialogLoading.hiddenLoading(context);

      dataModel = dataSuccess;
      _controllerGetAllPayments.sink.add(dataModel);
      return;
    }, error: (error) {
      DialogLoading.hiddenLoading(context);

      return;
    });

    return dataModel;
  }

  showToast({String message}) {
    Fluttertoast.showToast(
        msg: "$message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
