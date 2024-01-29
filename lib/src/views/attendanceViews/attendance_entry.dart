import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/actions/dialog_handler.dart';
import 'package:greycell_app/src/commons/widgets/error_data.dart';
import 'package:greycell_app/src/commons/widgets/loader.dart';
import 'package:greycell_app/src/config/data.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/attendance/attendance_model.dart';
import 'package:greycell_app/src/views/observer/future_observer.dart';

class MyAttendanceEntry extends StatefulWidget {
  final MainModel model;
  final bool isDashboard;

  MyAttendanceEntry({required this.model, this.isDashboard = false});

  @override
  _MyAttendanceEntryState createState() => _MyAttendanceEntryState();
}

class _MyAttendanceEntryState extends State<MyAttendanceEntry> {
  double minValue = 8.0;

  AttendanceEntry? _schoolScheme;
  Future<AttendanceEntry?>? _mySchoolScheme;

  List<SchoolScheme>? schoolSchemeList = [];
  List<Period>? schoolPeriodList = [];
  List<StudVector>? studVectorList = [];
  List<AttendanceType>? attendanceTypeList = [];

  SchoolPeriod? _schoolPeriod;
  Future<SchoolPeriod?>? _mySchoolPeriod;

  GetAttndCriteria? _attndCriteria;
  Future<GetAttndCriteria?>? _myAttndCriteria;

  StudentListDtl? _studentListDtl;
  Future<StudentListDtl?>? _myStudentListDtl;

  AttendStatus? _attendStatus;
  Future<AttendStatus?>? _myAttendStatus;

  AttendanceSave? _saveAttendance;
  Future<AttendanceSave?>? _mySaveAttendance;

  bool isLoading = false;

  String allPresent = "";

  String _attendnanceDate = '';
  DateTime? _attDate;
  DateTime? _currentDate;

  String getDate(DateTime dateTime) {
    if (dateTime.day > 9) {
      return dateTime.day.toString() +
          '-' +
          CustomDateTime.monthList[dateTime.month - 1]['short']
              .toString()
              .toUpperCase() +
          '-' +
          dateTime.year.toString();
    } else {
      return '0' +
          dateTime.day.toString() +
          '-' +
          CustomDateTime.monthList[dateTime.month - 1]['short']
              .toString()
              .toUpperCase() +
          '-' +
          dateTime.year.toString();
    }
  }

  String? _selectedValue = "";
  String? _selectedSPValue = "";
  String? _cmbPeriodScheme = "";
  String? _cmbTimetableId = "";
  String? _period = "";
  String? _orderBy = "";
  String hide = "true";
  String? _cmbSection = "";
  String? _subject = "";
  String? _stdTTGrpId = "";
  String? _facility = "";
  String? _hdnClassId = "";

  int? selectedRadio;

