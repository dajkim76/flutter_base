import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message, {bool isLong = false}) {
  Fluttertoast.showToast(msg: message, toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT);
}

void showAlertDialog(BuildContext context, String title, String message) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(title: Text(title), content: Text(message));
      });
}
