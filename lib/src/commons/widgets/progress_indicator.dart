import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyprogressIndicator extends StatelessWidget {
  final double? percentage;
  double percentageText = 0.0;

  MyprogressIndicator({this.percentage});

  final elgibleS = Colors.green;
  final notAlgibleS = Colors.redAccent;
  final elgibleBackS = Colors.green[200];
  final notAlgibleBackS = Colors.red[200];

  double get getPercenatge {
    return percentage! / 100;
  }

  bool get isEligible {
    return getPercenatge > 0.5 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? sub = Theme.of(context).textTheme.bodySmall;

    return LinearPercentIndicator(
      clipLinearGradient: true,

      backgroundColor: isEligible ? elgibleBackS : notAlgibleBackS,
      animation: true,
      lineHeight: 8.0,
      animationDuration: 2000,
      percent: getPercenatge,
//      center: Text(
//        "${percentageText.toString().length > 4 ? percentageText.toStringAsFixed(1) : percentageText.toString()}%",
//        style:
//        sub.apply(color: percentageText > 45 ? Colors.black : Colors.white),
//      ),
      animateFromLastPercent: true,
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: isEligible ? elgibleS : notAlgibleS,
    );
  }
}
