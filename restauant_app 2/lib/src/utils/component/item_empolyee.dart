import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';

class ItemEmpolyee extends StatelessWidget {

  ItemEmpolyee({this.name,this.phone,this.maxIndex,this.index,this.onTap});

  final String name;
  final String phone;
  final int index;
  final int maxIndex;
  final Callback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: Adaptive.sp(10)),
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: size.width / 4,
                  margin: EdgeInsets.only(left: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    name ?? "",
                    maxLines: 3,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                    ),
                  )),
              Container(
                width: size.width / 4,
                alignment: Alignment.center,
                child: Text(
                  phone ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ),
              Container(
                width: size.width / 4,
                margin: EdgeInsets.only(right: 5),
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: onTap,
                  child: Text(
                    "Thay đổi",
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
          Container(
            margin: EdgeInsets.only(top: Adaptive.sp(10)),
            width: size.width,
            height: 1,
            color: index == maxIndex ? ColorCustom.WHITE : ColorCustom.GREY,
          )
        ],
      ),
    );
  }
}
