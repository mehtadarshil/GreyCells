import 'package:flutter/material.dart';
import 'package:greycell_app/src/config/core_config.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MyBottomNavigation extends StatelessWidget {
  final Function? onTap;
  List<Item> itemList = [
    // Item(
    //   title: "Home",
    //   icon: Icons.home,
    // ),
    // Item(
    //   title: "Payment",
    //   icon: Icons.payment,
    // ),
  ];
  List<Item> staffList = [
    Item(
      title: "Home",
      icon: Icons.home,
    ),
    Item(
      title: "Attendance",
      icon: Icons.assignment_turned_in,
    ),
  ];
  double minValue = 8.0;
  final int? index;

//
//              ?
  MyBottomNavigation({Key? key, this.onTap, this.index});

  Widget _buildItem(BuildContext context, Item item, bool isSelected) {
    final activeS = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 16.0, letterSpacing: 0.6);
    final inActiveS = TextStyle(fontSize: 16.0);

    return Container(
      height: double.maxFinite,
//      padding: EdgeInsets.symmetric(
//          vertical: minValue * 2, horizontal: minValue * 3),
      width: MediaQuery.of(context).size.width / 2,
      decoration: isSelected
          ? BoxDecoration(
              color: Colors.blue[50],
//              borderRadius: BorderRadius.only(
//                  topRight: _selectedIndex == 1
//                      ? Radius.circular(0)
//                      : Radius.circular(minValue * 2),
//                  topLeft: _selectedIndex == 1
//                      ? Radius.circular(minValue * 2)
//                      : Radius.circular(0))
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            item.icon,
            color: isSelected ? Colors.black : Colors.black54,
            size: 18.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: minValue),
            child: Text(
              item.title!,
              style: isSelected ? activeS : inActiveS,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 65,
      color: Colors.grey[100],
      child: ScopedModelDescendant(
        builder: (context, _, MainModel model) {
          return model.user == null
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: model.user!.getUserType == Core.STUDENT_USER
                      ? itemList.map((item) {
                          int _current = itemList.indexOf(item);
                          return InkWell(
                            splashColor: Colors.blue[50],
                            onTap: () {
                              onTap!(_current);
                            },
                            child: _buildItem(context, item, index == _current),
                          );
                        }).toList()
                      : staffList.map((item) {
                          int _current = staffList.indexOf(item);
                          return InkWell(
                            splashColor: Colors.blue[50],
                            onTap: () {
                              onTap!(_current);
                            },
                            child: _buildItem(context, item, index == _current),
                          );
                        }).toList(),
                );
        },
      ),
    );
  }
}

class Item {
  final IconData? icon;
  final String? title;

  Item({this.icon, this.title});
}
