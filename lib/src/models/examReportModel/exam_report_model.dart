class ExamReport {
  List<AvailTerm>? availTerm;

  ExamReport({this.availTerm});

  ExamReport.fromJson(Map<String, dynamic>? json) {
    this.availTerm = <AvailTerm>[];
    if (this.availTerm != null) {
      json!['getAvailTermVector'].forEach((value) {
        this.availTerm!.add(AvailTerm.fromJson(value));
      });
    }
  }
}

class AvailTerm {
  String? availTermId;
  String? availTermName;

  AvailTerm({this.availTermId, this.availTermName});

  AvailTerm.fromJson(List detail) {
    this.availTermId = detail[0];
    this.availTermName = detail[1];
  }
}

class ExamReportsList {
  List<ExamList>? getExamListVector;
  String? getBatchId;
  String? getCourseId;
  String? getDisciplineId;
  String? getStudentName;
  String? getBatch;
  String? getDiscipline;
  String? getSectionId;
  String? getSection;
  String? getStudentId;
  String? getRollNo;
  String? getBchAcdmcSesnName;
  String? getBchAcdmcSesnId;
  String? getCourse;

  ExamReportsList({
    this.getExamListVector,
    this.getBatchId,
    this.getCourseId,
    this.getDisciplineId,
    this.getStudentName,
    this.getBatch,
    this.getDiscipline,
    this.getSectionId,
    this.getSection,
    this.getStudentId,
    this.getRollNo,
    this.getBchAcdmcSesnName,
    this.getBchAcdmcSesnId,
    this.getCourse,
  });

  ExamReportsList.fromJson(Map<String, dynamic> json) {
    this.getExamListVector = <ExamList>[];
    this.getBatchId = json['getBatchId'];
    this.getCourseId = json['getCourseId'];
    this.getDisciplineId = json['getDisciplineId'];
    this.getStudentName = json['getStudentName'];
    this.getBatch = json['getBatch'];
    this.getDiscipline = json['getDiscipline'];
    this.getSectionId = json['getSectionId'];
    this.getSection = json['getSection'];
    this.getStudentId = json['getStudentId'];
    this.getRollNo = json['getRollNo'];
    this.getBchAcdmcSesnName = json['getBchAcdmcSesnName'];
    this.getBchAcdmcSesnId = json['getBchAcdmcSesnId'];
    this.getCourse = json['getCourse'];

    if (this.getExamListVector != null) {
      json['getExamListVector'].forEach((value) {
        this.getExamListVector!.add(ExamList.fromJson(value));
      });
    }
  }
}

class ExamList {
  String? myReportConfigId;
  String? cmbReportPurpose;
  String? cmbReportFormat;
  String? cmbReportFormatName;
  String? cmbExamTerm;
  String? cmbExam;
  String? cmbExamName;
  String? studentReportDisplay;

  ExamList(
      {this.myReportConfigId,
      this.cmbReportPurpose,
      this.cmbReportFormat,
      this.cmbReportFormatName,
      this.cmbExamTerm,
      this.cmbExam,
      this.cmbExamName,
      this.studentReportDisplay});

  ExamList.fromJson(List detail) {
    this.myReportConfigId = detail[0];
    this.cmbReportPurpose = detail[4];
    this.cmbReportFormat = detail[1];
    this.cmbReportFormatName = detail[5];
    this.cmbExamTerm = detail[12];
    this.cmbExam = detail[14];
    this.cmbExamName = detail[15];
    this.studentReportDisplay = detail[19];
  }
}

class ReportCard {
  String? getTitle;
  String? getCourseId;
  String? getBatchId;
  String? getDisciplineId;
  String? getBatch;
  String? getSectionId;
  String? getReportFormatName;
  String? getReportFilePath;
  String? getExamName;
  String? getCityName;
  String? getBchAcdmcSessionName;
  String? getTitleAddress;

  ReportCard({
    this.getTitle,
    this.getCourseId,
    this.getBatchId,
    this.getDisciplineId,
    this.getBatch,
    this.getSectionId,
    this.getReportFormatName,
    this.getReportFilePath,
    this.getExamName,
    this.getCityName,
    this.getBchAcdmcSessionName,
    this.getTitleAddress,
  });

  ReportCard.fromJson(Map<String, dynamic> json) {
    this.getTitle = json['getTitle'];
    this.getCourseId = json['getCourseId'];
    this.getBatchId = json['getBatchId'];
    this.getDisciplineId = json['getDisciplineId'];
    this.getBatch = json['getBatch'];
    this.getSectionId = json['getSectionId'];
    this.getReportFormatName = json['getReportFormatName'];
    this.getReportFilePath = json['getReportFilePath'];
    this.getExamName = json['getExamName'];
    this.getCityName = json['getCityName'];
    this.getBchAcdmcSessionName = json['getBchAcdmcSessionName'];
    this.getTitleAddress = json['getTitleAddress'];
  }
}
