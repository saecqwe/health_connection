import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ConfirmAction { cancel, ok }

Future<ConfirmAction?> asyncConfirmDialog(
    BuildContext context, String message) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: true, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return !Platform.isAndroid
          ? AlertDialog(
              title: const Text(
                'Alert',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              content: Text(
                message.toString(),
                style: const TextStyle(fontSize: 15),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(ConfirmAction.cancel);
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('OK',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  onPressed: () {
                    Navigator.of(context).pop(ConfirmAction.ok);
                  },
                )
              ],
            )
          : CupertinoAlertDialog(
              title: const Text(
                'Alert',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              content: Text(
                message.toString(),
                style: const TextStyle(fontSize: 15),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(color: Color.fromARGB(255, 75, 75, 75)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(ConfirmAction.cancel);
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Color.fromARGB(255, 75, 75, 75)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(ConfirmAction.ok);
                  },
                )
              ],
            );
    },
  );
}
