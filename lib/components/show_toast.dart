import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_connection/themes/colors.dart';

showToast(
  String msg,
) {
  Fluttertoast.showToast(
      msg: msg, webPosition: "center", gravity: ToastGravity.CENTER);
}

somethingWentWrong() {
  Fluttertoast.showToast(
      msg: "Somehting went wrong",
      webPosition: "center",
      gravity: ToastGravity.CENTER);
}

showScafMsg(String msg, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: AppColors.blackColor,
  ));
}
