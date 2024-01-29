import 'package:greycell_app/src/models/attendance/term.dart';

class Attendance {
  List<Term>? terms;
  String? getDiscipline;
  String? getBatch;
  String? getStudentId;
  String? getCourse;
  String? getStudentName;
  String? getMinAttendance;
  String? getRollNo;

  Attendance(
      {this.terms,
      this.getDiscipline,
      this.getBatch,
      this.getStudentId,
      this.getCourse,
      this.getStudentName,
      this.getMinAttendance,
      this.getRollNo});

  Attendance.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? termsMap =
        json["getAttendanceDetailsForAllTerms"];

    if (termsMap != null) {
      terms = <Term>[];
      termsMap.forEach((key, value) {
        final Map<String, dynamic> _json = {
          "termName": key,
          "termDataSet": value
        };
        terms!.add(Term.fromJson(_json));
      });
    }
    getDiscipline = json['getDiscipline'];
    getBatch = json['getBatch'];
    getStudentId = json['getStudentId'];
    getCourse = json['getCourse'];
    getStudentName = json['getStudentName'];
    getMinAttendance = json['getMinAttendance'];
    getRollNo = json['getRollNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.terms != null) {
      data['terms'] = this.terms!.map((v) => v).toList();
    }
    data['getDiscipline'] = this.getDiscipline;
    data['getBatch'] = this.getBatch;
    data['getStudentId'] = this.getStudentId;
    data['getCourse'] = this.getCourse;
    data['getStudentName'] = this.getStudentName;
    data['getMinAttendance'] = this.getMinAttendance;
    data['getRollNo'] = this.getRollNo;
    return data;
  }
}

class AttendanceEntry {
  String? getDefaultOrderBy;
  String? getFacName;
  List<SchoolScheme>? schoolScheme;

  AttendanceEntry({this.getDefaultOrderBy, this.getFacName, this.schoolScheme});

  AttendanceEntry.fromJson(Map<String, dynamic> json) {
    this.schoolScheme = <SchoolScheme>[];
    this.getDefaultOrderBy = json['getDefaultOrderBy'];
    this.getFacName = json['getFacName'];
    if (this.schoolScheme != null) {
      json['getPeriodSchemeVector'].forEach((value) {
        this.schoolScheme!.add(SchoolScheme.fromJson(value));
      });
    }
  }
}

class SchoolScheme {
  String? schoolSchemeId;
  String? schoolSchemeName;

  SchoolScheme({this.schoolSchemeId, this.schoolSchemeName});

  SchoolScheme.fromJson(List detail) {
    this.schoolSchemeId = detail[0];
    this.schoolSchemeName = detail[1];
  }
}

class SchoolPeriod {
  List<Period>? getPeriod;

  SchoolPeriod({this.getPeriod});

  SchoolPeriod.fromJson(Map<String, dynamic> json) {
    this.getPeriod = <Period>[];
    if (json['getPeriodVector'] != null) {
      if (this.getPeriod != null) {
        json['getPeriodVector'].forEach((value) {
          this.getPeriod!.add(Period.fromJson(value));
        });
      }
    } else {
      this.getPeriod = null;
    }
  }
}

class Period {
  String? periodId;
  String? periodName;

  Period({this.periodId, this.periodName});

  Period.fromJson(List detail) {
    this.periodId = detail[0];
    this.periodName = detail[1];
  }
}

class GetAttndCriteria {
  List<AttndCriteria>? getAttendanceCriteria;

  GetAttndCriteria({this.getAttendanceCriteria});

  GetAttndCriteria.fromJson(Map<String, dynamic>? json) {
    this.getAttendanceCriteria = <AttndCriteria>[];
    if (this.getAttendanceCriteria != null) {
      json!['getAttendanceCriteria'].forEach((value) {
        this.getAttendanceCriteria!.add(AttndCriteria.fromJson(value));
      });
    }
  }
}

