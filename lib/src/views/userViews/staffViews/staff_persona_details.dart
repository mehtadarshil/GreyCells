import 'package:flutter/material.dart';
import 'package:greycell_app/src/models/user/staff_model.dart';

class StaffPersonalDetails extends StatelessWidget {
  final Staff? staff;

  StaffPersonalDetails({required this.staff});

  final double minValue = 8.0;

  @override
  Widget build(BuildContext context) {
    TextStyle? subtitle = Theme.of(context).textTheme.titleMedium;
    TextStyle title = Theme.of(context)
        .textTheme
        .headlineMedium!
        .apply(fontWeightDelta: 1)
        .copyWith(fontSize: 16);
    TextStyle subhead =
        Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14);
    Color color = Theme.of(context).primaryColorDark;
    Color? titleColor = Colors.blueGrey[700];
    Color subTitleColor = Colors.black38;

    double iconSize = 28.0;

    return Container(
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
              "${staff!.getStaffCode ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Staff Code",
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
              "${staff!.getEmail ?? ' '}",
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
              "${staff!.getMobileNo ?? ' '}",
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
              "${staff!.getDateOfBirth ?? ' '}",
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
              "${staff!.getGender ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Gender",
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
              "${staff!.getBloodGroup ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Blood Group",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.category,
              size: iconSize,
              color: color,
            ), //,
          ),
          ListTile(
            title: Text(
              "${staff!.getFatherName ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Father Name",
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
              "${staff!.getSpouseName ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Spouse Name",
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
              "${staff!.getPanNo ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Pan Number",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.perm_identity,
              size: iconSize,
              color: color,
            ), //,
          ),

          ListTile(
            title: Text(
              "${staff!.getAadharNo ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Aadhar Number",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.perm_identity,
              size: iconSize,
              color: color,
            ), //,
          ),

//          DEPARTMENT
          ListTile(
            title: Text(
              "${staff!.getDepartment ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Department",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.account_balance,
              size: iconSize,
              color: color,
            ), //,
          ),
          ListTile(
            title: Text(
              "${staff!.getDesignationType ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Designation Type",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.category,
              size: iconSize,
              color: color,
            ), //,
          ),
          ListTile(
            title: Text(
              "${staff!.getDesignation ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Designation",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.description,
              size: iconSize,
              color: color,
            ), //,
          ),

//          ADDRESSS
          ListTile(
            title: Text(
              "${staff!.getCountry ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Country",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.language,
              size: iconSize,
              color: color,
            ), //,
          ),
          ListTile(
            title: Text(
              "${staff!.getState ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "State",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.location_city,
              size: iconSize,
              color: color,
            ), //,
          ),
          ListTile(
            title: Text(
              "${staff!.getCity ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "City",
              style: subhead.apply(color: subTitleColor),
            ),
            leading: Icon(
              Icons.location_city,
              size: iconSize,
              color: color,
            ), //,
          ),
          ListTile(
            title: Text(
              "${staff!.getPin ?? ' '}",
              style: title.apply(color: titleColor),
            ),
            subtitle: Text(
              "Pincode",
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
              "${staff!.getAddressLine1 ?? ' '}, ${staff!.getAddressLine2 ?? ' '}, ${staff!.getAddressLine3 ?? ' '}",
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
