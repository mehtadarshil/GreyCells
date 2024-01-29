import 'package:flutter/material.dart';
import 'package:greycell_app/src/models/attendance/attendance_model.dart';

class MyAttendanceHeader extends StatelessWidget {
  double minValue = 8.0;
  final Attendance? attendance;

  MyAttendanceHeader({required this.attendance});

  Widget _buildAssetImage() {
    return Container(
      width: 210.0,
      height: 170.0,
      child: Image.asset(
        "assets/images/todole.png",
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildCustomListTile(
      BuildContext context, String? title, String subtitle) {
    final titleStyle =
        Theme.of(context).textTheme.bodyMedium!.apply(fontWeightDelta: 1);
    final subhead = Theme.of(context).textTheme.titleSmall!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          subtitle,
          style: subhead.apply(color: Colors.grey[600]),
        ),
        SizedBox(
          width: 3.0,
        ),
        Text(
          "$title",
          style: titleStyle,
        ),
      ],
    );
  }

  Widget _buildContentHeader(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${attendance!.getStudentName}",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          _buildCustomListTile(context, attendance!.getRollNo, "Roll No:"),
          _buildCustomListTile(context, attendance!.getStudentId, "Id: "),
          _buildCustomListTile(context, attendance!.getBatch, "Batch:"),
          _buildCustomListTile(
              context, attendance!.getDiscipline, "Discipline:"),
        ],
      ),
    );
  }

  Widget _buildLayout(BuildContext context) {
    return Container(
      height: 210.0,
      padding: EdgeInsets.only(
          top: minValue * 2, left: minValue * 2, bottom: minValue * 2),
      child: Stack(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(alignment: Alignment.bottomRight, child: _buildAssetImage()),
          _buildContentHeader(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: _buildLayout(context),
    );
  }
}
