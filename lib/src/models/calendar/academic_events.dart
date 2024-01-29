class AcademicEvent {
  String? monthDate;
  String? dayDate;
  DateTime? dateTime;
  String? eventName;

  AcademicEvent({this.monthDate, this.dayDate, this.dateTime, this.eventName});

  String _toDateTypeFormat(String dateStr) {
//    print("Before Convert: $dateStr");
    final String _d = dateStr.substring(0, 2);
    final String _m = dateStr.substring(3, 5);
    final String _y = dateStr.substring(6, dateStr.length);

//    print("After Convert: ${_y + '-' + _m + '-' + _d}");
    return "${_y + '-' + _m + '-' + _d}";
  }

  AcademicEvent.fromJson(List json) {
    monthDate = json[0];
    dayDate = json[1];
    dateTime = DateTime.parse(_toDateTypeFormat(json[2]));
    eventName = json[3];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monthDate'] = this.monthDate;
    data['dayDate'] = this.dayDate;
    data['dateTime'] = this.dateTime;
    data['eventName'] = this.eventName;
    return data;
  }
}
