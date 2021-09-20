import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

ThemeData themeData = Get.theme;
AppBarTheme appBarTheme = Get.theme.appBarTheme;

double get sWidth => Get.width;

double get sHeight => Get.height;

double sWValue(double value) => Get.width * value.toDouble();

double sHValue(double value) => Get.height * value.toDouble();

class ScreenUtil {
  ScreenUtil._({
    this.width = 1080,
    this.height = 1920,
    this.allowFontScaling = false,
    //đơn vị tính theo dp
    this.maxPhysicalSize = 480,
  });

  static void init({
    double width = 1080,
    double height = 1920,
    bool allowFontScaling = false,
    double maxPhysicalSize = 480,
  }) {
    _instance = ScreenUtil._(
      width: width,
      height: height,
      allowFontScaling: allowFontScaling,
      maxPhysicalSize: maxPhysicalSize,
    );
  }

  static ScreenUtil get instance => _instance;
  static ScreenUtil _instance;

  double width;
  double height;
  bool allowFontScaling;
  double maxPhysicalSize;

  double get _screenWidth => min(window.physicalSize.width, maxPhysicalSize);

  double get _screenHeight => window.physicalSize.height;

  double get _pixelRatio => window.devicePixelRatio;

  double get _statusBarHeight => EdgeInsets.fromWindowPadding(window.padding, window.devicePixelRatio).top;

  double get _bottomBarHeight => EdgeInsets.fromWindowPadding(window.padding, window.devicePixelRatio).bottom;

  double get _textScaleFactor => window.textScaleFactor;

  static MediaQueryData get mediaQueryData => MediaQueryData.fromWindow(window);

  double get textScaleFactory => _textScaleFactor;

  double get pixelRatio => _pixelRatio;

  double get screenWidthDp => _screenWidth;

  double get screenHeightDp => _screenHeight;

  double get screenWidth => _screenWidth * _pixelRatio;

  double get screenHeight => _screenHeight * _pixelRatio;

  double get statusBarHeight => _statusBarHeight;

  double get bottomBarHeight => _bottomBarHeight;

  double get scaleWidth => _screenWidth / instance.width;

  double get scaleHeight => _screenHeight / instance.height;

  double setWidth(double width) => width * scaleWidth;

  double setHeight(double height) => height * scaleHeight;

  double setSp(double fontSize) => allowFontScaling ? setWidth(fontSize) : setWidth(fontSize) / _textScaleFactor;
}
