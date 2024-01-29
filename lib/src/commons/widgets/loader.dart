import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final String? message;

  const Loader({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        message == null
            ? Container()
            : SizedBox(
                height: 8,
              ),
        message == null ? Container() : Text("$message")
      ],
    );
  }
}
