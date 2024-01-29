import 'package:flutter/material.dart';
import 'package:greycell_app/src/config/core_config.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  final bool emptyTheme;
  final Color? backgroundColor;
  final Function? onLeadingTapped;

  MyAppbar(
      {this.title,
      this.emptyTheme = false,
      this.backgroundColor,
      this.onLeadingTapped});

  double _minPadding = 8.1;

  AppBar _defaultBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
          this.title == null || this.title == '' ? Core.APPNAME : this.title!),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      actions: <Widget>[
//        Padding(
//          padding: EdgeInsets.all(_minPadding),
//          child: IconButton(
//            icon: Icon(Icons.notifications),
//            iconSize: 24,
//            padding: EdgeInsets.all(_minPadding),
//            onPressed: () => debugPrint("Notification Tapped"),
//          ),
//        )
      ],
    );
  }

  AppBar _customBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: onLeadingTapped as void Function()?,
        icon: Icon(Icons.arrow_back_ios),
        color: Colors.blueGrey[700],
      ),
      title: Text(this.title == null || this.title == '' ? '' : this.title!),
      centerTitle: true,
      backgroundColor: backgroundColor ?? Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return emptyTheme ? _customBar(context) : _defaultBar(context);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
