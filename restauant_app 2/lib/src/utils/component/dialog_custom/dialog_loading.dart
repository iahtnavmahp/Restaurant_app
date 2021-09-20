import 'package:flutter/material.dart';

class DialogLoading {
  static showLoading(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () {
          return;
        },
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  static hiddenLoading(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    return Navigator.pop(context);
  }
}
