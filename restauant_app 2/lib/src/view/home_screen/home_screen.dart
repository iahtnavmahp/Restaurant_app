import 'package:intl/intl.dart';
import 'package:restauant_app/src/model/booking_model.dart';
import 'package:restauant_app/src/model/tables_model.dart';
import 'package:restauant_app/src/utils/animation/push_screen_switch_let.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/dialog_custom/dialog_loading.dart';
import 'package:restauant_app/src/utils/component/item_tables.dart';
import 'package:restauant_app/src/utils/component/loading_custom.dart';
import 'package:restauant_app/src/view/home_screen/home_bloc.dart';
import 'package:restauant_app/src/view/order_food_screen/detail_order_screen/detail_order_screen.dart';
import 'package:restauant_app/src/view/order_food_screen/order_food_screen.dart';
import 'package:restauant_app/src/view/splash_screen/splash_bloc.dart';

import 'booking_screen/create_booking_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc bloc = HomeBloc();
  SplashBloc splashBloc = SplashBloc();

  @override
  void initState() {
    super.initState();
    bloc.getListBA();
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
      backgroundColor: ColorCustom.WHITE,
      appBar: AppBar(
        leading: SizedBox(),
        title: Text(
          "${Constant.titleApp}",
          style: TextStyle(fontSize: 15),
        ),
        backgroundColor: ColorCustom.colorTheem,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                splashBloc.logOut(context: context);
              },
              child: Image.asset(
                "assets/icon/ic_logout.png",
                color: ColorCustom.WHITE,
                width: 17,
              ),
            ),
          ),
        ],
        flexibleSpace: gradientCustom(),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: size.width / 20),
                child: Text(
                  Constant.titleHome,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              SizedBox(
                height: size.width / 20,
              ),
              Expanded(
                flex: 5,
                child: StreamBuilder(
                    stream: bloc.streamListHome,
                    builder: (context, snapshot) {
                      List<TablesModel> listData = [];

                      if (snapshot.hasData) {
                        listData = snapshot.data;
                        return SingleChildScrollView(
                          child: Container(
                            width: size.width,
                            // height: size.height,
                            alignment: Alignment.center,
                            child: listData.length > 0
                                ? Wrap(
                                    spacing: Adaptive.w(3),
                                    runSpacing: Adaptive.w(3),
                                    children: listData.map((value) {
                                      return ItemTables(
                                        dataModel: value,
                                        onTap: () async {
                                          if (value.status != true) {
                                            await Navigator.push(
                                                context,
                                                PushScreenSwitchRight(
                                                    enterPage: CreateBookingScreen(
                                                  dataModel: value,
                                                )));
                                            bloc.getListBA();
                                          } else {
                                            DialogLoading.showLoading(context);
                                            bloc.getBooking(context: context, id: value.id).then((dataBooking) {
                                              DialogLoading.hiddenLoading(context);
                                              dialogAddCategory(dataModel: dataBooking, tablesModel: value);
                                            });
                                          }
                                        },
                                      );
                                    }).toList(),
                                  )
                                : Text("Không có bàn ăn"),
                          ),
                        );
                      } else {
                        return LodingCustom();
                      }
                    }),
              ),
              Container(
                color: ColorCustom.WHITE,
                margin: EdgeInsets.only(top: size.width / 20, bottom: size.width / 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Constant.numberOfTablesAvailable,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                    ),
                    StreamBuilder(
                        stream: bloc.streamNumber,
                        builder: (context, snapshot) {
                          int number = snapshot.hasData ? snapshot.data : 0;
                          return Text(
                            "$number bàn",
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: ColorCustom.RED),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dialogAddCategory({BookingModel dataModel, TablesModel tablesModel}) {
    var dataTime = DateTime.parse(dataModel.checkin);
    String dateCheckIn = DateFormat('kk:mm | dd-MM-yyyy').format(dataTime);

    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _itemDialog(title: "Tên khách hàng", data: dataModel.customer.name),
              _itemDialog(title: "Số điện thoại", data: dataModel.customer.phone),
              _itemDialog(title: "Số người", data: dataModel.numberInParty.toString()),
              _itemDialog(title: "Thời gian đặt", data: dateCheckIn),
            ],
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PushScreenSwitchRight(
                      enterPage: DetailOrderScreen(
                    bookingModel: dataModel,
                    tablesModel: tablesModel,
                  )));
              // dialog and
              // returns nothing
            },
            child: Container(
              width: Adaptive.w(20),
              height: Adaptive.w(7),
              alignment: Alignment.center,
              child: new Text(
                'Hoá đơn',
                textAlign: TextAlign.center,
                style: TextStyle(color: ColorCustom.RED, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          InkWell(
            onTap: () {


                Navigator.push(
                    context,
                    PushScreenSwitchRight(
                        enterPage: OrderFoodScreen(
                          nameBan: dataModel.customer.name,
                          bookingModel: dataModel,
                          tablesModel: tablesModel,
                        )));


            },
            child: Container(
              width: Adaptive.w(20),
              height: Adaptive.w(7),
              alignment: Alignment.center,
              child: new Text(
                "Gọi món",
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
