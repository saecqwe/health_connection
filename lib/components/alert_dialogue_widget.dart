import 'package:flutter/material.dart';

enum AlertAction { canel, ok }

Future<AlertAction?> asyncConfirmDialog(
    BuildContext context, String message) async {
  return showDialog<AlertAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Alert!',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent),
        ),
        content: Text(
          message.toString(),
          style: const TextStyle(fontSize: 15),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(AlertAction.canel);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(AlertAction.ok);
            },
            child: const Text(
              "Yes",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
