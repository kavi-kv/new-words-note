import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static Future<bool?> showConfirmationDialog(
      BuildContext context,  String message,bool isDelete ) async {
    bool? result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete"),
            content: Text(message),
            actions: <Widget>[
              TextButton(onPressed: () {
                Navigator.pop(context,false);
                // Navigator.of(context).pop();
              }, child: const Text("No")),
              TextButton(onPressed: () {
                Navigator.pop(context,true);
                // Navigator.of(context).pop();
              }, child: const Text("Yes")),
            ],
          );
        });
        return result;
  }
}
