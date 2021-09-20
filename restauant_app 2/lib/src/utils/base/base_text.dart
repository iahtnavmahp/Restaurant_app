import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:restauant_app/src/utils/int_custome.dart';

class BaseTextCustom {

  Widget getText({
    @required String text,
    TextStyle style,
    bool softWrap: true,
    TextOverflow overflow: TextOverflow.fade,
    int maxLines,
    TextAlign textAlign: TextAlign.start,
    double textScaleFactor: 1.0,
  }) =>
      FittedBox(
        child: Text(
          text,
          style: style != null
              ? style
              : TextStyle(
            fontSize: 14,
            fontFamily: 'Roboto',
          ),
          softWrap: softWrap,
          overflow: overflow,
          maxLines: maxLines,
          textAlign: textAlign,
          textScaleFactor: textScaleFactor,
        ),
      );


  Widget setText({
    String text: "",
    TextStyle style,
    bool softWrap: true,
    TextOverflow overflow: TextOverflow.visible,
    int maxLines,
    TextAlign textAlign: TextAlign.start,
    double textScaleFactor: 1.0,
    double minFontSize: 10.0,
    double maxFontSize: 14.0,
  }) =>
      AutoSizeText(
        text,
        minFontSize: minFontSize,
        maxFontSize: maxFontSize,
        style: style != null
            ? style
            : TextStyle(
          fontFamily: "Roboto",
          fontSize: IntCustom.FONT_TEXT_13,
        ),
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        textAlign: textAlign,
        textScaleFactor: textScaleFactor,
      );
}
