import 'package:flutter/material.dart';
import 'package:greycell_app/src/models/student/student_model.dart';

class MyPersonalDetails extends StatelessWidget {
  final Student? student;

  MyPersonalDetails({required this.student});

  final double minValue = 8.0;

  @override
  Widget build(BuildContext context) {
    TextStyle? subtitle = Theme.of(context).textTheme.titleSmall;
    TextStyle title = Theme.of(context)
        .textTheme
        .headlineMedium!
        .apply(fontWeightDelta: 1)
        .copyWith(fontSize: 16);
    TextStyle subhead =
        Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14);
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
              "Personal Information",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(
              "${student!.getRegistrationNo ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Registration number",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.account_box,
              size: iconSize,
              color: color,
            ), //,
          ),
          ListTile(
            title: Text(
              "${student!.getEmail! + '@' + (student!.getEmailDomainId ?? ' ')}",
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
              "${student!.getMobileNo ?? ' '}",
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
              "${student!.getDateOfBirth ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Date of birth",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.date_range,
              size: iconSize,
              color: color,
            ), //,
          ),
          ListTile(
            title: Text(
              "${student!.getAddress ?? ' '}",
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
