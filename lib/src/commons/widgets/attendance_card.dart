import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/widgets/progress_indicator.dart';

class MyAttendanceCard extends StatelessWidget {
  final List item;

  MyAttendanceCard({required this.item});

  double getPercentage(String total, String attended) {
    return (int.parse(attended) / int.parse(total)) * 100;
  }

  double minValue = 8.0;

  Widget _buildCustomAttCard(BuildContext context) {
    final attTextS =
        Theme.of(context).textTheme.headlineMedium!.apply(fontWeightDelta: 1);
    final dateS = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
    final classS = Theme.of(context).textTheme.headlineMedium;
    return Card(
      margin:
          EdgeInsets.symmetric(vertical: minValue, horizontal: minValue * 2),
      elevation: 0.0,
      child: Container(
        height: MediaQuery.of(context).size.height / 5.8,
        padding: EdgeInsets.symmetric(horizontal: minValue * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${item[0]}",
                        style: dateS,
                      ),
                      SizedBox(
                        height: minValue,
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Total",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                "${item[1]}",
                                style: classS,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Attended",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                "${item[2]}",
                                style: classS,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
//                  color: Colors.pink,
                  padding: EdgeInsets.all(minValue * 2),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "${getPercentage(item[1], item[2]).toStringAsFixed(0)}",
                          style: attTextS.apply(color: Colors.blueGrey[700]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: minValue + 2),
                          child: Text("%"),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            MyprogressIndicator(
              percentage: getPercentage(item[1], item[2]),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCustomAttCard(context);
  }
}
