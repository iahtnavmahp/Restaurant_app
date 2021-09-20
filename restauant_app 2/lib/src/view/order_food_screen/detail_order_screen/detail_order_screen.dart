import 'dart:async';

import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:restauant_app/src/model/booking_model.dart';
import 'package:restauant_app/src/model/detail_order_model.dart';
import 'package:restauant_app/src/model/food_model.dart';
import 'package:restauant_app/src/model/payment_model.dart';
import 'package:restauant_app/src/model/tables_model.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/button_custom.dart';
import 'package:restauant_app/src/utils/component/loading_custom.dart';
import 'package:restauant_app/src/view/order_food_screen/detail_order_screen/detail_order_bloc.dart';

class DetailOrderScreen extends StatefulWidget {
  DetailOrderScreen({this.bookingModel, this.tablesModel});

  BookingModel bookingModel;
  TablesModel tablesModel;

  @override
  _DetailOrderScreenState createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
  DetailOrderBloc bloc = DetailOrderBloc();
  final lowPrice = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      bloc.getDetailOrder(context: context, id: widget.bookingModel.customer.id).then((value) {
        if(value == null){
          Navigator.pop(context);
          bloc.showToast(
            message: "Hiện tại bàn này chưa tạo order"
          );
          return;
        }
        bloc.getAllOrderDetail(id: value.id);
      });
    });
    // bloc.getAllPayments();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: 18,
            )),
        title: Text(
          "${widget.bookingModel.restaurantTables[0].tableNumber}",
          style: TextStyle(fontSize: 15),
        ),
        backgroundColor: ColorCustom.colorTheem,
        flexibleSpace: gradientCustom(),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(top: Adaptive.sp(20), bottom: Adaptive.sp(15), right: Adaptive.sp(10), left: Adaptive.sp(10)),
        child: StreamBuilder(
            stream: bloc.streamDetailOrder,
            builder: (context, snapshot) {
              DetailOrderModel dataModel;
              List<Food> listData = [];
              if (snapshot.hasData) {
                dataModel = snapshot.data;
                listData = dataModel.foods;
                DateTime createdDate = DateTime.fromMillisecondsSinceEpoch(dataModel.orderTime);
                var outputFormat = DateFormat('dd/MM/yyyy');
                String dateNews = outputFormat.format(createdDate);
                return Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              "Hoá đơn khách hàng ${widget.bookingModel.restaurantTables[0].tableNumber}",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: Adaptive.sp(10), bottom: Adaptive.sp(10), right: Adaptive.sp(10), left: Adaptive.sp(10)),
                            width: size.width,
                            child: Column(
                              children: [
                                _itemRow(title: "Tên khách hàng: ", data: dataModel.customer.name),
                                _itemRow(title: "Số điện thoại: ", data: dataModel.customer.phone.toString()),
                                _itemRow(title: "Thời gian: ", data: dateNews),
                                StreamBuilder(
                                    stream: bloc.streamTotalPrice,
                                    builder: (context, snapshot) {
                                      double totalPrice = snapshot.hasData ? snapshot.data : 0;
                                      lowPrice.updateValue(totalPrice);
                                      String price = lowPrice.text.substring(0, lowPrice.text.length - 3);
                                      // ignore: unrelated_type_equality_checks
                                      return price != null && price != 0
                                          ? _itemRow(title: "Tổng thành tiền: ", data: price.toString() + " đ")
                                          : SizedBox();
                                    }),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width,
                            padding: EdgeInsets.only(top: Adaptive.sp(20), bottom: Adaptive.sp(0)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: size.width / 10,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "STT",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        )),
                                    Container(
                                      width: size.width / 4,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Tên món ăn",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: size.width / 2,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Giá",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  width: size.width,
                                  height: 1,
                                  color: ColorCustom.GREY,
                                  margin: EdgeInsets.only(top: Adaptive.sp(18)),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: StreamBuilder(
                                stream: bloc.streamListFood,
                                builder: (context, snapshot) {
                                  List<FoodModel> listFood = [];
                                  if (snapshot.hasData) {
                                    listFood = snapshot.data;
                                    return listFood.length > 0
                                        ? ListView.builder(
                                            itemCount: listFood.length,
                                            // shrinkWrap: true,
                                            padding: EdgeInsets.all(0),
                                            itemBuilder: (context, index) {
                                              FoodModel dataFood = listFood[index];
                                              return _item(dataFood: dataFood, index: index, maxIndex: listFood.length, size: size);
                                            })
                                        : Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(top: Adaptive.sp(30)),
                                            child: Text("Chưa có món ăn nào."),
                                          );
                                  } else {
                                    return LodingCustom();
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                    ButtonCustom(
                      margin: EdgeInsets.only(
                        bottom: Adaptive.sp(20),
                        left: Adaptive.sp(20),
                        right: Adaptive.sp(20),
                        top: Adaptive.sp(20),
                      ),
                      title: "CHECKOUT",
                      onClick: () {
                        bloc.getAllPayments(context: context).then(
                          (value) {
                            if (value.length > 0) {
                              dialogAddCategory(list: value);
                            } else {
                              bloc.editOrder(
                                context: context,
                                bookingModel: widget.bookingModel,
                                tablesModel: widget.tablesModel,
                                methodType: 1,);
                            }
                          },
                        );
                        },
                    )
                  ],
                );
              } else {
                return LodingCustom();
              }
            }),
      ),
    );
  }

  Widget _itemRow({String title, String data}) {
    return Container(
      margin: EdgeInsets.only(top: Adaptive.sp(15)),
      child: Row(
        children: [
          Text(
            "$title",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 1.5, letterSpacing: 0.5),
          ),
          Text("$data", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15, height: 1.5, letterSpacing: 0.5)),
        ],
      ),
    );
  }

  Widget _item({FoodModel dataFood, int index, int maxIndex, Size size}) {
    double priceFood = dataFood.price * dataFood.quantity;
    lowPrice.updateValue(priceFood);
    String price = lowPrice.text.substring(0, lowPrice.text.length - 3);
    return InkWell(
      onTap: () {
        dialogShowFood(dataFood: dataFood);
      },
      child: Column(
        children: [
          Container(
            width: size.width,
            padding: EdgeInsets.only(top: Adaptive.sp(15), bottom: Adaptive.sp(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: size.width / 9,
                    alignment: Alignment.center,
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13
                      ),
                    )),
                Container(
                  width: size.width / 4,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    dataFood.name,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                      letterSpacing: 0.5,
                      fontSize: 13,
                    ),
                  ),
                ),
                Container(
                  width: size.width / 2,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: Adaptive.sp(10)),
                  child: Text(
                    price.toString() + " đ",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                      letterSpacing: 0.5,
                      fontSize: 13,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: size.width,
            height: 1,
            color: index + 1 == maxIndex ? ColorCustom.WHITE : ColorCustom.GREY,
          )
        ],
      ),
    );
  }

  Widget _itemDialog({String title, String data}) {
    return Container(
      margin: EdgeInsets.only(top: Adaptive.w(2)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$title: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Text(
            "$data",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
          ),
        ],
      ),
    );
  }

  dialogShowFood({FoodModel dataFood}) {
    double priceFood = dataFood.price * dataFood.quantity;
    lowPrice.updateValue(priceFood);
    String price = lowPrice.text.substring(0, lowPrice.text.length - 3);
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _itemDialog(title: "Tên món ăn", data: dataFood.name),
              _itemDialog(title: "Số lượng món ăn", data: dataFood.quantity.toString()),
              _itemDialog(title: "Tổng giá", data: price.toString() + " đ"),
            ],
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: Adaptive.w(20),
              height: Adaptive.w(7),
              alignment: Alignment.center,
              child: new Text(
                "Đóng",
                textAlign: TextAlign.center,
                style: TextStyle(color: ColorCustom.BLUE, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  dialogAddCategory({List<PaymentModel> list}) {
    Size size = MediaQuery.of(context).size;
    String dropdownValue = list[0].title;
    PaymentModel paymentModel;
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              list.length > 0
                  ? StreamBuilder(
                      stream: bloc.streamSetTitleComboBox,
                      builder: (context, snapshot) {
                        paymentModel = snapshot.hasData ? snapshot.data : list[0];
                        return DropdownButton<PaymentModel>(
                          value: paymentModel,
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                          ),
                          hint: Text(
                            "Select tags",
                            style: TextStyle(color: Color(0xFF9F9F9F)),
                          ),
                          items: list.map<DropdownMenuItem<PaymentModel>>((PaymentModel value) {
                            return DropdownMenuItem<PaymentModel>(
                              value: value,
                              child: Text(value.title),
                            );
                          }).toList(),
                          onChanged: (PaymentModel value) {
                            bloc.setDataComboBox(value);
                          },
                        );
                      })
                  : SizedBox()
            ],
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: Adaptive.w(20),
              height: Adaptive.w(7),
              alignment: Alignment.center,
              child: new Text(
                'Huỷ',
                textAlign: TextAlign.center,
                style: TextStyle(color: ColorCustom.RED, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              bloc.editOrder(
                  context: context,
                  bookingModel: widget.bookingModel,
                  tablesModel: widget.tablesModel,
                  methodType: paymentModel.methodType,);
            },
            child: Container(
              width: Adaptive.w(20),
              height: Adaptive.w(7),
              alignment: Alignment.center,
              child: new Text(
                "Xác nhận",
                textAlign: TextAlign.center,
                style: TextStyle(color: ColorCustom.BLUE, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
