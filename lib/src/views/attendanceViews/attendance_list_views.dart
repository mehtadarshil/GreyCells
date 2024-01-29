import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/widgets/attendance_card.dart';
import 'package:greycell_app/src/models/attendance/term.dart';
import 'package:greycell_app/src/views/attendanceViews/overall_attendance.dart';

class MyAttendanceList extends StatefulWidget {
  final List<Term>? dataSet;
  final double minAttendance;

  MyAttendanceList({required this.dataSet, this.minAttendance = 75.0});

  @override
  _MyAttendanceListState createState() => _MyAttendanceListState();
}

class _MyAttendanceListState extends State<MyAttendanceList> {
  List<Term>? dataSet;
  double minValue = 8.0;

  int _selectedIndex = 0;
  double attended = 0.0;
  double total = 0.0;

  @override
  initState() {
    super.initState();
    dataSet = widget.dataSet;
  }

  void _onTermSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  double get percentage {
    dataSet![_selectedIndex].termDataSet!.forEach((value) {
      total = total + double.parse(value[1]);
      attended = attended + double.parse(value[2]);
    });

    return (attended / total) * 100;
  }

  Widget _buildClassList() {
    final classS = Theme.of(context).textTheme.titleMedium;
    return Container(
      margin: EdgeInsets.only(
        top: minValue * 2,
      ),
      height: 65.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: minValue * 2),
          itemCount: dataSet!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: minValue * 2),
              child: InkWell(
                onTap: () => _onTermSelected(index),
                child: Container(
//                margin: EdgeInsets.only(right: minValue * 2),
                  height: 65.0,
                  width: _selectedIndex == index ? 110.0 : 75.0,
//              padding: EdgeInsets.all(minValue * 3),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(minValue)),
                      color:
                          _selectedIndex == index ? Colors.orange[100] : null),
                  child: Center(
                    child: Text(
                      "${dataSet![index].termName}",
                      style: classS!.apply(color: Colors.black),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildAttList() {
    final int length = dataSet![_selectedIndex].termDataSet!.length;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: minValue,
      ),
      child: ListView.builder(
          reverse: true,
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: length,
          itemBuilder: (context, index) {
            final List termSet = dataSet![0].termDataSet![index];
            return MyAttendanceCard(
              item: termSet,
            );
          }),
    );
  }

  Widget _buildHead() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: minValue * 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "My Term",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(color: Colors.blueGrey),
              ),
              SizedBox(
                height: minValue,
              ),
              Text(
                "${dataSet![_selectedIndex].termName}",
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
          MyOverAllAttendance(
            percentage: percentage,
            minAttendance: widget.minAttendance,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(minValue * 3))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHead(),
//          _buildClassList(),
//          _buildGraph(),
          _buildAttList(),
        ],
      ),
    );
  }
}
