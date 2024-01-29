class Term {
  String? termName;
  List? termDataSet;
  List<TermDetails>? termDetails;

  Term ({this.termDataSet, this.termName, this.termDetails});

  Term.fromJson(Map<String, dynamic> json) {
    this.termDetails = <TermDetails>[];
    this.termName = json['termName'];
    this.termDataSet = json['termDataSet'];
    if (this.termDataSet != null) {
      json['termDataSet'].forEach((value) {
        this.termDetails!.add(TermDetails.fromJson(value));
      });
    }
  }

//  Term.getTermDetails() {
//    if()
//  }
}

class TermDetails {
  String? monthName;
  String? attendedClass;
  String? totalClass;

  TermDetails ({this.totalClass, this.attendedClass, this.monthName});

  TermDetails.fromJson(List detail) {
    this.monthName = detail[0];
    this.totalClass = detail[1];

    this.attendedClass = detail[2];
  }
}
