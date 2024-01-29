import 'package:flutter/material.dart';
import 'package:greycell_app/src/models/student/student_model.dart';

class MyGuardianDetails extends StatelessWidget {
  final Student? student;

  MyGuardianDetails({required this.student});

  final double minValue = 8.0;

  @override
  Widget build(BuildContext context) {
    TextStyle? subtitle = Theme.of(context).textTheme.titleSmall;
    TextStyle title =
        Theme.of(context).textTheme.headlineMedium!.apply(fontWeightDelta: 1);
    TextStyle subhead = Theme.of(context).textTheme.titleSmall!;
    Color color = Theme.of(context).primaryColorDark;
    Color? titleColor = Colors.blueGrey[700];
    Color subTitleColor = Colors.black38;

    double iconSize = 28.0;
    return Container(
      margin: EdgeInsets.symmetric(vertical: minValue * 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(minValue * 3))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: minValue, vertical: minValue * 2),
            child: Text(
              "Guardian Information",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(
              "${student!.getFatherName ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Father's name",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.person,
              size: iconSize,
              color: color,
            ), //,
          ),
          ListTile(
            title: Text(
              "${student!.getMotherName ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Mother's name",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.person,
              size: iconSize,
              color: color,
            ), //,
          ),
          ListTile(
            title: Text(
              "${student!.getGuardianEmail ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Email ",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.email,
              size: iconSize,
              color: color,
            ), //,
          ),
          ListTile(
            title: Text(
              "${student!.getGuardianMobile ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Mobile number",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.phone,
              size: iconSize,
              color: color,
            ), //,
          ),
          ListTile(
            title: Text(
              "${student!.getGuardianAddress ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Address",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.location_city,
              size: iconSize,
              color: color,
            ), //,
          ),
        ],
      ),
    );
  }
}
