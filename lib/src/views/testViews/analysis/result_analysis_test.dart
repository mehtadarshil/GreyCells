import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/actions/dialog_handler.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/analysis/available_term.dart';
import 'package:greycell_app/src/models/analysis/subject_mark.dart';
import 'package:greycell_app/src/models/analysis/termwise_exam.dart';
import 'package:greycell_app/src/views/analysisViews/available_session.dart';
import 'package:greycell_app/src/views/analysisViews/exam_list.dart';
import 'package:greycell_app/src/views/analysisViews/mark_content.dart';
import 'package:greycell_app/src/views/analysisViews/report_header.dart';
import 'package:greycell_app/src/views/chartViews/horizontal_chart.dart';
import 'package:greycell_app/src/views/observer/future_observer.dart';

class MyAnalysisViews extends StatefulWidget {
  final MainModel model;

  MyAnalysisViews({required this.model});

  @override
  _MyAnalysisViewsState createState() => _MyAnalysisViewsState();
}

class _MyAnalysisViewsState extends State<MyAnalysisViews> {
  double minValue = 8.0;

//  Future<List<AvailableSession>> _futureAvailableSessionList;
  Future<List<dynamic>>? _futureDataSet;
  late List<dynamic> _dataSet;
  late List<Exam> _examList;
  List<SubjectMark>? _markList;
  List<AvailableSession>? _availableSessionList;

  // Exam

  String? _currentSessionId;

  // Index
  int _classCurrentIndex = 0;
  int _examCurrentIndex = 0;
  int _markCurrentIndex = 0;

  void _onCreated() async {
//    Dial
    _futureDataSet = widget.model.getAvailSession();
    _dataSet = (await _futureDataSet)!;
    dataHandler(_dataSet);
    print(_availableSessionList);
  }

  void dataHandler(List<dynamic> data) {
    final _zero = data[0];
    final _one = data[1];
    final _two = data[2];
    if (_zero != null) {
      _availableSessionList = _zero;
    }
    if (_one != null) {
      _examList = _one;
    }
    if (_two != null) {
      _markList = _two;
    }
  }

  void _onSessionDataChange(int index) async {
    print("Session: $index");
    DialogHandler.showMyLoader(context: context);
    final AvailableSession _selectedSession = _availableSessionList![index];
    // Updating State
    widget.model.onSessionChanged(index);
    // Fetch Data from Server
    final List<Exam> _result = (await widget.model
        .getExamList(sessionId: _selectedSession.sessionId))!;
    Navigator.of(context).pop();

    // Extract First Index Data
    final Exam _e = _result[0];
    await widget.model
        .getSubjectMarks(_e.sessionExamId, _e.examId, examName: _e.examName);
    // Update Exam list Data to Index 0 => Default Active
    widget.model.onExamChanged(0);

//    setState(() {
//      _classCurrentIndex = index;
//    });
  }

  void _onExamDataChange(int index) async {
    print("Exam Data: $index");
    final Exam _selectedExam = _examList[index];
    widget.model.onExamChanged(index);
    final List<SubjectMark>? _result = await widget.model.getSubjectMarks(
        _selectedExam.sessionExamId, _selectedExam.examId,
        examName: _selectedExam.examName);
  }

  void _makeDownLoad() {}

  @override
  void initState() {
    super.initState();

    _onCreated();
  }

  Widget _buildHeader() {
    final style = Theme.of(context)
        .textTheme
        .titleMedium!
        .apply(color: Colors.blueGrey[700], fontWeightDelta: 1);
    return Container(
      padding:
          EdgeInsets.only(top: minValue, left: minValue * 2, bottom: minValue),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Result Report",
            style: style,
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.get_app),
                onPressed: () => null,
                color: Colors.blueGrey[700],
                tooltip: "Download the report",
              ),
              SizedBox(
                width: minValue,
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final headerS =
        Theme.of(context).textTheme.titleMedium!.apply(color: Colors.grey[700]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Result Analysis"),
//        bottom: PreferredSize(
//          preferredSize: Size.fromHeight(kToolbarHeight),
//          child: MyExamList(
//            onChanged: _onExamDataChange,
//          ),
//        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.get_app),
            onPressed: () => null,
            tooltip: "Download the report",
          ),
          SizedBox(
            width: minValue,
          )
        ],
      ),
//      appBar: MyAppbar(
//        emptyTheme: true,
//        onLeadingTapped: () => Navigator.of(context).pop(),
//      ),
      body: FutureObserver(
        future: _futureDataSet,
        onSuccess: (context, List<dynamic> dataList) {
          dataHandler(dataList);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
//                    _buildHeader(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: minValue * 2, horizontal: minValue),
                      child: MyReportHeader(),
                    ),
                    Container(
//                color: Colors.redAccent,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(minValue * 4),
                              topLeft: Radius.circular(minValue * 4))),
                      padding:
                          EdgeInsets.only(left: minValue, bottom: minValue),
                      child: MyExamList(
                        onChanged: _onExamDataChange,
                      ),
                    ),

                    Container(
                        height: 450.0,
                        color: Colors.grey[100],
                        padding: EdgeInsets.only(bottom: minValue),
                        child: HorizontalBarLabelChart(
                          model: widget.model,
                        )),
                    Container(
//                      height: 450.0,
                      padding: EdgeInsets.only(bottom: minValue),
                      child: MyTermExams(),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: MyAvailableSession(
                  sessionList: _availableSessionList,
                  onChanged: _onSessionDataChange,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
