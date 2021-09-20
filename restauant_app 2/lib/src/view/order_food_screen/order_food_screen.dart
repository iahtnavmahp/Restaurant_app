import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:restauant_app/src/model/booking_model.dart';
import 'package:restauant_app/src/model/category_model.dart';
import 'package:restauant_app/src/model/food_model.dart';
import 'package:restauant_app/src/model/tables_model.dart';
import 'package:restauant_app/src/utils/animation/push_screen_switch_let.dart';
import 'package:restauant_app/src/utils/animation/push_screen_switch_right.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/button_custom.dart';
import 'package:restauant_app/src/utils/component/item_line.dart';
import 'package:restauant_app/src/utils/component/item_menu.dart';
import 'package:restauant_app/src/utils/component/loading_custom.dart';
import 'package:restauant_app/src/utils/component/text_field_custom.dart';
import 'package:restauant_app/src/view/home_screen/home_screen.dart';
import 'package:restauant_app/src/view/order_food_screen/food_screen/food_screen.dart';
import 'package:restauant_app/src/view/order_food_screen/order_food_bloc.dart';

import 'create_order_screen/create_order_screen.dart';
import 'detail_order_screen/detail_order_screen.dart';

class OrderFoodScreen extends StatefulWidget {
  OrderFoodScreen({this.nameBan, this.bookingModel, this.tablesModel});

  final String nameBan;
  final TablesModel tablesModel;
  BookingModel bookingModel;

  @override
  _OrderFoodScreenState createState() => _OrderFoodScreenState();
}

