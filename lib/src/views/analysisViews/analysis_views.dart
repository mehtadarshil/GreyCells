import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/actions/dialog_handler.dart';
import 'package:greycell_app/src/commons/widgets/error_data.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/analysis/available_term.dart';
import 'package:greycell_app/src/models/analysis/subject_mark.dart';
import 'package:greycell_app/src/models/analysis/termwise_exam.dart';
import 'package:greycell_app/src/views/analysisViews/available_session.dart';
import 'package:greycell_app/src/views/analysisViews/exam_list.dart';
import 'package:greycell_app/src/views/analysisViews/mark_content.dart';
import 'package:greycell_app/src/views/analysisViews/report_header.dart';
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
    print('i am hear');
    _futureDataSet = widget.model.getAvailSession();
    _dataSet = (await _futureDataSet)!;
    dataHandler(_dataSet);
    print(_availableSessionList);
  }

  void dataHandler(List<dynamic> data) {
    /// DataSet Like [List<AvailableSession>, List<Exam>, List<SubjectMark>]
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
    print(
        "Session Testing Data: ${_availableSessionList![index].sessionId! + " " + _availableSessionList![index].sessionName! + " "}");
    final AvailableSession _selectedSession = _availableSessionList![index];
    // Updating Current Session Index State
    widget.model.onSessionChanged(index);

    // Change Current Session Stste
    // Fetch Data from Server
    // print("_selectedSession.sessionId: $_selectedSession.sessionId");
    final List<Exam> _result =
        (await widget.model.getExamList(sessionId: _selectedSession.sessionId))!;
    Navigator.of(context).pop();

    // Extract First Index Data
    final Exam _e = _result[0];
    await widget.model
        .getSubjectMarks(_e.sessionExamId, _e.examId, examName: _e.examName);
    // Update Exam list Data to Index 0 => Default Active
    widget.model.onExamChanged(0);
    _examList = _result;
    // setState(() {
    //   _classCurrentIndex = index;
    // });
  }

  void _onExamDataChange(int index) async {
    // final AvailableSession _selectedSession = _availableSessionList[index];
    // final List<Exam> _examList =
    // await widget.model.getExamList(sessionId: _selectedSession.sessionId);

    _examCurrentIndex = index;
    print("Exam Data: $index");
    // print(
    //     "Exam Testing Data: ${_examList[index].examId + " " + _examList[index].sessionName + " " + _examList[index].sessionExamId}");
    final Exam _selectedExam = _examList[index];

    /// Updating CurrentExamIndex To Index Value
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

  @override
  Widget build(BuildContext context) {
    final headerS =
        Theme.of(context).textTheme.titleMedium!.apply(color: Colors.grey[700]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Result Analysis"),
        elevation: 1.0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + minValue),
          child: MyExamList(
            onChanged: _onExamDataChange,
          ),
        ),
        actions: <Widget>[
//          MyDownloadResult(),
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
          print("DataSets: $dataList");
          if (dataList[0] == null && dataList[1] == null && dataList[2] == null)
            return MyErrorData();
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
//                      height: 450.0,
                      padding: EdgeInsets.only(bottom: minValue),
                      child: MyTermExams(
                        onRetry: () => _onExamDataChange(_examCurrentIndex),
                      ),
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