class AttndCriteria {
  String? criteriaId;
  String? courseCode;
  String? subject;
  String? batchSubjectId;
  String? disciplineCode;
  String? batch;
  String? period;
  String? cmbSection;
  String? stdTTGrpId;
  String? facility;

  AttndCriteria(
      {this.criteriaId,
      this.courseCode,
      this.subject,
      this.batchSubjectId,
      this.disciplineCode,
      this.batch,
      this.cmbSection,
      this.stdTTGrpId,
      this.facility,
      this.period});

  AttndCriteria.fromJson(List detail) {
    this.criteriaId = detail[0];
    this.courseCode = detail[1];
    this.subject = detail[2];
    this.batchSubjectId = detail[8];
    this.cmbSection = detail[10];
    this.stdTTGrpId = detail[11];
    this.disciplineCode = detail[13];
    this.batch = detail[14];
    this.period = detail[16];
    this.facility = detail[17];
  }
}

class StudentListDtl {
  String? getClassId;
  String? getAttndCorrAllwdForDays;
  String? getDiffAttndDays;
  List<StudVector>? getStudVector;

  StudentListDtl(
      {this.getClassId,
      this.getAttndCorrAllwdForDays,
      this.getDiffAttndDays,
      this.getStudVector});

  StudentListDtl.fromJson(Map<String, dynamic> json) {
    this.getStudVector = <StudVector>[];
    this.getClassId = json['getClassId'];
    this.getAttndCorrAllwdForDays = json['getAttndCorrAllwdForDays'];
    this.getDiffAttndDays = json['getDiffAttndDays'];
    if (this.getStudVector != null) {
      json['getStudVector'].forEach((value) {
        this.getStudVector!.add(StudVector.fromJson(value));
      });
    }
  }
}

class StudVector {
  String? studEnrolId;
  String? studFirstName;
  String? studMiddleName;
  String? studLastName;
  String? attendanceTypeId;
  String? attendanceTypeCode;

  StudVector({
    this.studEnrolId,
    this.studFirstName,
    this.studMiddleName,
    this.studLastName,
    this.attendanceTypeId,
    this.attendanceTypeCode,
  });

  StudVector.fromJson(List detail) {
    this.studEnrolId = detail[0];
    this.studFirstName = detail[2];
    this.studMiddleName = detail[3];
    this.studLastName = detail[4];
    this.attendanceTypeCode = detail[5];
    this.attendanceTypeId = detail[11];
  }
}

class AttendStatus {
  List<AttendanceType>? getAttendanceType;

  AttendStatus({this.getAttendanceType});

  AttendStatus.fromJson(Map<String, dynamic>? json) {
    this.getAttendanceType = <AttendanceType>[];
    if (this.getAttendanceType != null) {
      json!['getAttendanceTypeVector'].forEach((value) {
        this.getAttendanceType!.add(AttendanceType.fromJson(value));
      });
    }
  }
}

class AttendanceType {
  String? attendanceTypeId;
  String? attendanceType;
  String? attendanceTypeCode;
  String? absent;
  String? colorCode;
  String? autoAttnMarked;
  String? approveAbsent;
  String? otherAttendance;

  AttendanceType({
    this.attendanceTypeId,
    this.attendanceType,
    this.attendanceTypeCode,
    this.absent,
    this.colorCode,
    this.autoAttnMarked,
    this.approveAbsent,
    this.otherAttendance,
  });

  AttendanceType.fromJson(List detail) {
    this.attendanceTypeId = detail[0];
    this.attendanceType = detail[1];
    this.attendanceTypeCode = detail[2];
    this.absent = detail[3];
    this.colorCode = detail[4];
    this.autoAttnMarked = detail[5];
    this.approveAbsent = detail[6];
    this.otherAttendance = detail[7];
  }
}

class AttendanceSave {
  String? message;
  bool? isSuccess;

  AttendanceSave({this.message, this.isSuccess});

  AttendanceSave.fromJson(Map<String, dynamic> json) {
    this.message = json['message'];
    this.isSuccess = json['isSuccess'];
  }
}
