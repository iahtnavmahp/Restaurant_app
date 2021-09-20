import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:restauant_app/src/model/category_model.dart';
import 'package:restauant_app/src/model/food_model.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/button_custom.dart';
import 'package:restauant_app/src/utils/component/item_food.dart';
import 'package:restauant_app/src/view/order_food_screen/food_screen/food_bloc.dart';
import 'package:restauant_app/src/view/order_food_screen/order_food_bloc.dart';

class FoodScreen extends StatefulWidget {
  FoodScreen({this.dataModel, this.nameBan, this.listData, this.onClick, this.blocOrder});

  final CategoryModel dataModel;
  OrderFoodBloc blocOrder;
  final List<FoodModel> listData;
  final String nameBan;
  final VoidCallback onClick;

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  FoodBloc bloc = FoodBloc();
  final lowPrice = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          left: size.width / 30,
          right: size.width / 30,
        ),
        child: widget.listData.length > 0
            ? Container(
                width: size.width,
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  child: Wrap(
                    runSpacing: Adaptive.w(1),
                    children: widget.listData.map((value) {
                      return ItemFood(
                        dataModel: value,
                        onClick: () {
                          if (value.status == true){
                            bottomSheetOrderFood(context: context, size: size, dataModel: value);
                          }else{
                            bloc.showToast("Món ăn đã dừng bán");
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
              )
            : Container(
                width: size.width,
                height: size.height,
                alignment: Alignment.center,
                child: Text(
                  "Không có món ăn nào",
                  style: TextStyle(fontSize: 13, color: ColorCustom.GREY),
                ),
              ),
      ),
    );
  }

  void bottomSheetOrderFood({BuildContext context, Size size, FoodModel dataModel}) {
    lowPrice.updateValue(dataModel.price);
    String price = lowPrice.text.substring(0, lowPrice.text.length - 3);
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Container(
            height: Adaptive.h(35),
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
              left: Adaptive.w(5),
              right: Adaptive.w(5),
              top: Adaptive.w(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    dataModel.imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              dataModel.imageUrl,
                              width: Adaptive.w(20),
                              height: Adaptive.w(20),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            width: Adaptive.w(20),
                            height: Adaptive.w(20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorCustom.GREY.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "No Image",
                              style: TextStyle(color: ColorCustom.GREY),
                            ),
                          ),
                    SizedBox(
                      width: Adaptive.w(4),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Adaptive.w(55),
                          child: Text(
                            dataModel.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: ColorCustom.BLACK,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Adaptive.w(2),
                        ),
                        Text(
                          "$price đ",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: ColorCustom.GREY,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // SizedBox(height: size.width/15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        widget.blocOrder.setNumber(num: "0");
                      },
                      child: Container(
                        width: Adaptive.w(10),
                        height: Adaptive.w(10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: Adaptive.w(4.5),
                              height: Adaptive.w(1.2),
                              decoration: BoxDecoration(color: ColorCustom.GREY),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Adaptive.w(6),
                    ),
                    StreamBuilder(
                        stream: widget.blocOrder.streamNumber,
                        builder: (context, snapshot) {
                          bloc.number = snapshot.hasData ? snapshot.data : 0;
                          return Container(
                            width: Adaptive.w(10),
                            height: Adaptive.w(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: ColorCustom.GREY), borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              "${bloc.number}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: ColorCustom.BLACK,
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      width: Adaptive.w(5),
                    ),
                    InkWell(
                      onTap: () {
                        widget.blocOrder.setNumber(num: "1");
                      },
                      child: Container(
                        width: Adaptive.w(10),
                        height: Adaptive.w(10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: Adaptive.w(4.5),
                              height: Adaptive.w(1.2),
                              decoration: BoxDecoration(color: ColorCustom.GREY),
                            ),
                            Container(
                              width: Adaptive.w(1.2),
                              height: Adaptive.w(4.5),
                              decoration: BoxDecoration(color: ColorCustom.GREY),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                ButtonCustom(
                  margin: EdgeInsets.only(bottom: size.height / 40),
                  title: Constant.confirm,
                  onClick: () async {
                    if (bloc.number > 0) {
                      widget.blocOrder.listDataOrder.add(
                        FoodModel(
                          imageUrl: dataModel.imageUrl,
                          id: dataModel.id,
                          name: dataModel.name,
                          price: dataModel.price,
                          quantity: bloc.number,
                        ),
                      );
                    }
                    widget.blocOrder.setNumberFood(listDataOrder: widget.blocOrder.listDataOrder);
                    widget.blocOrder.setPrice();
                    widget.blocOrder.setStatus(status: widget.blocOrder.listDataOrder.length > 0 ? true : false);
                    widget.blocOrder.number = 0;
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
