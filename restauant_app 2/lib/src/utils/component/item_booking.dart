import 'package:restauant_app/src/model/all_order_model.dart';
import 'package:restauant_app/src/model/booking_model.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';

class ItemBooking extends StatefulWidget {
  ItemBooking({this.dataMode, this.stt,this.maxIndex,this.nameCustomer,this.timeOrder,this.onTap});

  final int stt;
  final int maxIndex;
  final BookingModel dataMode;
  final String nameCustomer;
  final String timeOrder;
  final VoidCallback onTap;


  @override
  _ItemBookingState createState() => _ItemBookingState();
}

class _ItemBookingState extends State<ItemBooking> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.only(top: Adaptive.sp(12)),
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
                        widget.stt.toString(),
                        maxLines: 3,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                        ),
                      )),
                  Container(
                    width: size.width / 3,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.nameCustomer ?? "null",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 3,
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        widget.timeOrder,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                          color: ColorCustom.BLUE,
                          fontSize: 13,
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
              color: widget.stt -1  == widget.maxIndex ? ColorCustom.WHITE :ColorCustom.GREY,
            )
          ],
        ),
      ),
    );
  }
}
