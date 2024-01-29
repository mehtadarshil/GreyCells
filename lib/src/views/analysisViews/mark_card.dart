import 'package:flutter/material.dart';
import 'package:greycell_app/src/models/analysis/subject_mark.dart';

class MyMarkCard extends StatelessWidget {
  final SubjectMark mark;
  final bool? hasBelow;

  final double minValue = 8.0;
  final List<Color> gradientColor = [Colors.red, Colors.pink];
  final Color borderColor = Colors.pink;
  final Color borderColor2 = Colors.blue;
  final List<Color> gradientColor2 = [Colors.lightBlueAccent, Colors.blue];

  bool get perc =>
      (mark.securedMark! / mark.totalMark!) * 100 > 75.0 ? true : false;

  MyMarkCard({required this.mark, this.hasBelow});

  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.titleMedium!;
    final subhead = Theme.of(context).textTheme.headlineSmall!;
    final subt = Theme.of(context).textTheme.titleSmall!;
    final cap = Theme.of(context).textTheme.bodySmall!;

    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(minValue * 2),
          bottomLeft: Radius.circular(minValue * 2)),
      child: Card(
        margin:
            EdgeInsets.symmetric(horizontal: minValue * 2, vertical: minValue),
        elevation: .2,
        child: Container(
          height: 85.0,
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(
                      color: perc ? borderColor2 : borderColor, width: 3))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: minValue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "${mark.subjectName}",
                      style: subhead.apply(fontWeightDelta: 1),
                    ),
                    Text(
                      " FM: ${mark.totalMark}, SM: ${mark.securedMark}",
                      style: cap.apply(fontWeightDelta: 1),
                    ),
                    Text(
                      "${mark.status!.toUpperCase()}",
                      style: subt.apply(color: Colors.blueGrey[700]),
                    ),
                  ],
                ),
              )),
              Container(
                height: double.maxFinite,
                width: 85.0,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: perc ? gradientColor2 : gradientColor)),
                child: Center(
                  child: Text(
                    "${mark.percentage}",
                    textAlign: TextAlign.center,
                    style: title.apply(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
