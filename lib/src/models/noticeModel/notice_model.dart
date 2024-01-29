class Notice {
  String? id;
  String? issuerName;
  String? date;
  String? title;
  String? message;
  String? anymous;
  String? approverName;

  Notice(
      {this.id,
        this.issuerName,
      this.date,
      this.title,
      this.message,
      this.anymous,
        this.approverName});

  Notice.fromJson(List json) {
    id = json[0];
    issuerName = json[1];
    date = json[2];
    title = json[3];
    message = json[4];
    anymous = json[5];
    approverName = json[6];
  }
}
