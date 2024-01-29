import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/themes/textstyle.dart';
import 'package:greycell_app/src/commons/widgets/error_data.dart';
import 'package:greycell_app/src/commons/widgets/user_info.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/response/failure.dart';
import 'package:greycell_app/src/models/response/response.dart';
import 'package:greycell_app/src/models/timeTable/TimeTable.dart';
import 'package:greycell_app/src/views/observer/future_mania.dart';
import 'package:intl/intl.dart';

class TimeTableViews extends StatefulWidget {
  final MainModel model;

  TimeTableViews({required this.model});

  @override
  _TimeTableViewsState createState() => _TimeTableViewsState();
}

class _TimeTableViewsState extends State<TimeTableViews> {
  List<TimeTable>? _timeTable;
  Future<ResponseMania?>? _futureTimeTable;

  double minValue = 8.0;

  bool? hasCollapse = true;
  String _currentDate = "";

  bool _bgColor1 = false;
  bool _bgColor2 = false;
  bool _bgColor3 = false;
  bool _bgColor4 = false;
  bool _bgColor5 = false;
  bool _bgColor6 = false;
  num? day;

  List<TimeTable>? _timeTable1;

  void _onCreate() async {
    final DateTime _date = DateTime.now();
    final format = DateFormat("dd-MMM-yyyy").format(_date);
    String today = DateFormat('EEE').format(_date);
    if (today == "Mon") {
      _bgColor1 = true;
      day = 1;
    } else if (today == "Tue") {
      _bgColor2 = true;
      day = 2;
    } else if (today == "Wed") {
      _bgColor3 = true;
      day = 3;
    } else if (today == "Thu") {
      _bgColor4 = true;
      day = 4;
    } else if (today == "Fri") {
      _bgColor5 = true;
      day = 5;
    } else if (today == "Sat") {
      _bgColor6 = true;
      day = 6;
    } else {}
    _currentDate = DateFormat.yMMMMd().format(_date);
    _futureTimeTable = widget.model.getTimeTable(asOnDate: format);
  }

  @override
  void initState() {
    super.initState();
    _onCreate();
  }

  final dayList = [
    {"short": "Mon", "num": "1"},
    {"short": "Tue", "num": "2"},
    {"short": "Wed", "num": "3"},
    {"short": "Thu", "num": "4"},
    {"short": "Fri", "num": "5"},
    {"short": "Sat", "num": "6"},
    {"short": "Sun", "num": "7"},
  ];

  String? getDay(String num) {
    int _num = int.parse(num);
//    final DateTime _date = DateTime.

    return dayList[_num - 1]['short'];
  }

  String getClassType(String? type) => type == "(L)"
      ? "Lecture"
      : type == "(P)"
          ? "Practical"
          : "Tutorial";

  Color getClassTypeColor(String? type) => type == "(L)"
      ? Colors.lightGreen
      : type == "(P)"
          ? Colors.pink
          : Colors.teal;

