import 'package:flutter/material.dart';

class MyCustomCardTile extends StatelessWidget {
  final String headerName;
  final String? textValue;
  final Color borderColor;
  final List<Color> gradientColor;

  MyCustomCardTile(
      {this.headerName = '',
      this.textValue = '',
      this.gradientColor = const [Colors.red, Colors.pink],
      this.borderColor = Colors.pink});

  final double minValue = 8.0;

  @override
  Widget build(BuildContext context) {
    final title =
        Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14);
    final subhead =
        Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: minValue * 2),
      elevation: 9.0,
      child: Container(
        height: 75.0,
        decoration: BoxDecoration(
            border: Border(left: BorderSide(color: borderColor, width: 3))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: minValue * 2),
              child: Text(
                "$headerName",
                style: subhead.apply(fontWeightDelta: 1),
              ),
            )),
            Container(
              height: double.maxFinite,
              width: 75.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientColor)),
              child: Center(
                child: Text(
                  "$textValue",
                  textAlign: TextAlign.center,
                  style: title.apply(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