class _OrderFoodScreenState extends State<OrderFoodScreen> {
  OrderFoodBloc bloc = OrderFoodBloc();
  List<FoodModel> listFood = [];
  final lowPrice = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  @override
  void initState() {
    super.initState();
    bloc.getAllFood().then((value) => listFood.addAll(value));
    bloc.getAllCategories();
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
                Navigator.of(context).pushAndRemoveUntil(
                    PushScreenSwitchLeft(
                      enterPage: HomeScreen(),
                    ),
                    (Route<dynamic> route) => false);
              },
              child: Icon(
                Icons.arrow_back,
                size: 18,
              )),
          title: Text(
            "${Constant.titleApp}",
            style: TextStyle(fontSize: 15),
          ),
          backgroundColor: ColorCustom.colorTheem,
          flexibleSpace: gradientCustom(),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PushScreenSwitchRight(
                          enterPage: DetailOrderScreen(
                        bookingModel: widget.bookingModel,
                        tablesModel: widget.tablesModel,
                      )));
                },
                child: Icon(
                  Icons.article,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        body: Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height,
                  margin: EdgeInsets.only(top: Adaptive.h(10)),
                  child: StreamBuilder(
                      stream: bloc.streamListCategory,
                      builder: (context, snapshot) {
                        List<CategoryModel> listData = [];
                        if (snapshot.hasData) {
                          listData = snapshot.data;
                          return Column(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: size.width / 25,
                                    right: size.width / 25,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: Adaptive.h(6),
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(top: Adaptive.h(1)),
                                        child: StreamBuilder(
                                            stream: bloc.sChoiceMenu,
                                            builder: (context, snapshot) {
                                              int indexActive = snapshot.hasData ? snapshot.data : 0;
                                              return ListView.builder(
                                                itemCount: listData.length,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  CategoryModel dataModel = listData[index];
                                                  return ItemMenuOrder(
                                                    dataModel: dataModel,
                                                    index: index,
                                                    listData: listData,
                                                    hasActive: indexActive == index,
                                                    onClick: () {
                                                      bloc.isCheckTab(index);
                                                      bloc.isCheckIndexTap(index);
                                                      bloc.getFoodId(id: dataModel.id);
                                                    },
                                                  );
                                                },
                                              );
                                            }),
                                      ),
                                      SizedBox(
                                        height: Adaptive.h(2),
                                      ),
                                      ItemLine(),
                                      SizedBox(
                                        height: Adaptive.h(2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: StreamBuilder(
                                    stream: bloc.sChoiceIndex,
                                    builder: (context, snapshot) {
                                      bloc.indexSelect = snapshot.hasData ? snapshot.data : 0;
                                      return StreamBuilder(
                                          stream: bloc.sViewTabBar,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<List<FoodModel>> list = snapshot.data ?? [];
                                              return IndexedStack(
                                                index: bloc.indexSelect,
                                                children: List.generate(listData.length, (index) {
                                                  return FoodScreen(
                                                    dataModel: listData[index],
                                                    listData: list[index],
                                                    nameBan: widget.nameBan,
                                                    blocOrder: bloc,
                                                    onClick: () {
                                                      // bottomSheetOrderFood(context: context, size: size, dataModel: list[index]);
                                                    },
                                                  );
                                                }).toList(),
                                              );
                                            } else {
                                              return LodingCustom();
                                            }
                                          });
                                    }),
                              ),
                              Expanded(
                                flex: 0,
                                child: SafeArea(
                                  child: StreamBuilder(
                                      stream: bloc.streamStatus,
                                      builder: (context, snapshot) {
                                        bool status = snapshot.hasData ? snapshot.data : false;
                                        return status == false
                                            ? SizedBox()
                                            : InkWell(
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    PushScreenSwitchRight(
                                                      enterPage: CreateOrderScreen(
                                                        listData: bloc.listDataOrder,
                                                        bookingModel: widget.bookingModel,
                                                        orderFoodBloc: bloc,
                                                      ),
                                                    ),
                                                  ).then((value) {
                                                    bloc.listDataOrder.clear();
                                                    // bloc.setStatus(status: false);
                                                  });
                                                },
                                                child: Container(
                                                  width: size.width,
                                                  color: ColorCustom.WHITE,
                                                  padding: EdgeInsets.only(
                                                    left: Adaptive.sp(10),
                                                    right: Adaptive.sp(10),
                                                    top: Adaptive.w(5),
                                                    bottom: Adaptive.sp(20),
                                                  ),
                                                  child: Container(
                                                    padding: EdgeInsets.all(Adaptive.h(2)),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10), color: ColorCustom.colorStatus),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Giỏ đồ ăn",
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 13,
                                                                color: ColorCustom.WHITE,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Adaptive.w(3),
                                                            ),
                                                            Container(
                                                              width: Adaptive.w(1),
                                                              height: Adaptive.w(1),
                                                              decoration: BoxDecoration(
                                                                  color: ColorCustom.WHITE, borderRadius: BorderRadius.circular(50)),
                                                            ),
                                                            SizedBox(
                                                              width: Adaptive.w(3),
                                                            ),
                                                            StreamBuilder(
                                                                stream: bloc.streamNumberFood,
                                                                builder: (context, snapshot) {
                                                                  int numBerFood = snapshot.hasData ? snapshot.data : 0;
                                                                  return Text(
                                                                    "$numBerFood món",
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 13,
                                                                      color: ColorCustom.WHITE,
                                                                    ),
                                                                  );
                                                                }),
                                                          ],
                                                        ),
                                                        StreamBuilder(
                                                            stream: bloc.streamPrice,
                                                            builder: (context, snapshot) {
                                                              double pr = snapshot.hasData ? snapshot.data : 0;
                                                              lowPrice.updateValue(pr);
                                                              String price = lowPrice.text.substring(0, lowPrice.text.length - 3);
                                                              return Text(
                                                                "$price đ",
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 13,
                                                                  color: ColorCustom.WHITE,
                                                                ),
                                                              );
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                      }),
                                ),
                              )
                            ],
                          );
                        } else {
                          return LodingCustom();
                        }
                      }),
                ),
                Container(
                  child: StreamBuilder(
                      stream: bloc.streamStatusAnimated,
                      builder: (context, snapshot) {
                        bool status = snapshot.hasData ? snapshot.data : false;
                        return Column(
                          children: [
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: size.width / 25,
                                  right: size.width / 25,
                                  top: Adaptive.sp(20),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: TextFieldCustom(
                                        controller: bloc.searchController,
                                        hintText: "Tìm kiếm...",
                                        onChanged: (value) {
                                          if (value != null && value != "") {
                                            bloc.statusView(true);
                                            bloc.getListSearch(listFood, value);
                                          } else {
                                            bloc.statusView(false);
                                            bloc.getListSearch(listFood, null);
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ButtonCustom(
                                        title: Constant.search,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            status == true
                                ? Expanded(
                                    flex: 4,
                                    child: StreamBuilder(
                                        stream: bloc.streamListSearch,
                                        builder: (context, snapshot) {
                                          List<FoodModel> lstFood = [];
                                          lstFood = snapshot.hasData ? snapshot.data : listFood;
                                          return Container(
                                            color: ColorCustom.WHITE,
                                            child: AnimatedContainer(
                                              width: size.width,
                                              // height: status ? size.height : 0,
                                              margin: EdgeInsets.only(
                                                left: size.width / 25,
                                                right: size.width / 25,
                                                top: size.width / 20,
                                              ),
                                              duration: const Duration(milliseconds: 500),
                                              curve: Curves.fastOutSlowIn,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Danh sách tìm kiếm:",
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                  ListView.builder(
                                                      itemCount: lstFood.length,
                                                      shrinkWrap: true,
                                                      itemBuilder: (context, index) {
                                                        FoodModel dataModel = lstFood[index];
                                                        return ItemRow(
                                                          name: dataModel.name,
                                                          price: dataModel.price.toString(),
                                                          index: index + 1,
                                                          maxIndex: listFood.length,
                                                          style: "1",
                                                          onTap: () {
                                                            bloc.listDataOrder.add(
                                                              FoodModel(
                                                                  imageUrl: dataModel.imageUrl,
                                                                  id: dataModel.id,
                                                                  name: dataModel.name,
                                                                  price: dataModel.price,
                                                                  quantity: bloc.number),
                                                            );
                                                            bloc.setNumberFood(listDataOrder: bloc.listDataOrder);
                                                            bloc.setPrice();
                                                            bloc.setStatus(status: bloc.listDataOrder.length > 0 ? true : false);
                                                            bloc.number = 0;
                                                            bloc.statusView(false);
                                                            bloc.searchController.clear();
                                                          },
                                                        );
                                                      }),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                : SizedBox()
                          ],
                        );
                      }),
                ),
              ],
            )));
  }
}
