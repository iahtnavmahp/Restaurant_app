import 'package:restauant_app/src/model/category_model.dart';
import 'package:restauant_app/src/model/menu_model.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';

class ItemMenuOrder extends StatefulWidget {
  ItemMenuOrder({this.onClick, this.listData, this.index, this.dataModel, this.hasActive});

  final CategoryModel dataModel;
  final List<CategoryModel> listData;
  final int index;
  final VoidCallback onClick;
  final bool hasActive;

  @override
  _ItemMenuOrderState createState() => _ItemMenuOrderState();
}

class _ItemMenuOrderState extends State<ItemMenuOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: widget.index == 0 ? 0 : 7, right: widget.index == widget.listData.length ? 0 : 5),
      child: InkWell(
        onTap: widget.onClick,
        child: Container(
          width: Adaptive.w(27.5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: widget.hasActive ? ColorCustom.colorTheem : ColorCustom.WHITE,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: ColorCustom.colorTheem, width: 1)),
          child: Text( widget.dataModel.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: widget.hasActive ? ColorCustom.WHITE : ColorCustom.colorTheem,
            ),
          ),
        ),
      ),
    );
  }
}
