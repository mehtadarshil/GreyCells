import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/widgets/error_data.dart';
import 'package:greycell_app/src/commons/widgets/loader.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/attendance/attendance_model.dart';
import 'package:greycell_app/src/views/attendanceViews/attendance_header.dart';
import 'package:greycell_app/src/views/attendanceViews/attendance_list_views.dart';
import 'package:greycell_app/src/views/chartViews/stacked_chart.dart';
import 'package:greycell_app/src/views/observer/future_observer.dart';

class MyAttendanceViews extends StatefulWidget {
  final MainModel model;
  final bool isDashboard;

  MyAttendanceViews({required this.model, this.isDashboard = false});

  @override
  _MyAttendanceViewsState createState() => _MyAttendanceViewsState();
}

class _MyAttendanceViewsState extends State<MyAttendanceViews> {
  double minValue = 8.0;
  Attendance? _attendance;
  Future<Attendance?>? _futureAttendance;

  bool isLoading = false;

  void _onCreate() async {
    _futureAttendance = widget.model.getStudentAttendance();
    _attendance = await _futureAttendance;
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  void _onRetry(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    _onCreate();

    if (_attendance == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Internal error occurred",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _onCreate();
  }

  Widget _buildBody() {
    print("_attendance.terms: ${_attendance!.terms}");
    return Container(
      child: ListView(
        children: <Widget>[
          _attendance!.terms == null
              ? Container()
              : MyAttendanceHeader(
                  attendance: _attendance,
                ),
//          _buildOverAllAttendance(),

          _attendance!.terms == null || _attendance!.terms!.length < 0
              ? MyErrorData(
                  onReload: () => null,
                  errorMsg: "No Attendance Found",
                )
              : MyAttendanceList(
                  dataSet: _attendance!.terms,
                  minAttendance: double.parse(_attendance!.getMinAttendance!),
                )
        ],
      ),
    );
  }

  Widget _buildGraphCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: minValue),
      child: StackedBarChart(_attendance!.terms),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isDashboard
          ? null
          : AppBar(
              title: Text("Attendance"),
            ),
      body: isLoading
          ? Loader()
          : FutureObserver<Attendance?>(
              future: _futureAttendance,
              onWaiting: (context) {
                return Loader();
              },
              onSuccess: (context, Attendance attendance) {
                if (attendance == null) {
                  return Container(
                    child: MyErrorData(
                      onReload: () => null,
                    ),
                  );
                } else if (widget.isDashboard) {
                  return _buildGraphCard();
                }
                return _buildBody();
              },
              onError: (context, error) {
                print(error.toString());
                return Container(
                  child: Builder(
                    builder: (BuildContext context) {
                      return MyErrorData(
                        errorMsg: "${error.toString()}",
                        onReload: () => _onRetry(context),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
