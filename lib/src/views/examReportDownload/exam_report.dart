import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/widgets/error_data.dart';
import 'package:greycell_app/src/commons/widgets/loader.dart';
import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/examReportModel/exam_report_model.dart';
import 'package:greycell_app/src/views/observer/future_observer.dart';
import 'package:url_launcher/url_launcher.dart';

class MyExamReport extends StatefulWidget {
  final MainModel model;
  final bool isDashboard;

  MyExamReport({required this.model, this.isDashboard = false});

  @override
  _MyExamReportState createState() => _MyExamReportState();
}

class _MyExamReportState extends State<MyExamReport> {
  double minValue = 8.0;

  ExamReport? _examReport;
  Future<ExamReport?>? _myExamReport;

  ExamReportsList? _examReportsList;
  Future<ExamReportsList?>? _myExamReportsList;

  ReportCard? _reportCard;
  Future<ReportCard?>? _myReportCard;

  List<AvailTerm>? availTermList = [];
  List<ExamList>? examList = [];

  bool isLoading = false;

  String? _selectedValue = "";
  ExamList? _selectedEValue;
  ExamList? _examList;
  ExamList? _examListData = null;
  String? _batAcademicSessionId = "";

  void _onCreate() async {
    availTermList = [];
    examList = [];
    _myExamReport = widget.model.getAvailTermVector();
    _examReport = await _myExamReport;

    availTermList = _examReport!.availTerm;
    _selectedValue = _examReport!.availTerm![0].availTermId;

    _myExamReportsList =
        widget.model.myExamReportsList(batAcademicSessionId: _selectedValue);
    _examReportsList = await _myExamReportsList;
    examList = _examReportsList!.getExamListVector;
    _selectedEValue = _examReportsList!.getExamListVector![0];

    _myReportCard = widget.model.myReportCardDtl(
        cmbcourse: _examReportsList!.getCourse,
        cmbBatch: _examReportsList!.getBatchId,
        cmbBatchName: _examReportsList!.getBatch,
        cmbDiscipline: _examReportsList!.getDisciplineId,
        cmbDisciplineName: _examReportsList!.getDiscipline,
        cmbBchAcdmcSession: _examReportsList!.getBchAcdmcSesnId,
        cmbBchAcdmcSessionName: _examReportsList!.getBchAcdmcSesnName,
        cmbSection: _examReportsList!.getSectionId,
        cmbSectionName: _examReportsList!.getSection,
        cmbReportPurpose: _selectedEValue!.cmbReportPurpose,
        cmbReportFormat: _selectedEValue!.cmbReportFormat,
        cmbReportFormatName: _selectedEValue!.cmbReportFormatName,
        cmbExamTerm: _selectedEValue!.cmbExamTerm,
        cmbExam: _selectedEValue!.cmbExam,
        cmbExamName: _selectedEValue!.cmbExamName,
        hdnSelectedStdnArr: _examReportsList!.getStudentId,
        hdnSelectedStdnRegdNoArr: _examReportsList!.getRollNo,
        hdnSelectedStdnNameArr: _examReportsList!.getStudentName);
    _reportCard = await _myReportCard;

    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  void _onCreate1() async {
    examList = [];
    _reportCard = null;
    print(_selectedValue);
    print(_batAcademicSessionId);
    _myExamReportsList = widget.model
        .myExamReportsList(batAcademicSessionId: _batAcademicSessionId);
    _examReportsList = await _myExamReportsList;
    examList = _examReportsList!.getExamListVector;
    _selectedEValue = examList![0];

    _myReportCard = widget.model.myReportCardDtl(
        cmbcourse: _examReportsList!.getCourse,
        cmbBatch: _examReportsList!.getBatchId,
        cmbBatchName: _examReportsList!.getBatch,
        cmbDiscipline: _examReportsList!.getDisciplineId,
        cmbDisciplineName: _examReportsList!.getDiscipline,
        cmbBchAcdmcSession: _examReportsList!.getBchAcdmcSesnId,
        cmbBchAcdmcSessionName: _examReportsList!.getBchAcdmcSesnName,
        cmbSection: _examReportsList!.getSectionId,
        cmbSectionName: _examReportsList!.getSection,
        cmbReportPurpose: _selectedEValue!.cmbReportPurpose,
        cmbReportFormat: _selectedEValue!.cmbReportFormat,
        cmbReportFormatName: _selectedEValue!.cmbReportFormatName,
        cmbExamTerm: _selectedEValue!.cmbExamTerm,
        cmbExam: _selectedEValue!.cmbExam,
        cmbExamName: _selectedEValue!.cmbExamName,
        hdnSelectedStdnArr: _examReportsList!.getStudentId,
        hdnSelectedStdnRegdNoArr: _examReportsList!.getRollNo,
        hdnSelectedStdnNameArr: _examReportsList!.getStudentName);
    _reportCard = await _myReportCard;

    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  void _onCreate2() async {
    print(_selectedEValue!.myReportConfigId);
    print(_examListData!.myReportConfigId);
    _myReportCard = widget.model.myReportCardDtl(
        cmbcourse: _examReportsList!.getCourse,
        cmbBatch: _examReportsList!.getBatchId,
        cmbBatchName: _examReportsList!.getBatch,
        cmbDiscipline: _examReportsList!.getDisciplineId,
        cmbDisciplineName: _examReportsList!.getDiscipline,
        cmbBchAcdmcSession: _examReportsList!.getBchAcdmcSesnId,
        cmbBchAcdmcSessionName: _examReportsList!.getBchAcdmcSesnName,
        cmbSection: _examReportsList!.getSectionId,
        cmbSectionName: _examReportsList!.getSection,
        cmbReportPurpose: _selectedEValue!.cmbReportPurpose,
        cmbReportFormat: _selectedEValue!.cmbReportFormat,
        cmbReportFormatName: _selectedEValue!.cmbReportFormatName,
        cmbExamTerm: _selectedEValue!.cmbExamTerm,
        cmbExam: _selectedEValue!.cmbExam,
        cmbExamName: _selectedEValue!.cmbExamName,
        hdnSelectedStdnArr: _examReportsList!.getStudentId,
        hdnSelectedStdnRegdNoArr: _examReportsList!.getRollNo,
        hdnSelectedStdnNameArr: _examReportsList!.getStudentName);
    _reportCard = await _myReportCard;
    print(_reportCard!.getReportFilePath);
    _launchURL(_reportCard!.getReportFilePath);
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
  }

  @override
  void initState() {
    super.initState();
    _onCreate();
  }

  Widget _buildBody() {
    final hedS = Theme.of(context)
        .textTheme
        .headlineMedium!
        .apply(color: Colors.blueGrey);
    return Container(
      child: ListView(
        children: <Widget>[
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
                    "Available Term:",
                    style: hedS,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DropdownButton<String>(
                    value: _selectedValue,
                    items: availTermList!
                        .map((data) => DropdownMenuItem<String>(
                              child: Text(data.availTermName!),
                              value: data.availTermId,
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedValue = value;
                        _batAcademicSessionId = _selectedValue;
                        _onCreate1();
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
                    "Report:",
                    style: hedS,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // DropdownButton<ExamList>(
                  //   value: _selectedEValue,
                  //   items: examList
                  //       .map((data) => DropdownMenuItem<ExamList>(
                  //             child: Text(data.studentReportDisplay),
                  //             value: data,
                  //           ))
                  //       .toList(),
                  //   onChanged: (ExamList value) {
                  //     setState(() {
                  //       _selectedEValue = value;
                  //       _examListData = _selectedEValue;
                  //       _onCreate2();
                  //     });
                  //   },
                  // )
                ],
              ),
            ],
          ),
          SizedBox(
            height: minValue * 3,
          ),
          SizedBox(
            height: 400,
            child: ListView.builder(
                itemCount: examList!.length,
                itemBuilder: (BuildContext context, int index) {
                  var srd = examList![index].studentReportDisplay;
                  return ListTile(
                      leading: const Icon(Icons.cloud_download),
                      trailing: const Text(
                        "Download",
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      ),
                      title: Text("$srd"),
                      onTap: () {
                        setState(() {
                          _selectedEValue = examList![index];
                          _examListData = _selectedEValue;
                          _onCreate2();
                        });
                        print("Working Fine $index");
                      });
                }),
          ),
          // Visibility(
          //   child: _reportCard == null
          //       ? Container()
          //       : RaisedButton(
          //           onPressed: () =>
          //               {_launchURL(_reportCard.getReportFilePath)},
          //           child: Text("Download Exam Report")),
          //   visible: true,
          // ),
        ],
      ),
    );
  }

  _launchURL(path) async {
    String url = path;
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildGraphCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: minValue),
      child: _buildBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isDashboard
          ? null
          : AppBar(
              title: Text("Exam Report"),
            ),
      body: isLoading
          ? Loader()
          : FutureObserver<ExamReport?>(
              future: _myExamReport,
              onWaiting: (context) {
                return Loader();
              },
              onSuccess: (context, ExamReport exam) {
                if (exam == null) {
                  return Container(
                    child: MyErrorData(
                      onReload: () => null,
                    ),
                  );
                } else
                  return _buildGraphCard();

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
