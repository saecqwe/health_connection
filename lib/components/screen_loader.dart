import 'package:flutter/material.dart';
import 'package:health_connection/components/globle_variables.dart';
import 'package:health_connection/components/ui_helper.dart';

class Loader {
  static bool? _isOpen;
  static void start() {
    _isOpen = true;
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
            child: Container(
                height: 50,
                width: 1,
                margin: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    UIHelper.horizontalSpaceLarge(),
                    const Text(
                      'Loading',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                )));
      },
    ).then((_) => _isOpen = false);
  }

  static void stop() {
    if (_isOpen == true) {
      Navigator.pop(navigatorKey.currentContext!);
    }
  }
}
