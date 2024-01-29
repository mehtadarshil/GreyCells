class SchoolContact {
  String? getStateName;
  String? getBranchAddress;
  String? getCityName;
  String? getMobileNo;
  String? getBranchName;
  String? getAddressLine3;
  String? getPhone1;
  String? getPhone2;
  String? getPin;
  String? getAddressLine1;
  String? getAddressLine2;

  SchoolContact ({this.getStateName,
    this.getBranchAddress,
    this.getCityName,
    this.getMobileNo,
    this.getBranchName,
    this.getAddressLine3,
    this.getPhone1,
    this.getPhone2,
    this.getPin,
    this.getAddressLine1,
    this.getAddressLine2});

  SchoolContact.fromJson(Map<String, dynamic> json) {
    getStateName = json['getStateName'];
    getBranchAddress = json['getBranchAddress'];
    getCityName = json['getCityName'];
    getMobileNo = json['getMobileNo'];
    getBranchName = json['getBranchName'];
    getAddressLine3 = json['getAddressLine3'];
    getPhone1 = json['getPhone1'];
    getPhone2 = json['getPhone2'];
    getPin = json['getPin'];
    getAddressLine1 = json['getAddressLine1'];
    getAddressLine2 = json['getAddressLine2'];
  }
}
