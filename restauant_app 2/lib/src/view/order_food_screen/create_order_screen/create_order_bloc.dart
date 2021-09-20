import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:restauant_app/src/data_network/data_network.dart';
import 'package:restauant_app/src/data_network/request/request_food_order.dart';
import 'package:restauant_app/src/model/booking_model.dart';
import 'package:restauant_app/src/model/detail_order_model.dart';
import 'package:restauant_app/src/model/food_model.dart';
import 'package:restauant_app/src/model/order_model.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/dialog_custom/dialog_loading.dart';

class CreateOrderBloc {
  DataNetwork _dataNetwork = DataNetwork();

  StreamController _controllerTotalPrice = StreamController();
  StreamController _controllerGetFood = StreamController();

  Stream get streamTotalPrice => _controllerTotalPrice.stream;

  Stream get streamGetFood => _controllerGetFood.stream;

  dispose() {
    _controllerTotalPrice.close();
    _controllerGetFood.close();
  }

  getListFood({List<FoodModel> listFood}) {
    _controllerGetFood.sink.add(listFood);
    getTotalPrice(listFood: listFood);
  }

  Future<OrderModel> createOrder({BuildContext context, List<FoodModel> listData, BookingModel bookingModel}) async {
    // List<CustomerOder> listOder = [];

    // for (var i = 0; i < listData.length; i++) listOder.add(CustomerOder(id: listData[i].id));
    OrderModel dataMode;
    DialogLoading.showLoading(context);
    await _dataNetwork.createOrder(
        bookingModel: bookingModel,
        // listFood: listData,
        dataSuccess: (dataSuccess) {
          dataMode = dataSuccess;
          orderAddFood(context: context, idOrder: dataMode.id, listData: listData);
          DialogLoading.hiddenLoading(context);
          return;
        },
        error: (error) {
          DialogLoading.hiddenLoading(context);
          showToast("Tạo order thất bại");
          return;
        });
    DialogLoading.hiddenLoading(context);
    return dataMode;
  }

  Future<void> orderAddFood({BuildContext context, List<FoodModel> listData, int idOrder}) async {
    List<RequestAddFood> listFood = [];
    // DialogLoading.showLoading(context);
    DialogLoading.showLoading(context);

    for (var i = 0; i < listData.length; i++)
      listFood.add(RequestAddFood(
          orderId: idOrder, foodId: listData[i].id, quantity: listData[i].quantity, price: listData[i].price * listData[i].quantity));


    await _dataNetwork.orderAddFood(
        listFood: listFood,
        dataSuccess: (dataSuccess) {
          showToast("Gọi món thành công");
          DialogLoading.hiddenLoading(context);
          return;
        },
        error: (error) {
          DialogLoading.hiddenLoading(context);

          return;
        });

    DialogLoading.hiddenLoading(context);
    return true;
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

  getTotalPrice({List<FoodModel> listFood}) {
    double totalPrice = 0;
    for (FoodModel item in listFood) {
      double price = item.price * item.quantity;
      totalPrice = totalPrice + price;
    }
    _controllerTotalPrice.sink.add(totalPrice);
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
}
