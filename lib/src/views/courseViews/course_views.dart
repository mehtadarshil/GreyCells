import 'dart:developer';

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
  DateTime? customDate;
  TimeTableModel? timeTableModel;
  bool loading = false;

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
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onCreate(DateTime.now());
    });
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
          child: Wrap(
            runAlignment: WrapAlignment.center,
            direction: Axis.vertical,
            children: [0, 1, 2, 3].map((index) {
              var date = index < 2
                  ? DateTime.now().subtract(Duration(days: index == 0 ? 1 : 0))
                  : DateTime.now().add(Duration(days: 1));

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: StatefulBuilder(builder: (context, setState) {
                  return GestureDetector(
                    onTap: () async {
                      if (index == 3) {
                        var selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(100),
                            lastDate: DateTime.now());
                        if (selectedDate != null) {
                          setState(
                            () {
                              customDate = selectedDate;
                            },
                          );
                        }
                      } else {
                        setState(() {
                          customDate = null;
                        });
                      }
                      if (customDate != null) {
                        log(customDate.toString());
                        onTap(index == 3 ? customDate! : date);
                      } else {
                        onTap(date);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: index == 3 && customDate != null
                              ? Colors.blue
                              : DateFormat("dd-MM-yyyy")
                                              .format(selectedWeekday) ==
                                          DateFormat("dd-MM-yyyy")
                                              .format(date) &&
                                      index != 3
                                  ? Colors.blue
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black, width: 0.5)),
                      child: Text(
                        index == 0
                            ? "Yesterday"
                            : index == 1
                                ? "Today"
                                : index == 2
                                    ? "Tomorrow"
                                    : customDate != null
                                        ? DateFormat("dd-MM-yyyy")
                                            .format(customDate!)
                                        : "Select Date",
                        style: TextStyle(
                            color: index == 3 && customDate != null
                                ? Colors.white
                                : DateFormat("dd-MM-yyyy")
                                                .format(selectedWeekday) ==
                                            DateFormat("dd-MM-yyyy")
                                                .format(date) &&
                                        index != 3
                                    ? Colors.white
                                    : Colors.black),
                      ),
                    ),
                  );
                }),
              );
            }).toList(),
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
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : FutureMania(
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
