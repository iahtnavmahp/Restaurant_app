import 'package:restauant_app/src/utils/base/base_import.dart';

class ButtonCustom extends StatefulWidget {
  ButtonCustom({this.title: "Title button", this.margin, this.onClick, this.color});

  final String title;
  final EdgeInsets margin;
  final Color color;
  final VoidCallback onClick;

  @override
  _ButtonCustomState createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: widget.margin,
      child: InkWell(
        onTap: widget.onClick,
        child: Container(
          alignment: Alignment.center,
          height: Adaptive.h(6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  ColorCustom.colorTheem1,
                  ColorCustom.colorTheem2,
                ],
              )),
          child: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: ColorCustom.WHITE),
          ),
        ),
      ),
    );
  }
}
