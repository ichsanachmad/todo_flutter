import 'package:flutter/material.dart';

class WidgetLoadingDialog {
  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
              child: SimpleDialog(
                key: key,
                backgroundColor: Colors.white,
                children: [Center(child: CircularProgressIndicator())],
              ),
              onWillPop: () async => false);
        });
  }
}
