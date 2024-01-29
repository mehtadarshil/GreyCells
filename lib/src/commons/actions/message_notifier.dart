import 'package:flutter/material.dart';

class MyMessageNotifier {
  static double minValue = 8.0;

  static Widget errorNotifier(
      {required BuildContext context,
      required String message,
      Function? onClose}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(minValue)),
      ),
      padding:
          EdgeInsets.symmetric(horizontal: minValue, vertical: minValue * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.blueGrey[900],
            radius: 12.0,
            child: GestureDetector(
              onTap: onClose as void Function()?,
              child: Icon(
                Icons.close,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
