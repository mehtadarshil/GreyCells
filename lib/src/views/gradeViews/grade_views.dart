import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/widgets/not_found.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/payment/due_detail.dart';
import 'package:greycell_app/src/models/response/failure.dart';
import 'package:greycell_app/src/models/response/response.dart';
import 'package:greycell_app/src/views/observer/future_mania.dart';

class MyGradeViews extends StatefulWidget {
  final MainModel? model;

  MyGradeViews ({Key? key, this.model});

  @override
  _MyGradeViewsState createState () => _MyGradeViewsState();
}

class _MyGradeViewsState extends State<MyGradeViews> {
  Future<ResponseMania>? _futureResponse;
  double minValue = 8.0;

  void _onCreate () async {
//    _futureResponse = widget.model.getAccountDueDetail();
  }

  @override
  void initState () {
    super.initState();
    _onCreate();
  }

  Widget _buildBody () {
    return ListView(
      children: <Widget>[],
    );
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grades"),
      ),
      backgroundColor: Colors.grey[200],
      body: FutureMania(
        future: _futureResponse,
        onFailed: (context, Failure failed) {
          return Center(
              child: MyNotFound(
                title: "No Data Available",
                onRetry: _onCreate,
              ));
        },
        onError: (context, failed) {
          return Center(
            child: Text("Error: ${failed}"),
          );
        },
        onSuccess: (context, DueDetail gradeDetail) {
          return _buildBody();
        },
      ),
    );
  }
}
