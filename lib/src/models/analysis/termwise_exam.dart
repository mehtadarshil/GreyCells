class Exam {
  String? examId;
  String? sessionExamId;
  String? examName;
  String? sessionName;
  String? candidateType;
  String? examType;

  Exam(
      {this.examId,
      this.sessionExamId,
      this.examName,
      this.sessionName,
      this.candidateType,
      this.examType});

  Exam.fromJson(List json) {
    sessionExamId = json[0];
    examName = json[1];
    candidateType = json[2];
    examType = json[3];

    examId = json[4];
    sessionName = json[5];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examId'] = this.examId;
    data['sessionExamId'] = this.sessionExamId;
    data['examName'] = this.examName;
    data['sessionName'] = this.sessionName;
    data['examtType'] = this.examType;
    data[''] = this.candidateType;
    return data;
  }
}
