import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';

class LodingCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      child: SpinKitWave(
        color: ColorCustom.colorTheem,
        size: 30.0,
      ),
    );
  }
}
