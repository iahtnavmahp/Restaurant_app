import 'package:restauant_app/src/model/tables_model.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';

class ItemTables extends StatelessWidget {
  ItemTables({this.dataModel, this.onTap});

  final TablesModel dataModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Adaptive.w(43),
        height: Adaptive.h(15),
        padding: EdgeInsets.all(Adaptive.sp(10)),
        alignment: Alignment.center,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                dataModel.status == true  ? ColorCustom.RED : ColorCustom.colorTheem1,
                dataModel.status == true  ? ColorCustom.RED : ColorCustom.colorTheem2,
              ],
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "Tên bàn: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13, color: dataModel.status == true ? ColorCustom.WHITE : ColorCustom.WHITE),
                ),
                Text(
                  "${dataModel.tableNumber}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: dataModel.status == true ? ColorCustom.WHITE :
                  ColorCustom.WHITE),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: Adaptive.h(0.5), bottom: Adaptive.h(0.5)),
              child: Row(
                children: [
                  Text(
                    "Khu vực: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: dataModel.status == true ? ColorCustom.WHITE :
                    ColorCustom.WHITE),
                  ),
                  Text(
                    "${dataModel.location}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: dataModel.status == true ? ColorCustom.WHITE :
                    ColorCustom.WHITE),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "Vị trí: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: dataModel.status == true ? ColorCustom.WHITE :
                  ColorCustom.WHITE),
                ),
                Text(
                  "${dataModel.posivition}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: dataModel.status == true ? ColorCustom.WHITE :
                  ColorCustom.WHITE),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Tối đa số người: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: dataModel.status == true ? ColorCustom.WHITE :
                  ColorCustom.WHITE),
                ),
                Text(
                  "${dataModel.seating}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: dataModel.status == true ? ColorCustom.WHITE :
                  ColorCustom.WHITE),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
