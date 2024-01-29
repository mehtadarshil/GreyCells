import 'package:flutter/material.dart';

class MyQuickLinkButton extends StatelessWidget {
  final Function onSelect;
  final IconData iconData;
  final String title;

  double _minPadding = 8.0;

  MyQuickLinkButton(
      {required this.onSelect, required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(fontSize: 14, letterSpacing: 0.2);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          height: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                iconData,
                size: 30,
//                color: Theme.of(context).primaryColorDark,
                color: Color(0xff0e193d),
              ),
              SizedBox(height: _minPadding * 2),
              Text(
                "$title",
                style: ts,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        splashColor: Colors.blueAccent[100],
        customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_minPadding)),
        borderRadius: BorderRadius.circular(2),
        onTap: onSelect as void Function()?,
      ),
    );
  }
}
