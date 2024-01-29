class AvailableSession {
  String? sessionId;
  String? sessionName;

  AvailableSession({this.sessionId, this.sessionName});

  AvailableSession.fromJson(List json) {
    sessionId = json[0];
    sessionName = json[1];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['termId'] = this.sessionId;
    data['termName'] = this.sessionName;
    return data;
  }
}
