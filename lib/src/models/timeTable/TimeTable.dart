class TimeTable {
  String? staffName;
  String? classRoom;
  String? day;
  String? period;
  String? classTime;
  String? subject;
  String? classType;
  String? course;
  String? discipline;
  String? batch;
  String? className;
  String? section;

  TimeTable(
      {this.staffName,
      this.classRoom,
      this.day,
      this.period,
      this.classTime,
      this.subject,
      this.classType,
      this.course,
      this.discipline,
      this.batch,
      this.className,
      this.section});

  TimeTable.fromJson(Map<String, dynamic> json) {
    staffName = json['staffName'];
    classRoom = json['classRoom'];
    day = json['day'];
    period = json['period'];
    classTime = json['classTime'];
    subject = json['subject'];
    classType = json['classType'];
    course = json['course'];
    discipline = json['discipline'];
    batch = json['batch'];
    className = json['className'];
    section = json['section'];
  }

  TimeTable.fromVector(List vector) {
    staffName = vector[0];
    classRoom = vector[1];
    day = vector[2];
    period = vector[3];
    classTime = vector[4];
    subject = vector[5];
    classType = vector[6];
    course = vector[7];
    discipline = vector[8];
    batch = vector[9];
    className = vector[10];
    section = vector[11];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staffName'] = this.staffName;
    data['classRoom'] = this.classRoom;
    data['day'] = this.day;
    data['period'] = this.period;
    data['classTime'] = this.classTime;
    data['subject'] = this.subject;
    data['classType'] = this.classType;
    data['course'] = this.course;
    data['discipline'] = this.discipline;
    data['batch'] = this.batch;
    data['className'] = this.className;
    data['section'] = this.section;
    return data;
  }
}
