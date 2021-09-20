import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:restauant_app/src/model/booking_model.dart';
import 'package:restauant_app/src/model/food_model.dart';
import 'package:restauant_app/src/utils/animation/push_screen_switch_let.dart';
import 'package:restauant_app/src/utils/animation/push_screen_switch_right.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/button_custom.dart';
import 'package:restauant_app/src/utils/component/item_row.dart';
import 'package:restauant_app/src/view/home_screen/home_screen.dart';
import 'package:restauant_app/src/view/order_food_screen/create_order_screen/create_order_bloc.dart';
import 'package:restauant_app/src/view/order_food_screen/order_food_bloc.dart';
import 'package:restauant_app/src/view/order_food_screen/order_food_screen.dart';

// ignore: must_be_immutable
class CreateOrderScreen extends StatefulWidget {
  CreateOrderScreen({this.listData, this.bookingModel, this.orderFoodBloc});

  BookingModel bookingModel;
  OrderFoodBloc orderFoodBloc;
  List<FoodModel> listData;

  // DetailOrderModel orderModel;

  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  CreateOrderBloc bloc = CreateOrderBloc();
  final lowPrice = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  @override
  void initState() {
    super.initState();
    bloc.getListFood(listFood: widget.listData);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              dialogCancel();
            },
            child: Icon(
              Icons.arrow_back,
              size: 18
            )),
        title: Text(
          "Danh sách món order",
          style: TextStyle(fontSize: 15),
        ),
        backgroundColor: ColorCustom.colorTheem,
        flexibleSpace: gradientCustom(),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.only(
                  left: Adaptive.sp(20),
                  right: Adaptive.sp(20),
                  bottom: Adaptive.sp(20),
                  top: Adaptive.sp(5),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: StreamBuilder(
                          stream: bloc.streamGetFood,
                          builder: (context, snapshot) {
                            List<FoodModel> listData = snapshot.hasData ? snapshot.data : [];
                            return ListView.builder(
                                itemCount: listData.length,
                                padding: EdgeInsets.only(top: 0),
                                itemBuilder: (context, index) {
                                  FoodModel dataModel = listData[index];
                                  double priceM = dataModel.price * dataModel.quantity;
                                  lowPrice.updateValue(priceM);
                                  String price = lowPrice.text.substring(0, lowPrice.text.length - 3);
                                  return ItemRow(
                                    index: index + 1,
                                    maxIndex: widget.listData.length,
                                    name: dataModel.name ?? "null",
                                    price: price.toString() ?? "null",
                                    onTap: () async {
                                      dialogShowFood(dataFood: dataModel, index: index);
                                    },
                                  );
                                });
                          }),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        child: StreamBuilder(
                            stream: bloc.streamTotalPrice,
                            builder: (context, snapshot) {
                              double totalPrice = snapshot.hasData ? snapshot.data : 0;
                              lowPrice.updateValue(totalPrice);
                              String price = lowPrice.text.substring(0, lowPrice.text.length - 3);
                              return Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: Adaptive.sp(20), bottom: Adaptive.sp(20)),
                                    width: size.width,
                                    height: 1,
                                    color: ColorCustom.GREY,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Tổng giá tiền: ",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: ColorCustom.RED),
                                      ),
                                      Text(
                                        "$price đ",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: ColorCustom.RED),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: ButtonCustom(
                title: "Xác nhận",
                onClick: () {
                  dialogConfirm();
                },
                margin: EdgeInsets.only(
                  left: Adaptive.sp(20),
                  right: Adaptive.sp(20),
                  bottom: Adaptive.sp(35),
                  top: Adaptive.sp(20),
                ),
              ),
            )
          ],
        ),
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

  dialogShowFood({FoodModel dataFood, int index}) {
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
            onTap: () async {
              widget.listData.removeAt(index);
              bloc.getListFood(listFood: widget.listData);
              Navigator.pop(context);
            },
            child: Container(
              width: Adaptive.w(25),
              height: Adaptive.w(7),
              alignment: Alignment.center,
              child: new Text(
                "Xoá món ăn",
                textAlign: TextAlign.center,
                style: TextStyle(color: ColorCustom.RED, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: Adaptive.w(18),
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

  dialogConfirm() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text("Xác nhận"),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Text("Bạn có chắc chắn muốn tạo order không?"),
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
              if (widget.bookingModel.isOrder == false) {
                bloc.createOrder(context: context, listData: widget.listData, bookingModel: widget.bookingModel).then((value) {
                  widget.orderFoodBloc.listDataOrder.clear();
                  Navigator.of(context).pushAndRemoveUntil(PushScreenSwitchRight(enterPage: HomeScreen()), (Route<dynamic> route) => false);
                });
              } else {
                bloc.getDetailOrder(id: widget.bookingModel.customer.id).then((value) {
                  if (value.id != null) {
                    bloc.orderAddFood(context: context, listData: widget.listData, idOrder: value.id).then((value) {
                      widget.orderFoodBloc.listDataOrder.clear();
                      Navigator.of(context)
                          .pushAndRemoveUntil(PushScreenSwitchRight(enterPage: HomeScreen()), (Route<dynamic> route) => false);
                    });
                  }
                });
              }
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


  dialogCancel() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text("Huỷ đơn", style: TextStyle(
          color: ColorCustom.RED
        ),),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Text("Bạn có chắc chắn muốn tạo huỷ đơn không?"),
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
                'Đóng',
                textAlign: TextAlign.center,
                style: TextStyle(color: ColorCustom.RED, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          InkWell(
            onTap: () {

              Navigator.of(context).pushAndRemoveUntil(
                  PushScreenSwitchLeft(
                    enterPage: OrderFoodScreen(),
                  ),
                      (Route<dynamic> route) => false);
            },
            child: Container(
              width: Adaptive.w(20),
              height: Adaptive.w(7),
              alignment: Alignment.center,
              child: new Text(
                "Đồng ý",
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
