import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/logo/MyLogo.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MyInfoViews extends StatelessWidget {
  double minValue = 8.0;

  Widget _buildCompany(BuildContext context, MainModel model) {
    final gCPackageInfo = model.gCPackageInfo;
    return Container(
      height: 90.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(minValue * 4),
              topRight: Radius.circular(minValue * 4))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Powered by",
            style: TextStyle(color: Colors.grey[500]),
          ),
          Image.asset("assets/images/kspl.jpg"),
//
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Info"),
      ),
      backgroundColor: Colors.grey[100],
      body: ScopedModelDescendant(
        builder: (context, _, MainModel model) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: MyLogo(
                          elevation: 0.0,
                          hasVertical: true,
                          backgroundColor: Colors.grey[100],
                          textColor: Colors.black87,
                        ),
                      ),
                      SizedBox(
                        height: minValue - 3,
                      ),
                      Text("version: ${model.gCPackageInfo.version}")
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildCompany(context, model),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
