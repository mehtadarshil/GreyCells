import 'package:flutter/material.dart';

class MyNotFound extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Function? onRetry;

  MyNotFound({this.title, this.subtitle, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/moon_error.png",
            height: 150.0,
            width: 150.0,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "${title ?? 'Not Found'}",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(fontWeightDelta: 1, color: Colors.blueGrey[800]),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "${subtitle ?? ''}",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .apply(color: Colors.blueGrey),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 150.0,
            height: 40.0,
            child: ElevatedButton.icon(
                onPressed: onRetry as void Function()?,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[800]),
                icon: Icon(Icons.refresh, color: Colors.white),
                label: Text(
                  "RETRY",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
