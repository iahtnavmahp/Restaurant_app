import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restauant_app/src/model/booking_model.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/item_booking.dart';
import 'package:restauant_app/src/utils/component/loading_custom.dart';
import 'package:restauant_app/src/view/manage_screen/get_booking_screen/get_booking_bloc.dart';

class GetBookingScreen extends StatefulWidget {
  @override
  _GetBookingScreenState createState() => _GetBookingScreenState();
}

class _GetBookingScreenState extends State<GetBookingScreen> {
  GetBookingBloc bloc = GetBookingBloc();

  @override
  void initState() {
    super.initState();
    bloc.getAllBooking();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      margin: EdgeInsets.only(
        left: size.width / 25,
        right: size.width / 25,
        top: Adaptive.h(2),
      ),
      child: Column(
        children: [
          Container(
            width: size.width,
            padding: EdgeInsets.only(top: Adaptive.sp(15), bottom: Adaptive.sp(15)),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: ColorCustom.GREY)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: size.width / 9,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: Adaptive.sp(7)),
                    child: Text(
                      "STT",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Adaptive.sp(16),
                      ),
                    )),
                Container(
                  width: size.width / 3,
                  alignment: Alignment.center,
                  child: Text(
                    "Tên khách hàng",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Adaptive.sp(
                        16,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size.width / 3,
                  alignment: Alignment.center,
                  child: Text(
                    "Thời gian tạo",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Adaptive.sp(
                        16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: StreamBuilder(
                stream: bloc.streamAllBooking,
                builder: (context, snapshot) {
                  List<BookingModel> listData = [];
                  if (snapshot.hasData) {
                    listData = snapshot.data;
                    return SingleChildScrollView(
                      child: ListView.builder(
                          itemCount: listData.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            BookingModel data = listData[index];
                            return ItemBooking(
                              stt: index + 1,
                              dataMode: data,
                              maxIndex: listData.length,
                            );
                          }),
                    );
                  } else {
                    return LodingCustom();

                  }
                }),
          )
        ],
      ),
    );
  }
}
