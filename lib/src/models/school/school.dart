class School {
  String? schoolRank;
  String? schoolName;
  String? schoolFullName;
  String? schoolCode;
  String? schoolFirstServerAddress;
  String? schoolSecondServerAddress;
  String? schoolStatus;
  String? schoolLogo;

  School ({this.schoolLogo,
    this.schoolRank,
      this.schoolName,
      this.schoolFullName,
      this.schoolCode,
      this.schoolFirstServerAddress,
      this.schoolSecondServerAddress,
      this.schoolStatus});

  School.fromJson(Map<String, dynamic> json) {
    schoolRank = json['schoolRank'];
    schoolName = json['schoolName'];
    schoolFullName = json['schoolFullName'];
    schoolCode = json['schoolCode'];
    schoolFirstServerAddress = json['schoolFirstServerAddress'];
    schoolSecondServerAddress = json['schoolSecondServerAddress'];
    schoolStatus = json['schoolStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schoolRank'] = this.schoolRank;
    data['schoolName'] = this.schoolName;
    data['schoolFullName'] = this.schoolFullName;
    data['schoolCode'] = this.schoolCode;
    data['schoolFirstServerAddress'] = this.schoolFirstServerAddress;
    data['schoolSecondServerAddress'] = this.schoolSecondServerAddress;
    data['schoolStatus'] = this.schoolStatus;
    return data;
  }
}
