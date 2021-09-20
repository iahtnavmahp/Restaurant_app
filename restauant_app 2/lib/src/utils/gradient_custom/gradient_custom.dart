import 'package:restauant_app/src/utils/base/base_import.dart';

Widget gradientCustom(){
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          ColorCustom.colorTheem1,
          ColorCustom.colorTheem2,
        ],
      ),
    ),
  );
}