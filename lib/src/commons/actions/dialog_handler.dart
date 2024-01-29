import 'package:flutter/material.dart';

class DialogHandler {
  static showMyLoader({required BuildContext context, String? message}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: ListTile(
                leading: CircularProgressIndicator(),
                title: Text(
                  "${message ?? 'Loading'}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
//              subtitle: Text("Please wait"),
              ),
            ),
          );
        });
  }

  /// Negotiation Chat
  static Future<void> onWillPopDialog(
      {required BuildContext context,
      required VoidCallback onSubmit,
      String? title,
      Widget? content}) {
    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.6),
      barrierLabel: '',
      context: context,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return Transform(
            transform:
                Matrix4.translationValues(anim1.value, 0.0, anim2.value * 100),
            child: AlertDialog(
              title: Text(
                "${title ?? 'Confirmation'}",
                style: TextStyle(),
              ),
              content: content,
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "CLOSE",
                      style: TextStyle(color: Colors.black87),
                    )),
                TextButton(
                    onPressed: onSubmit,
                    child: Text(
                      "BACK",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ))
              ],
            ));
      },
      barrierDismissible: false,
    );
  }

  //
  /// Negotiation Chat
  static Future<void> onCustomAlertDialog(
      {required BuildContext context,
      required VoidCallback onSubmit,
      String? title,
      Widget? content}) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.6),
        barrierLabel: '',
        context: context,
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (context, anim1, anim2) {} as Widget Function(
            BuildContext, Animation<double>, Animation<double>),
        barrierDismissible: false,
        transitionBuilder: (context, a1, a2, ch) {
          final curvedValue = Curves.bounceInOut.transform(a1.value) - 1.0;
          return Transform(
              transform: Matrix4.translationValues(
                  curvedValue, 0.0, curvedValue * 100),
              child: AlertDialog(
                title: Text(
                  "${title ?? 'Confirmation'}",
                  style: TextStyle(),
                ),
                content: content,
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "CLOSE",
                        style: TextStyle(color: Colors.black87),
                      )),
                  TextButton(
                      onPressed: onSubmit,
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ))
                ],
              ));
        });
  }
}
