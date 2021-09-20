import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';

class ItemRow extends StatelessWidget {
  ItemRow({this.name, this.price, this.maxIndex, this.index, this.onTap, this.style});

  final String name;
  final String price;
  final String style;
  final int index;
  final int maxIndex;
  final Callback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: Adaptive.sp(10)),
      alignment: Alignment.center,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: Adaptive.sp(10)),
              width: size.width,
              height: 1,
              color: index >=1 ? ColorCustom.WHITE : ColorCustom.GREY,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                style == "1" ? SizedBox() : Container(
                    width: size.width / 9,
                    margin: EdgeInsets.only(left: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      index.toString(),
                      maxLines: 3,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                      ),
                    )),
                Expanded(
                  child: Container(
                      width: size.width / 4,
                      // margin: EdgeInsets.only(left: 5),
                      child: Text(
                        name ?? "",
                        maxLines: 3,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                        ),
                      )),
                ),
                Container(
                  width: size.width / 2,
                  alignment: Alignment.centerRight,
                  child: Text(
                    price.toString() + " đ",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ),
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
      ),
    );
  }
}
