//import 'package:flutter/material.dart';
//import 'package:greycell_app/src/commons/actions/dialog_handler.dart';
//import 'package:greycell_app/src/manager/main_model.dart';
//import 'package:greycell_app/src/utils/permissions/permissions.dart';
//import 'package:greycell_app/src/views/testViews/analysis/result_download.dart';
//import 'package:scoped_model/scoped_model.dart';
//
//class MyDownloadResult extends StatelessWidget {
//  double minValue = 8.0;
//
//  void _onDownloadResult(BuildContext context, MainModel model) async {
//    String msg = "";
//    if (await Permissions.checkPermissions()) {
//      DialogHandler.showMyLoader(context: context, message: "Generating pdf");
//      bool result = await ResultDownloader.downloadAsPdf(model);
//      Navigator.of(context).pop();
//      msg = "Pdf saved successfully";
//    } else {
//      msg = "Storage permission required";
//    }
//
//    final snackbar = SnackBar(
//      content: Text(
//        msg,
//        style: TextStyle(color: Colors.white),
//      ),
//      elevation: 15.0,
//      backgroundColor: Theme.of(context).accentColor,
//    );
//    Scaffold.of(context).showSnackBar(snackbar);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return ScopedModelDescendant(
//        builder: (context, _, MainModel model) => IconButton(
//              icon: Icon(Icons.get_app),
//              onPressed: () => _onDownloadResult(context, model),
//              tooltip: "Download the report",
//            ));
//  }
//}
