import 'package:flutter/material.dart';

class MyOverAllAttendance extends StatelessWidget {
  final double percentage;
  final double? minAttendance;

  MyOverAllAttendance({required this.percentage, this.minAttendance});

  double minValue = 8.0;

  bool get isEligible {
    return percentage > minAttendance!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      margin: EdgeInsets.only(top: minValue * 2),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: isEligible
                  ? [Colors.green, Colors.lightGreen]
                  : [Colors.redAccent, Colors.pink]),
          borderRadius: BorderRadius.all(Radius.circular(minValue * 2))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Over All",
            style: TextStyle(fontSize: 13.0, color: Colors.white70),
          ),
          Text(
            "${percentage.toStringAsFixed(0)} %",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(color: Colors.white, fontWeightDelta: 1),
          ),
        ],
      ),
    );
  }
}
