import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:restauant_app/src/model/all_order_model.dart';
import 'package:restauant_app/src/model/booking_model.dart';
import 'package:restauant_app/src/model/category_model.dart';
import 'package:restauant_app/src/model/detail_order_model.dart';
import 'package:restauant_app/src/model/food_model.dart';
import 'package:restauant_app/src/model/order_model.dart';
import 'package:restauant_app/src/model/payment_model.dart';
import 'package:restauant_app/src/model/statistics_of_the_year_model.dart';
import 'package:restauant_app/src/model/tables_model.dart';
import 'package:restauant_app/src/model/user_model.dart';
import 'package:restauant_app/src/model/user_model_v2.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/base/base_network.dart';
import 'package:restauant_app/src/utils/component/dialog_custom/dialog_loading.dart';

import 'request/request_food_order.dart';

class DataNetwork {
  BaseNetwork _baseNetwork = BaseNetwork();

  Future<UserModel> logIn(
    BuildContext context, {
    @required String username,
    @required String password,
    @required Function dataSuccess(object),
    @required Function error(err),
  }) async {
    UserModel userModel = UserModel();
    var paramUrl = Constant.urlLink + "/api/auth/signin";
    Map<String, dynamic> body = {"username": username, "password": password};

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.POST,
      body: body,
      success: (object) {
        userModel = UserModel.fromJson(object);
        return dataSuccess(UserModel.fromJson(object));
      },
      error: (err) {
        print("Error: $err");
        showToast(message: "Tài khoản hoặc mật khẩu không chính xác");
        DialogLoading.hiddenLoading(context);

        return;
      },
    );
    return userModel;
  }

  Future<List<TablesModel>> getListHome({
    @required Function dataSuccess(object),
    @required Function error(err),
  }) async {
    List<TablesModel> listHome = [];
    var paramUrl = Constant.urlLink + "/api/table/restaurant-tables";

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.GET,
      success: (data) {
        for (var item in data) {
          listHome.add(TablesModel.fromJson(item));
        }
        return dataSuccess(listHome);
      },
      error: (err) {
        print("Error: $err");
        return;
      },
    );
    return listHome;
  }

  Future<List<UserModelV2>> getListUser(
      {@required Function dataSuccess(object), @required Function error(err), int limit: 15, int offset: 0}) async {
    List<UserModelV2> listUser = [];
    var paramUrl = Constant.urlLink + "/api/user/getAllUser/?limit=$limit&offset=$offset";

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.GET,
      success: (data) {
        for (var item in data) {
          listUser.add(UserModelV2.fromJson(item));
        }
        return dataSuccess(listUser);
      },
      error: (err) {
        print("Error: $err");
        return;
      },
    );
    return listUser;
  }

  Future<void> createUser({
    @required Function dataSuccess(object),
    @required Function error(err),
    String name,
    String password,
    String phoneNumber,
    String roles,
    String username,
  }) async {
    var paramUrl = Constant.urlLink + "/api/user/createUser";
    Map<String, dynamic> body = {
      "name": "$name",
      "password": "$password",
      "phoneNumber": "$phoneNumber",
      "roles": [
        {"name": "$roles"}
      ],
      "username": "$username"
    };

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.POST,
      body: body,
      success: (data) {

        return dataSuccess(data);
      },
      error: (err) {
        print("Error: $err");
        return;
      },
    );
    return true;
  }

  Future<void> editUser({
    int id,
    int idRoles,
    String name,
    String password,
    String phoneNumber,
    String roles,
    String username,
    String birthday,
    String address,
    @required Function dataSuccess(object),
    @required Function error(err),
  }) async {
    var paramUrl = Constant.urlLink + "/api/user/editUser/$id";
    Map<String, dynamic> body = {
      "address": address,
      "birthday": birthday,
      "id": id,
      "name": name,
      "password": password,
      "phoneNumber": phoneNumber,
      "roles": [
        {"id": idRoles, "name": roles}
      ],
      "status": true,
      "username": username
    };

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.PUT_BODY,
      body: body,
      success: (data) {

        return dataSuccess(data);
      },
      error: (err) {
        print("Error: $err");
        return;
      },
    );
    return true;
  }

  Future<void> deleteUser({@required Function dataSuccess(object), @required Function error(err), int id}) async {
    var paramUrl = Constant.urlLink + "/api/user/delete/$id";

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.DELETE,
      success: (data) {
        return;
      },
      error: (err) {
        print("Error: $err");
        return;
      },
    );
  }

  Future<BookingModel> createBooking(
      {String customerName,
      String customerPhone,
      String note,
      String numberInParty,
      String location,
      String posivition,
      String seating,
      String tableNumber,
      String userCheckin,
      int idTable,
      @required Function dataSuccess(object),
      @required Function error(err)}) async {
    var paramUrl = Constant.urlLink + "/api/bookings/createBooking";
    BookingModel dataModel;
    Map<String, dynamic> body = {
      "customer": {"name": "$customerName", "phone": "$customerPhone", "status": true},
      "notes": "$note",
      "numberInParty": numberInParty,
      "restaurantTables": [
        {
          "id": idTable,
          "location": "$location",
          "posivition": "$posivition",
          "seating": seating,
          "status": true,
          "tableNumber": "$tableNumber"
        }
      ],
      "status": true,
      "userCheckin": userCheckin
    };

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.POST,
      body: body,
      success: (data) {
        dataModel = BookingModel.fromJson(data);
        return dataSuccess(BookingModel.fromJson(data));
      },
      error: (err) {
        print("Error: $err");
        return;
      },
    );
    return dataModel;
  }

  Future<void> updateStatusTable({bool status, int idTable, @required Function dataSuccess(object), @required Function error(err)}) async {
    var paramUrl = Constant.urlLink + "/api/table/editStatusTable/?id=$idTable&status=$status";
    Map<String, dynamic> body = {};

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.PUT,
      body: body,
      success: (data) {
        return;
      },
      error: (err) {
        print("Error: $err");
        return;
      },
    );
  }

  Future<BookingModel> getBookings({int id, @required Function dataSuccess(object), @required Function error(err)}) async {
    BookingModel dataModel;
    var paramUrl = Constant.urlLink + "/api/bookings/table/$id";

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.GET,
      success: (data) {
        dataModel = BookingModel.fromJson(data);

        return dataSuccess(BookingModel.fromJson(data));
      },
      error: (err) {
        print("Error: $err");
        return;
      },
    );
    return dataModel;
  }

  Future<List<BookingModel>> getAllBooking({@required Function dataSuccess(object), @required Function error(err)}) async {
    List<BookingModel> listData = [];
    var paramUrl = Constant.urlLink + "/api/bookings/getAllBooking";

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.GET,
      success: (data) {
        for (var item in data) {
          listData.add(BookingModel.fromJson(item));
        }
        return dataSuccess(listData);
      },
      error: (err) {
        print("Error: $err");
        return;
      },
    );
    return listData;
  }

  Future<List<CategoryModel>> getAllCategories({@required Function dataSuccess(object), @required Function error(err)}) async {
    List<CategoryModel> listData = [];
    var paramUrl = Constant.urlLink + "/api/categories/getAllCategories";

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.GET,
      success: (data) {
        for (var item in data) {
          listData.add(CategoryModel.fromJson(item));
        }
        return dataSuccess(listData);
      },
      error: (err) {
        print("Error: $err");
        return;
      },
    );
    return listData;
  }

  Future<List<FoodModel>> getFoodId({int id, @required Function dataSuccess(object), @required Function error(err)}) async {
    List<FoodModel> listData = [];
    var paramUrl = Constant.urlLink + "/api/food/getFoodByCategoryId/$id";

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.GET,
      success: (data) {
        for (var item in data) {
          listData.add(FoodModel.fromJson(item));
        }
        return dataSuccess(listData);
      },
      error: (err) {
        print("Error: $err");
        return;
      },
    );
    return listData;
  }

  Future<OrderModel> createOrder(
      {List<FoodModel> listFood,
      BookingModel bookingModel,
      int discount: 0,
      @required Function dataSuccess(object),
      @required Function error(err)}) async {
    var paramUrl = Constant.urlLink + "/api/order/createOrder";
    OrderModel dataMode;
    Map<String, dynamic> body = {
      "customer": bookingModel.customer,
      "discount": discount,
      "foods": listFood,
      "status": true,
      "isOrder": true
    };
    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.POST,
      body: body,
      success: (data) {
        dataMode = OrderModel.fromJson(data);
        return dataSuccess(OrderModel.fromJson(data));
      },
      error: (err) {
        return;
      },
    );
    return dataMode;
  }

  Future<void> orderAddFood({List<RequestAddFood> listFood, @required Function dataSuccess(object), @required Function error(err)}) async {
    var paramUrl = Constant.urlLink + "/api/orderDetail/addFood/";

    Map<String, dynamic> body = {"listFoods": listFood};

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.POST,
      body: body,
      success: (data) {
        return dataSuccess(data);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<DetailOrderModel> getDetailOrder({int id, @required Function dataSuccess(object), @required Function error(err)}) async {
    var paramUrl = Constant.urlLink + "/api/order/mob/customer/$id";
    DetailOrderModel dataMode;
    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.GET,
      success: (data) {
        dataMode = DetailOrderModel.fromJson(data);

        return dataSuccess(DetailOrderModel.fromJson(data));
      },
      error: (err) {
        return;
      },
    );
    return dataMode;
  }

  Future<List<FoodModel>> getAllOrderDetail({int id, @required Function dataSuccess(object), @required Function error(err)}) async {
    var paramUrl = Constant.urlLink + "/api/orderDetail/getAllOrderDetail/$id";
    List<FoodModel> listData = [];

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.GET,
      success: (data) {
        for (var item in data) {
          listData.add(FoodModel.fromJson(item));
        }

        return dataSuccess(listData);
      },
      error: (err) {
        return;
      },
    );
    return listData;
  }

  Future<List<PaymentModel>> getAllPayments({@required Function dataSuccess(object), @required Function error(err)}) async {
    var paramUrl = Constant.urlLink + "/api/payment/getAllPayments";
    List<PaymentModel> listData = [];
    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.GET,
      success: (data) {
        for (var item in data) {
          listData.add(PaymentModel.fromJson(item));
        }

        return dataSuccess(listData);
      },
      error: (err) {
        return;
      },
    );
    return listData;
  }

  Future<BookingModel> editBooking(
      {BookingModel bookingModel,
      String userCheckout,
      int methodType,
      TablesModel tablesModel,
      @required Function dataSuccess(object),
      @required Function error(err)}) async {
    var paramUrl = Constant.urlLink + "/api/bookings/editBooking/${bookingModel.id}";
    BookingModel dataMode;
    Map<String, dynamic> body = {
      "customer": {"name": bookingModel.customer.name, "phone": bookingModel.customer.phone, "status": true},
      "numberInParty": bookingModel.numberInParty,
      "methodType": methodType,
      "restaurantTables": [
        {
          "id": tablesModel.id,
          "location": tablesModel.location,
          "posivition": tablesModel.posivition,
          "seating": tablesModel.seating,
          "status": false,
          "tableNumber": tablesModel.tableNumber
        }
      ],
      "status": false,
      "isOrder": false
    };
    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.POST,
      body: body,
      success: (data) {
        dataMode = BookingModel.fromJson(data);

        return dataSuccess(BookingModel.fromJson(data));
      },
      error: (err) {
        return;
      },
    );
    return dataMode;
  }

  Future<void> editOrder(
      {int id,
      double totalPrice,
      @required Function dataSuccess(object),
      @required Function error(err)}) async {
    var paramUrl = Constant.urlLink + "/api/order/editOrder/$id";
    Map<String, dynamic> body = {
      "totalPrice": totalPrice,
    };
    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.PUT_BODY,
      body: body,
      success: (data) {

        return dataSuccess(data);
      },
      error: (err) {
        return;
      },
    );
    return true;
  }

  Future<List<FoodModel>> getAllFood({@required Function dataSuccess(object), @required Function error(err)}) async {
    List<FoodModel> listData = [];
    var paramUrl = Constant.urlLink + "/api/food/getAllFoods";

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.GET,
      success: (data) {
        for (var item in data) {
          listData.add(FoodModel.fromJson(item));
        }
        return dataSuccess(listData);
      },
      error: (err) {
        print("Error: $err");
        return;
      },
    );
    return listData;
  }

  Future<List<AllOrderModel>> getAllOrders({@required Function dataSuccess(object), @required Function error(err)}) async {
    List<AllOrderModel> listData = [];
    var paramUrl = Constant.urlLink + "/api/order/getAllOrders";

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.GET,
      success: (data) {
        for (var item in data) {
          listData.add(AllOrderModel.fromJson(item));
        }
        return dataSuccess(listData);
      },
      error: (err) {
        print("Error: $err");
        return;
      },
    );
    return listData;
  }

  Future<List<StatisticsOfTheYearModel>> getAnalysisOrder({@required Function dataSuccess(object), @required Function error(err)}) async {
    List<StatisticsOfTheYearModel> listData = [];
    var paramUrl = Constant.urlLink + "/api/orderDetail/getAnalysisOrder";

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.GET,
      success: (data) {
        for (var item in data) {
          listData.add(StatisticsOfTheYearModel.fromJson(item));
        }
        return dataSuccess(listData);
      },
      error: (err) {
        print("Error: $err");
        return;
      },
    );
    return listData;
  }
  Future<List<StatisticsOfTheYearModel>> getAnalysisOrderByDay({@required Function dataSuccess(object), @required Function error(err)}) async {
    List<StatisticsOfTheYearModel> listData = [];
    var paramUrl = Constant.urlLink + "/api/orderDetail/getAnalysisOrderByDay";

    await _baseNetwork.networkService(
      paramUrl: paramUrl,
      functionType: FunctionType.GET,
      success: (data) {
        for (var item in data) {
          listData.add(StatisticsOfTheYearModel.fromJson(item));
        }
        return dataSuccess(listData);
      },
      error: (err) {
        print("Error: $err");
        return;
      },
    );
    return listData;
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
