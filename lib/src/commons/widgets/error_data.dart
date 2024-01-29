import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/themes/textstyle.dart';

class MyErrorData extends StatelessWidget {
  final Function? onReload;
  final String? errorMsg;
  final String? subtitle;

  MyErrorData(
      {this.onReload, this.errorMsg = "No data available", this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            size: 65,
//            color: Theme.of(context).primaryColorDark,
            color: Colors.redAccent,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            "$errorMsg",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "${subtitle ?? 'Please check your internet settings'}",
            textAlign: TextAlign.center,
            style:
                CustomTextStyle(context).caption!.apply(color: Colors.black87),
          ),
          SizedBox(
            height: 15.0,
          ),
          onReload == null
              ? Container()
              : TextButton.icon(
                  onPressed: onReload as void Function()?,
                  icon: Icon(Icons.refresh),
                  label: Text("RELOAD"))
        ],
      ),
    );
  }
}
