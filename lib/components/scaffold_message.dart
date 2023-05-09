import 'package:flutter/material.dart';
import 'package:health_connection/components/globle_variables.dart';

class ScaffoldMessage {
  static showSnackBar({required String msg}) {
    return ScaffoldMessenger.of(navigatorKey.currentContext!)
        .showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
    ));
  }
}
