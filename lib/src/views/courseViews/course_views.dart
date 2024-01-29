import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/widgets/not_found.dart';
import 'package:greycell_app/src/commons/widgets/user_info.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/courseModel/time_table_model.dart';
import 'package:greycell_app/src/models/response/failure.dart';
import 'package:greycell_app/src/models/response/response.dart';
import 'package:greycell_app/src/models/response/success.dart';
import 'package:greycell_app/src/views/courseViews/student_batch.dart';
import 'package:greycell_app/src/views/courseViews/subject_list.dart';
import 'package:greycell_app/src/views/observer/future_mania.dart';
import 'package:intl/intl.dart';

class MyCourseViews extends StatefulWidget {
  final MainModel model;

  MyCourseViews({required this.model});

  @override
  _MyCourseViewsState createState() => _MyCourseViewsState();
}

class _MyCourseViewsState extends State<MyCourseViews> {
  Future<ResponseMania>? _futureResponse;
  double minValue = 8.0;
  DateTime selectedWeekday = DateTime.now();
  TimeTableModel? timeTableModel;
  bool loading = false;

  DateTime mostRecentSunday() => DateTime(DateTime.now().year,
      DateTime.now().month, DateTime.now().day - DateTime.now().weekday % 7);

  void _onCreate(DateTime date) async {
    setState(() {
      loading = true;
    });
    _futureResponse = widget.model.getCourseDetails(date: date);
    var data = await _futureResponse;
    if (data is Success) {
      setState(() {
        timeTableModel = data.success as TimeTableModel;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _onCreate(DateTime.now());
  }

  Widget _buildBody(TimeTableModel course, Function(DateTime date) onTap) {
    return ListView(
      children: <Widget>[
        MyUserInfo(),
        MyStudentBatch(
          studentBatchList: course.getStdnBatchDetailVector!,
        ),
        SizedBox(
          height: 30,
          child: ListView.separated(
            itemCount: 7,
            padding: EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var date = mostRecentSunday().add(Duration(days: index));
              return GestureDetector(
                onTap: () {
                  onTap(date);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: selectedWeekday.weekday == date.weekday
                          ? Colors.blue
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 0.5)),
                  child: Text(
                    DateFormat("EEEE").format(date),
                    style: TextStyle(
                        color: selectedWeekday.weekday == date.weekday
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 10,
              );
            },
          ),
        ),
        SizedBox(
          height: 15,
        ),
        MySubjectList(
          subjectList: course.getStdnSubjectDetailVector,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timetable"),
      ),
      backgroundColor: Colors.grey[50],
      body: FutureMania(
        future: _futureResponse,
//        onFailed: (context, Failure failed) {
//          print("Failed");
//          return Center(
//              child: MyNotFound(
//            title: "No Data Available",
//          ));
//        },
        onError: (context, Failure failed) {
          print("Error");

          return Center(
            child: MyNotFound(
              title: "${failed.responseMessage}",
              subtitle: "Check your internet connectivity.",
              onRetry: _onCreate,
            ),
          );
        },
        onSuccess: (context, TimeTableModel course) {
          return _buildBody(
            course,
            (date) {
              setState(() {
                selectedWeekday = date;
                _onCreate(date);
              });
            },
          );
        },
      ),
    );
  }
}
