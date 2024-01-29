class Course {
  List<StudentBatch>? getStdnBatchDetailVector;
  List<StudentSubject>? getStdnSubjectDetailVector;

  Course({this.getStdnBatchDetailVector, this.getStdnSubjectDetailVector});

  Course.fromJson(Map<String, dynamic> json) {
    if (json['getStdnBatchDetailVector'] != null) {
      getStdnBatchDetailVector = <StudentBatch>[];
      json['getStdnBatchDetailVector'].forEach((v) {
        getStdnBatchDetailVector!.add(new StudentBatch.fromJson(v));
      });
    }
    if (json['getStdnSubjectDetailVector'] != null) {
      getStdnSubjectDetailVector = <StudentSubject>[];
      json['getStdnSubjectDetailVector'].forEach((v) {
        getStdnSubjectDetailVector!.add(new StudentSubject.fromJson(v));
      });
    }
  }
}

class StudentBatch {
  String? id;
  String? course;
  String? discipline;
  String? batch;
  String? term;

  StudentBatch({this.id, this.course, this.discipline, this.batch, this.term});

  StudentBatch.fromJson(List json) {
    id = json[0];
    course = json[1];
    discipline = json[2];
    batch = json[3];
    term = json[4];
  }
}

class StudentSubject {
  String? subjectName;
  String? subjectCode;

  StudentSubject({this.subjectName, this.subjectCode});

  StudentSubject.fromJson(List json) {
    subjectName = json[0];
    subjectCode = json[1];
  }
}
