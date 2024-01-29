class SubjectMark {
  String? subjectName;
  int? totalMark;
  double? securedMark;
  String? percentage;
  String? status;

  SubjectMark ({this.subjectName,
    this.totalMark,
    this.securedMark,
    this.percentage,
    this.status});

  SubjectMark.fromJson(List json) {
    subjectName = json[0];
    totalMark = int.parse(json[1]);
    securedMark = double.parse(json[2]);
    percentage = json[3];
    status = json[4];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subjectName'] = this.subjectName;
    data['totalMark'] = this.totalMark;
    data['securedMark'] = this.securedMark;
    data['percentage'] = this.percentage;
    data['status'] = this.status;
    return data;
  }
}
