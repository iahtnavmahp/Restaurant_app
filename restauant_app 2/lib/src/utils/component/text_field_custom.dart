import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/validate/validate.dart';

class TextFieldCustom extends StatefulWidget {
  TextFieldCustom(
      {this.controller,
      this.hintText,
      this.margin,
      this.obscureText: false,
      this.error,
      this.maxLines: 1,
      this.maxLength: 255,
      this.keyboardType,
      this.enabled: true,
      this.onChanged});

  final TextEditingController controller;
  final String hintText;
  final EdgeInsets margin;
  final bool obscureText;
  final bool enabled;
  final String error;
  final int maxLines;
  final int maxLength;
  final TextInputType keyboardType;
  final Function(String text) onChanged;

  @override
  _TextFieldCustomState createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            height: Adaptive.h(6),
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: size.width / 25, right: size.width / 25),
            decoration:
                BoxDecoration(border: Border.all(color: ColorCustom.BLACK, width: 1), borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TextField(
              controller: widget.controller,
              obscureText: widget.obscureText,
              maxLines: widget.maxLines,
              keyboardType: widget.keyboardType,
              enabled: widget.enabled,
              maxLength: widget.maxLength,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                counterText: '',
                hintText: widget.hintText ?? "Nhập dữ liệu...",
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Validate.isCheckString(widget.error) == true
              ? BaseTextCustom().setText(
                  text: "Error: ${widget.error}",
                  minFontSize: 12,
                  maxFontSize: 13,
                  style: TextStyle(fontSize: 12, color: ColorCustom.RED),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
