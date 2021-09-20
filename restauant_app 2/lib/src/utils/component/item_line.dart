import 'package:restauant_app/src/utils/base/base_import.dart';

class ItemLine extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: 1,
      color: ColorCustom.GREY,
    );
  }
}