  Widget _buildCard(TimeTable timeTable) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // CircleAvatar(
          //   backgroundColor: Colors.transparent,
          //   child: Text(
          //     "${getDay(timeTable.day)}",
          //     style: TextStyle(color: Colors.black87),
          //   ),
          // ),
          Expanded(
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${timeTable.classTime}",
                            style: CustomTextStyle(context).subtitle2!.apply(
                                color: Theme.of(context).primaryColorDark),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "${timeTable.subject}",
                            style: CustomTextStyle(context).bodyText2,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "Period: ${timeTable.period}",
//                            style: CustomTextStyle(context).bodyText1,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            color: getClassTypeColor(timeTable.classType),
                            alignment: Alignment.center,
                            width: 68.0,
                            child: Text(
                              "${getClassType(timeTable.classType)}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          hasCollapse!
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text("Class Room: ${timeTable.classRoom}"),
                                    Text(
                                        "Class/Section: ${timeTable.className} / ${timeTable.section}"),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text("Batch: ${timeTable.batch}"),
                                    Text("Discipline: ${timeTable.discipline}"),
                                    Text("Course: ${timeTable.course}"),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    !hasCollapse!
                        ? Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("${timeTable.classRoom}"),
                                Text(
                                  "Class Room",
                                  style: CustomTextStyle(context).caption,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                    "${timeTable.className} / ${timeTable.section}"),
                                Text(
                                  "Class/Section",
                                  style: CustomTextStyle(context).caption,
                                ),
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void displayTimeTable(List<TimeTable> timeTables) {
    print("i Am here========================");
  }

  void groupEmployeesByCountry(List<TimeTable> timeTables) {
    final groups = groupBy(timeTables, (TimeTable t) {
      return t.day;
    });
    _timeTable1 = groups["$day"];
  }

  Widget _buildDays(List<TimeTable> timeTables) {
    groupEmployeesByCountry(timeTables);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      height: 30.0,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(
            width: minValue * 1,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _bgColor1 = true;
                _bgColor2 = false;
                _bgColor3 = false;
                _bgColor4 = false;
                _bgColor5 = false;
                _bgColor6 = false;
                day = 1;
              });
              displayTimeTable(timeTables);
            },
            child: new Container(
                width: 60.0,
                // color: Colors.red,
                child: Center(
                    child: Text("MON",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _bgColor1 == true
                                ? Colors.white
                                : Colors.black))),
                // padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color:
                        _bgColor1 == true ? Colors.blue[900] : Colors.white)),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _bgColor1 = false;
                _bgColor2 = true;
                _bgColor3 = false;
                _bgColor4 = false;
                _bgColor5 = false;
                _bgColor6 = false;
                day = 2;
              });
              displayTimeTable(timeTables);
            },
            child: new Container(
                width: 60.0,
                // color: Colors.red,
                child: Center(
                    child: Text("TUE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _bgColor2 == true
                                ? Colors.white
                                : Colors.black))),
                // padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color:
                        _bgColor2 == true ? Colors.blue[900] : Colors.white)),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _bgColor1 = false;
                _bgColor2 = false;
                _bgColor3 = true;
                _bgColor4 = false;
                _bgColor5 = false;
                _bgColor6 = false;
                day = 3;
              });
              displayTimeTable(timeTables);
            },
            child: new Container(
                width: 60.0,
                // color: Colors.red,
                child: Center(
                    child: Text("WED",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _bgColor3 == true
                                ? Colors.white
                                : Colors.black))),
                // padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color:
                        _bgColor3 == true ? Colors.blue[900] : Colors.white)),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _bgColor1 = false;
                _bgColor2 = false;
                _bgColor3 = false;
                _bgColor4 = true;
                _bgColor5 = false;
                _bgColor6 = false;
                day = 4;
              });
              displayTimeTable(timeTables);
            },
            child: new Container(
                width: 60.0,
                // color: Colors.red,
                child: Center(
                    child: Text("THU",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _bgColor4 == true
                                ? Colors.white
                                : Colors.black))),
                // padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color:
                        _bgColor4 == true ? Colors.blue[900] : Colors.white)),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _bgColor1 = false;
                _bgColor2 = false;
                _bgColor3 = false;
                _bgColor4 = false;
                _bgColor5 = true;
                _bgColor6 = false;
                day = 5;
              });
              displayTimeTable(timeTables);
            },
            child: new Container(
                width: 60.0,
                // color: Colors.red,
                child: Center(
                    child: Text("FRI",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _bgColor5 == true
                                ? Colors.white
                                : Colors.black))),
                // padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color:
                        _bgColor5 == true ? Colors.blue[900] : Colors.white)),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _bgColor1 = false;
                _bgColor2 = false;
                _bgColor3 = false;
                _bgColor4 = false;
                _bgColor5 = false;
                _bgColor6 = true;
                day = 6;
              });
              displayTimeTable(timeTables);
            },
            child: new Container(
                width: 60.0,
                // color: Colors.red,
                child: Center(
                    child: Text("SAT",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _bgColor6 == true
                                ? Colors.white
                                : Colors.black))),
                // padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color:
                        _bgColor6 == true ? Colors.blue[900] : Colors.white)),
          ),
          // Container(
          //     width: 60.0,
          //     // color: Colors.red,
          //     child: Center(child: Text("SAT", textAlign: TextAlign.center)),
          //     // padding: const EdgeInsets.all(16.0),
          //     decoration: BoxDecoration(
          //       border: Border.all(color: Colors.grey),
          //     )),
          // Container(
          //   width: 50.0,
          //   color: Colors.blue,
          //   child: Center(child: Text("WED", textAlign: TextAlign.center)),
          // ),
        ],
      ),
    );
  }

  Widget _buildTimeTableBody(List<TimeTable> timeTable1) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 10.0),
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, int index) {
            final TimeTable _tb = timeTable1[index];
            return _buildCard(_tb);
          },
//          separatorBuilder: (context, index) => Divider(),
          itemCount: timeTable1.length),
    );
  }

  Widget _buildFailed(context, Failure failed) {
    return Center(
        child: MyErrorData(
      errorMsg: failed.responseMessage,
      subtitle: "",
    ));
  }

  Widget _buildCurrentDate() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[Text("${_currentDate}")],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("Time Table"),
        actions: <Widget>[
          Checkbox(
              value: hasCollapse,
              checkColor: Colors.black87,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  hasCollapse = value;
                });
              })
        ],
      ),
      body: SafeArea(
          top: false,
          bottom: false,
          child: FutureMania(
            future: _futureTimeTable,
            onError: _buildFailed,
            onFailed: _buildFailed,
            onSuccess: (context, List<TimeTable> timeTables) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    MyUserInfo(),
                    _buildCurrentDate(),
                    SizedBox(
                      height: minValue * 1,
                    ),
                    _buildDays(timeTables),
                    _timeTable1 == null
                        ? Container()
                        : _buildTimeTableBody(_timeTable1!),
                    // _buildCard(timeTables[])
                  ],
                ),
              );
            },
          )),
    );
  }
}
