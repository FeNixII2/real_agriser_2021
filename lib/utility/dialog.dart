import 'package:flutter/material.dart';

Future<void> dialong(BuildContext context, String message) async {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            title: Text(message),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("ตกลง")),
                ],
              )
            ],
          ));
}