  void _onCreate() async {
    selectedRadio = 0;
    schoolSchemeList = [];
    schoolPeriodList = [];
    studVectorList = [];
    // _selectedValue = "";
    // _selectedSPValue = "";
    hide = "true";
    _mySchoolScheme =
        widget.model.getSchoolSchemeAttendance(dateOfAtdnc: _attendnanceDate);
    _schoolScheme = await _mySchoolScheme;
    if (_selectedValue == "") {
      _selectedValue = _schoolScheme!.schoolScheme![0].schoolSchemeId;
    } else {
      int aa = 0;
      for (int a = 0; a < _schoolScheme!.schoolScheme!.length; a++) {
        if (_selectedValue == _schoolScheme!.schoolScheme![a].schoolSchemeId) {
          _selectedValue = _schoolScheme!.schoolScheme![a].schoolSchemeId;
          aa++;
        }
      }
      if (aa == 0) {
        _selectedValue = _schoolScheme!.schoolScheme![0].schoolSchemeId;
      }
    }

    _orderBy = _schoolScheme!.getDefaultOrderBy;
    if (_cmbPeriodScheme == "") {
      _cmbPeriodScheme = _selectedValue;
    }
    schoolSchemeList = _schoolScheme!.schoolScheme;
    _mySchoolPeriod = widget.model.getSchoolAttendance(
        dateOfAtdnc: _attendnanceDate, cmbPeriodScheme: _cmbPeriodScheme);
    _schoolPeriod = await _mySchoolPeriod;
    if (_schoolPeriod!.getPeriod != null) {
      hide = "false";
      if (_selectedSPValue == "") {
        _selectedSPValue = _schoolPeriod!.getPeriod![0].periodId;
      } else {
        int bb = 0;
        for (int b = 0; b < _schoolPeriod!.getPeriod!.length; b++) {
          if (_selectedSPValue == _schoolPeriod!.getPeriod![b].periodId) {
            _selectedSPValue = _schoolPeriod!.getPeriod![b].periodId;
            bb++;
            print("bb: ${bb}");
          }
        }
        if (bb == 0) {
          _selectedSPValue = _schoolPeriod!.getPeriod![0].periodId;
        }
      }
      schoolPeriodList = _schoolPeriod!.getPeriod;
      _cmbTimetableId = _selectedSPValue;

      schoolSchemeList = _schoolScheme!.schoolScheme;
      _myAttndCriteria = widget.model.getAttendanceCriteria(
          dateOfAtdnc: _attendnanceDate,
          cmbPeriodScheme: _cmbPeriodScheme,
          cmbTimetableId: _cmbTimetableId);
      _attndCriteria = await _myAttndCriteria;
      _period = _attndCriteria!.getAttendanceCriteria![0].period;
      _cmbSection = _attndCriteria!.getAttendanceCriteria![0].cmbSection;
      _subject = _attndCriteria!.getAttendanceCriteria![0].batchSubjectId;
      _stdTTGrpId = _attndCriteria!.getAttendanceCriteria![0].stdTTGrpId;
      _facility = _attndCriteria!.getAttendanceCriteria![0].facility;
      _myStudentListDtl = widget.model.getAttendanceStudentList(
          cmbCriteria: _cmbTimetableId,
          dateOfAtdnc: _attendnanceDate,
          period: _period,
          orderBy: _orderBy);
      _studentListDtl = await _myStudentListDtl;
      if (_studentListDtl != null) {
        studVectorList = _studentListDtl!.getStudVector;
        _hdnClassId = _studentListDtl!.getClassId;
      } else {
        hide = "true";
      }

      // for (int a = 0; a < studVectorList.length; a++) {
      //   allPresent[a] = "1";
      // }
      _myAttendStatus = widget.model.getAttendanceStatus();
      _attendStatus = await _myAttendStatus;
      attendanceTypeList = _attendStatus!.getAttendanceType;
    }

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

    if (_schoolScheme == null) {
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
    _currentDate = DateTime.now();
    _attDate = _currentDate;
    _attendnanceDate = getDate(_currentDate!);
    _onCreate();
    selectedRadio = 0;
  }

  void openDatePicker(String type) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _currentDate!,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        _attDate = picked;
        _attendnanceDate = getDate(_attDate!);
      });
    }
    if (_attDate != null) {
      DialogHandler.showMyLoader(context: context);
      _onCreate();
      Navigator.of(context).pop();
      setState(() {});
    }
  }

  setSelectedRadio(int? val) {
    setState(() {
      selectedRadio = val;
      // allPresent = val.toString();
      for (int a = 0; a < studVectorList!.length; a++) {
        // allPresent = val.toString();
        // print("I am here........");
        studVectorList![a].attendanceTypeId = val.toString();
      }
    });
  }

  Widget _buildBody() {
    final hedS = Theme.of(context)
        .textTheme
        .headlineMedium!
        .apply(color: Colors.blueGrey);
    return Container(
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Date of Attendance",
                    style: hedS,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(minValue))),
                          backgroundColor: Colors.grey[200],
                          elevation: 0.0),
                      onPressed: () => openDatePicker('FROM'),
                      icon: Icon(
                        Icons.calendar_today,
                        size: 20,
                      ),
                      label: Container(
                        margin: EdgeInsets.all(minValue * 1.2),
                        child: Text("$_attendnanceDate"),
                      )),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "School Scheme",
                    style: hedS,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DropdownButton<String>(
                    value: _selectedValue,
                    items: schoolSchemeList!
                        .map((data) => DropdownMenuItem<String>(
                              child: Text(data.schoolSchemeName!),
                              value: data.schoolSchemeId,
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedValue = value;
                        _cmbPeriodScheme = _selectedValue;
                        _onCreate();
                      });
                    },
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "School",
                    style: hedS,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DropdownButton<String>(
                    value: _selectedSPValue,
                    items: schoolPeriodList!
                        .map((data) => DropdownMenuItem<String>(
                              child: Text(data.periodName!),
                              value: data.periodId,
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedSPValue = value;
                        _cmbTimetableId = _selectedSPValue;
                        _onCreate();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Class:",
                    style: hedS,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    hide == "true"
                        ? ""
                        : "${_attndCriteria!.getAttendanceCriteria![0].courseCode} * ${_attndCriteria!.getAttendanceCriteria![0].disciplineCode} * ${_attndCriteria!.getAttendanceCriteria![0].batch}",
                    style: hedS,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: minValue * 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Subject:",
                    style: hedS,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    hide == "true"
                        ? ""
                        : "${_attndCriteria!.getAttendanceCriteria![0].subject}",
                    style: hedS,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: minValue * 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "STUDENT NAME:",
                    style: hedS,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "ATTENDANCE",
                    style: hedS,
                  ),
                ],
              ),
            ],
          ),
          SingleChildScrollView(
              child: Container(
            height: 450,
            child: ListView.builder(
              itemCount: studVectorList!.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${studVectorList![index].studFirstName} ${studVectorList![index].studMiddleName} ${studVectorList![index].studLastName}",
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        DropdownButton<String>(
                          value: studVectorList![index].attendanceTypeId == ""
                              ? null
                              : studVectorList![index].attendanceTypeId,
                          items: attendanceTypeList!
                              .map((data) => DropdownMenuItem<String>(
                                    child: Text(data.attendanceType!),
                                    value: data.attendanceTypeId,
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              studVectorList![index].attendanceTypeId = value;
                            });
                          },
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
          )),
          FloatingActionButton.extended(
            onPressed: () async {
              // for (int i = 0; i < studVectorList.length; i++) {
              //   print("studEnrolId: ${studVectorList[i].studEnrolId}");
              //   print(
              //       "attendanceTypeId: ${studVectorList[i].attendanceTypeId}");
              // }
              if (hide == "false") {
                _mySaveAttendance = widget.model.attendSave(
                    cmbCriteria: _cmbTimetableId,
                    dateOfAtdnc: _attendnanceDate,
                    period: _period,
                    cmbSection: _cmbSection,
                    subject: _subject,
                    stdTTGrpId: _stdTTGrpId,
                    facility: _facility,
                    hdnClassId: _hdnClassId,
                    studVectorList: studVectorList);
                setState(() {
                  isLoading = true;
                });
                _saveAttendance = await _mySaveAttendance;
                if (_saveAttendance!.isSuccess!) {
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  setState(() {
                    isLoading = false;
                  });
                }
              }
            },
            icon: Icon(Icons.save),
            label: Text("Savee"),
            backgroundColor: hide == "true" ? Colors.grey : Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildStudList() {
    final hedS = Theme.of(context)
        .textTheme
        .headlineMedium!
        .apply(color: Colors.blueGrey);
    return ListView(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Class:",
                  // style: hedS,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  hide == "true"
                      ? ""
                      : "${_attndCriteria!.getAttendanceCriteria![0].courseCode} * ${_attndCriteria!.getAttendanceCriteria![0].disciplineCode} * ${_attndCriteria!.getAttendanceCriteria![0].batch}",
                  style: hedS,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: minValue * 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Subject:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  hide == "true"
                      ? ""
                      : "${_attndCriteria!.getAttendanceCriteria![0].subject}",
                  style: hedS,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: minValue * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "\nPeriod:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DropdownButton<String>(
                  value: _selectedSPValue,
                  items: schoolPeriodList!
                      .map((data) => DropdownMenuItem<String>(
                            child: Text(data.periodName!),
                            value: data.periodId,
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedSPValue = value;
                      _cmbTimetableId = _selectedSPValue;
                      _onCreate();
                    });
                  },
                )
              ],
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Mark All Present",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            Radio(
              value: 1,
              groupValue: selectedRadio,
              activeColor: Colors.green,
              onChanged: (dynamic val) {
                print("Radio $val");
                setSelectedRadio(val);
              },
            ),
            Text(
              "Mark All Absent",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            Radio(
              value: 2,
              groupValue: selectedRadio,
              activeColor: Colors.green,
              onChanged: (dynamic val) {
                print("Radio $val");
                setSelectedRadio(val);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "STUDENT NAME:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "ATTENDANCE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
              ],
            ),
          ],
        ),
        Divider(
          color: Colors.black,
        ),
        SingleChildScrollView(
            child: Container(
          height: 450,
          child: ListView.builder(
            itemCount: studVectorList!.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          "${studVectorList![index].studFirstName} ${studVectorList![index].studMiddleName} ${studVectorList![index].studLastName}",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        "Enrol ID: ${studVectorList![index].studEnrolId}",
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DropdownButton<String>(
                        value: studVectorList![index].attendanceTypeId == ""
                            ? null
                            : studVectorList![index].attendanceTypeId,
                        items: attendanceTypeList!
                            .map((data) => DropdownMenuItem<String>(
                                  child: Text(data.attendanceType!),
                                  value: data.attendanceTypeId,
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            studVectorList![index].attendanceTypeId = value;
                            // allPresent = value;
                          });
                        },
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        )),
        // FloatingActionButton.extended(
        //   onPressed: () async {
        //     // for (int i = 0; i < studVectorList.length; i++) {
        //     //   print("studEnrolId: ${studVectorList[i].studEnrolId}");
        //     //   print(
        //     //       "attendanceTypeId: ${studVectorList[i].attendanceTypeId}");
        //     // }
        //     if (hide == "false") {
        //       _mySaveAttendance = widget.model.attendSave(
        //           cmbCriteria: _cmbTimetableId,
        //           dateOfAtdnc: _attendnanceDate,
        //           period: _period,
        //           cmbSection: _cmbSection,
        //           subject: _subject,
        //           stdTTGrpId: _stdTTGrpId,
        //           facility: _facility,
        //           hdnClassId: _hdnClassId,
        //           studVectorList: studVectorList);
        //       setState(() {
        //         isLoading = true;
        //       });
        //       _saveAttendance = await _mySaveAttendance;
        //       if (_saveAttendance.isSuccess) {
        //         setState(() {
        //           isLoading = false;
        //         });
        //       } else {
        //         setState(() {
        //           isLoading = false;
        //         });
        //       }
        //     }
        //   },
        //   icon: Icon(Icons.save),
        //   label: Text("Save"),
        //   backgroundColor: hide == "true" ? Colors.grey : Colors.blue,
        // ),
      ],
    );
    // );
  }

  Widget _buildAttdEntryBody() {
    // double width = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        // height: 50.0,
        child: Column(children: <Widget>[
          Expanded(
            child: Column(children: [
              Container(
                  height: 50.0,
                  child: ListView(
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    // shrinkWrap: true,
                    // padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
                    children: <Widget>[
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(minValue))),
                              backgroundColor: Colors.grey[200],
                              elevation: 0.0),
                          onPressed: () => openDatePicker('FROM'),
                          icon: Icon(
                            Icons.calendar_today,
                            size: 20,
                          ),
                          label: Container(
                            margin: EdgeInsets.all(minValue * 1.2),
                            child: Text("$_attendnanceDate"),
                          )),
                      SizedBox(
                        width: minValue * 0.5,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(minValue))),
                              backgroundColor: Colors.grey[200],
                              elevation: 0.0),
                          onPressed: () => {},
                          icon: Icon(
                            Icons.school,
                            size: 20,
                          ),
                          label: Container(
                            margin: EdgeInsets.all(minValue * 1.2),
                            child: GestureDetector(
                              onTap: () {},
                              child: DropdownButton<String>(
                                value: _selectedValue,
                                items: schoolSchemeList!
                                    .map((data) => DropdownMenuItem<String>(
                                          child: Text(data.schoolSchemeName!),
                                          value: data.schoolSchemeId,
                                        ))
                                    .toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedValue = value;
                                    _cmbPeriodScheme = _selectedValue;
                                    _onCreate();
                                  });
                                },
                              ),
                            ),
                          )),
                      // SizedBox(
                      //   width: minValue * 0.5,
                      // ),
                      // RaisedButton.icon(
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(minValue))),
                      //     color: Colors.grey[200],
                      //     elevation: 0.0,
                      //     onPressed: () => {},
                      //     icon: Icon(
                      //       Icons.schedule,
                      //       size: 20,
                      //     ),
                      //     label: Container(
                      //       margin: EdgeInsets.all(minValue * 1.2),
                      //       child: GestureDetector(
                      //         onTap: () {},
                      //         child: DropdownButton<String>(
                      //           value: _selectedSPValue,
                      //           items: schoolPeriodList
                      //               .map((data) => DropdownMenuItem<String>(
                      //                     child: Text(data.periodName),
                      //                     value: data.periodId,
                      //                   ))
                      //               .toList(),
                      //           onChanged: (String value) {
                      //             setState(() {
                      //               _selectedSPValue = value;
                      //               _cmbTimetableId = _selectedSPValue;
                      //               _onCreate();
                      //             });
                      //           },
                      //         ),
                      //       ),
                      //     )),
                    ],
                  )),
            ]),
          ),
          Flexible(flex: 10, child: _buildStudList()),
        ]));
  }

  Widget _buildGraphCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: minValue),
      // child: _buildStudList(),
      child: _buildAttdEntryBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isDashboard
          ? null
          : AppBar(
              title: Text("Attendance Entry"),
            ),
      body: isLoading
          ? Loader()
          : FutureObserver<AttendanceEntry?>(
              future: _mySchoolScheme,
              onWaiting: (context) {
                return Loader();
              },
              onSuccess: (context, AttendanceEntry attendance) {
                if (attendance == null) {
                  return Container(
                    child: MyErrorData(
                      onReload: () => null,
                    ),
                  );
                } else                return _buildGraphCard();

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
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.save),
      //       label: 'Save',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.open_in_new_rounded),
      //       label: 'Open Dialog',
      //     ),
      //   ],
      //   currentIndex: 0,
      //   selectedItemColor: Colors.amber[800],
      //   onTap: (int index) {},
      // ),
      // bottomNavigationBar: TextButton(
      //   padding: const EdgeInsets.all(15.0),
      //   child: Text(
      //     'Save',
      //     style: TextStyle(fontSize: 20.0),
      //   ),
      //   color: Colors.blueAccent,
      //   textColor: Colors.white,
      //   onPressed: () {},
      // )
      bottomNavigationBar: FloatingActionButton.extended(
        onPressed: () async {
          // for (int i = 0; i < studVectorList.length; i++) {
          //   print("studEnrolId: ${studVectorList[i].studEnrolId}");
          //   print(
          //       "attendanceTypeId: ${studVectorList[i].attendanceTypeId}");
          // }
          if (hide == "false") {
            _mySaveAttendance = widget.model.attendSave(
                cmbCriteria: _cmbTimetableId,
                dateOfAtdnc: _attendnanceDate,
                period: _period,
                cmbSection: _cmbSection,
                subject: _subject,
                stdTTGrpId: _stdTTGrpId,
                facility: _facility,
                hdnClassId: _hdnClassId,
                studVectorList: studVectorList);
            setState(() {
              isLoading = true;
            });
            _saveAttendance = await _mySaveAttendance;
            if (_saveAttendance!.isSuccess!) {
              setState(() {
                isLoading = false;
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }
          }
        },
        icon: Icon(Icons.save),
        label: Text("Save"),
        backgroundColor: hide == "true" ? Colors.grey : Colors.blue,
      ),
    );
  }
}

class KeyValueModel {
  String? key;
  String? value;

  KeyValueModel({this.key, this.value});
}
