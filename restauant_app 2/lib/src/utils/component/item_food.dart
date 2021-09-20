import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:restauant_app/src/model/food_model.dart';
import 'package:restauant_app/src/utils/base/base_font_text.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';

class ItemFood extends StatefulWidget {
  ItemFood({this.dataModel, this.onClick});

  final FoodModel dataModel;
  final VoidCallback onClick;

  @override
  _ItemFoodState createState() => _ItemFoodState();
}

class _ItemFoodState extends State<ItemFood> {
  final lowPrice = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  @override
  Widget build(BuildContext context) {
    lowPrice.updateValue(widget.dataModel.price);
    String price = lowPrice.text.substring(0, lowPrice.text.length - 3);
    return InkWell(
      onTap: widget.onClick,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            Container(
              width: Adaptive.w(28.5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    child: widget.dataModel.imageUrl != null ? Image.network(
                      widget.dataModel.imageUrl,
                      width: Adaptive.w(30),
                      height: Adaptive.w(30),
                      fit: BoxFit.cover,
                    ) : Container(
                      width: Adaptive.w(30),
                      height: Adaptive.w(30),
                      alignment: Alignment.center,
                      child: Text("No Image",style: TextStyle(
                        color: ColorCustom.GREY
                      ),),
                    ),
                  ),
                  Container(
                    width: Adaptive.w(30),
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: sWValue(.01),left: sWValue(.01),right: sWValue(.01)),
                    child: Text(
                      widget.dataModel.name,

                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: ColorCustom.BLACK,
                      ),
                    ),
                  ),
                  Container(
                    width: Adaptive.w(30),
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 5,left: sWValue(.01),right: sWValue(.01),bottom: sWValue(.03)),
                    child: Text(
                      "$price đ",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        fontWeight: FontWeight.bold,

                        fontSize: 12,
                        color: ColorCustom.GREY,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: Adaptive.w(28.5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.dataModel.status == true ? null : ColorCustom.BLACK.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    child: Container(
                      width: Adaptive.w(30),
                      height: Adaptive.w(30),
                      alignment: Alignment.center,
                    ),
                  ),
                  Container(
                    width: Adaptive.w(30),
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: sWValue(.01),left: sWValue(.01),right: sWValue(.01)),
                    child: Text(
                      "",

                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: ColorCustom.BLACK,
                      ),
                    ),
                  ),
                  Container(
                    width: Adaptive.w(30),
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 5,left: sWValue(.01),right: sWValue(.01),bottom: sWValue(.03)),
                    child: Text(
                      "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        fontWeight: FontWeight.bold,

                        fontSize: 12,
                        color: ColorCustom.GREY,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
