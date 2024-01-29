import 'package:flutter/material.dart';
import 'package:greycell_app/src/config/core_config.dart';

class MyLogo extends StatelessWidget {
  final double elevation;
  final String name;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color? textColor;
  final bool hasVertical;

  MyLogo ({this.hasVertical = false,
    this.textColor,
    this.elevation = 8.0,
      this.name = '',
    this.width = 270.0,
      this.height = 100.0,
    this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return hasVertical
        ? Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(
              "assets/images/greycell_logo.jpg",
              height: 80,
            ),
          ),
          Text(
            name == '' ? Core.APPNAME : name,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor ?? Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                letterSpacing: 1.4,
                fontFamily: "Montserrat",
                shadows: [
                  Shadow(color: Colors.blueGrey[200]!, blurRadius: 15),
                  Shadow(color: Colors.blue, blurRadius: 1)
                ]),
          ),
        ],
      ),
    )
        : Container(
      height: height,
      width: width,
      child: Card(
        color: backgroundColor ?? Colors.white,
        clipBehavior: Clip.antiAlias,
        elevation: elevation,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset(
                "assets/images/greycell_logo.jpg",
                height: 80,
              ),
            ),
            Text(
              name == '' ? Core.APPNAME : name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: textColor ?? Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  letterSpacing: 1.4,
                  fontFamily: "Montserrat",
                  shadows: [
                    Shadow(color: Colors.blueGrey[200]!, blurRadius: 15),
                    Shadow(color: Colors.blue, blurRadius: 1)
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
