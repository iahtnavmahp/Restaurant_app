import 'package:bezier_chart/bezier_chart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:restauant_app/src/model/all_order_model.dart';
import 'package:restauant_app/src/model/statistics_of_the_year_model.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/item_booking.dart';

import 'list_information_bloc.dart';

class ListInformationScreen extends StatefulWidget {
  @override
  _ListInformationScreenState createState() => _ListInformationScreenState();
}

class _ListInformationScreenState extends State<ListInformationScreen> {
  final CarouselController _controller = CarouselController();
  ListInformationBloc bloc = ListInformationBloc();
  final lowPrice = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  @override
  void initState() {
    super.initState();
    bloc.getAllOrders();
    bloc.getAnalysisOrderByDay();
    bloc.getAnalysisOrder();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("dd-MM-yyyy").format(now);

    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      child: Column(
        children: [
          StreamBuilder(
          stream: bloc.streamAnalysisOrder,
          builder: (context, snapshot) {
            List<DataPoint> listDataPoint = [].cast<DataPoint>();
            if (snapshot.hasData) {
              listDataPoint = snapshot.data;
              return listDataPoint.length > 0 ? Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child:  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(Adaptive.sp(10)),
                        child: Card(
                          elevation: 12,
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(right: Adaptive.sp(20)),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    ColorCustom.colorTheem3,
                                    ColorCustom.colorTheem1,
                                    ColorCustom.colorTheem2,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                            child: BezierChart(
                              bezierChartScale: BezierChartScale.CUSTOM,
                              xAxisCustomValues: bloc.listChart,
                              // footerValueBuilder: (double value) {
                              //   // return "${intOrDouble(value)}\ndays";
                              //   return;
                              // },
                              series: [
                                BezierLine(
                                  label: "Tháng",
                                  data: listDataPoint,
                                ),
                              ],
                              config: BezierChartConfig(
                                footerHeight: 50,
                                verticalIndicatorStrokeWidth: 3.0,
                                showVerticalIndicator: true,
                                verticalIndicatorFixedPosition: true,
                                snap: false,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(Adaptive.sp(20)),
                        alignment: Alignment.topRight,
                        child: Text(
                          "Thống kê theo tháng",
                          style: TextStyle(color: ColorCustom.WHITE, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ),
              ): SizedBox();
            }else{
              return Container();
            }
          }
          ),
          StreamBuilder(
              stream: bloc.streamAnalysisDay,
              builder: (context, snapshot) {
                List<StatisticsOfTheYearModel> listDay = [];
                if (snapshot.hasData) {
                  listDay = snapshot.data;
                  return listDay.length > 0 ? CarouselSlider(
                    items: List.generate(listDay.length > 7 ? 7 : listDay.length, (index) {
                      StatisticsOfTheYearModel dataModel = listDay[index];
                      lowPrice.updateValue(dataModel.totalPrice);
                      String price = lowPrice.text.substring(0, lowPrice.text.length - 3);
                      return Container(
                        width: size.width,
                        height: Adaptive.h(2),
                        margin: EdgeInsets.only(top: Adaptive.sp(20)),
                        padding: EdgeInsets.all(Adaptive.sp(20)),
                        decoration: BoxDecoration(
                          color: (index + 1) % 2 == 0 ? ColorCustom.colorTheem1 : ColorCustom.colorTheem2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Thống kê theo ngày",
                                style: TextStyle(fontSize: 13, color: ColorCustom.WHITE, fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "$price VND",
                                style: TextStyle(fontSize: 16, color: ColorCustom.WHITE, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              // Text(
                              //   "5.000.000" + " - " + "2.000.000" + " = 3.000.000 vnd",
                              //   style: TextStyle(fontSize: 13, color: ColorCustom.WHITE, fontWeight: FontWeight.bold),
                              // ),
                              // SizedBox(
                              //   height: 7,
                              // ),
                              Text(
                                "${dataModel.day}-${dataModel.month}-${dataModel.year}",
                                style: TextStyle(fontSize: 13, color: ColorCustom.WHITE, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    carouselController: _controller,
                    options: CarouselOptions(
                      // autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 3.5,
                        onPageChanged: (index, reason) {
                          setState(() {
                            // _current = index;
                          });
                        }),
                  ) : SizedBox();
                } else {
                  return Container();
                }
              }),
          Expanded(
            flex: 3,
            child: StreamBuilder(
                stream: bloc.streamGetAllOrder,
                builder: (context, snapshot) {
                  List<AllOrderModel> listAllOrderModel = [];
                  List<AllOrderModel> listAllOrder = [];

                  if (snapshot.hasData) {
                    listAllOrderModel = snapshot.data;
                    listAllOrder = listAllOrderModel.reversed.toList();
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: Adaptive.sp(25)),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: size.width / 9,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "STT",
                                          maxLines: 3,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        )),
                                    Container(
                                      width: size.width / 3,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Tên khách hàng",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: size.width / 3,
                                      alignment: Alignment.center,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Text(
                                          "Thời gian hoá đơn",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            color: ColorCustom.BLUE,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: Adaptive.sp(12)),
                                width: size.width,
                                height: 1,
                                color: ColorCustom.GREY,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: ListView.builder(
                                itemCount: listAllOrder.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  AllOrderModel data = listAllOrder[index];
                                  DateTime createdDate = DateTime.fromMillisecondsSinceEpoch(data.orderTime);
                                  var outputFormat = DateFormat('dd/MM/yyyy');
                                  String date = outputFormat.format(createdDate);
                                  return ItemBooking(
                                    stt: index + 1,
                                    nameCustomer: data.customer.name,
                                    timeOrder: date,
                                    maxIndex: 10,
                                    onTap: () {
                                      dialogShow(dataModel: data);
                                    },
                                  );
                                }),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
          )
        ],
      ),
    );
  }


  dialogShow({AllOrderModel dataModel}) {
    // var dataTime = DateTime.parse(dataModel.orderTime);
    // String dateCheckIn = DateFormat('kk:mm | dd-MM-yyyy').format(dataTime);
    lowPrice.updateValue(dataModel.totalPrice);
    String price = lowPrice.text.substring(0, lowPrice.text.length - 3);

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dataModel.orderTime);
    var outputFormat = DateFormat('dd/MM/yyyy');
    String date = outputFormat.format(dateTime);

    showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        content: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _itemDialog(title: "Tên khách hàng", data: dataModel.customer.name),
              _itemDialog(title: "Số điện thoại", data: dataModel.customer.phone),
              _itemDialog(title: "Thời gian đặt", data: date),
              // _itemDialog(title: "Tổng số món ăn", data: dataModel.foods.length.toString()),
              _itemDialog(title: "Tổng tiền:", data: price + " đ"),
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
}

