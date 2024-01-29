class Staff {
  bool? isSuccess;
  String? getState;
  String? getCountry;
  String? getAadharNo;
  String? getSpouseName;
  String? getDesignationType;
  String? getDesignation;
  String? getDOBTillDateInDays;
  String? getDateOfBirth;
  String? getAddressLine3;
  String? getEmail;
  String? getGender;
  String? getFatherName;
  String? getStaffCode;
  String? getPin;
  String? getCity;
  String? getBloodGroup;
  String? getAddressLine1;
  String? getAddressLine2;
  String? getUserId;
  String? getStaffName;
  String? getDepartment;
  String? getPanNo;
  String? getMobileNo;
  String? getSalutation;
  String? getWebPhotoPath;
  String? getMaritalStatus;

  Staff(
      {this.isSuccess,
      this.getState,
      this.getCountry,
      this.getAadharNo,
      this.getSpouseName,
      this.getDesignationType,
      this.getDesignation,
      this.getDOBTillDateInDays,
      this.getDateOfBirth,
      this.getAddressLine3,
      this.getEmail,
      this.getGender,
      this.getFatherName,
      this.getStaffCode,
      this.getPin,
      this.getCity,
      this.getBloodGroup,
      this.getAddressLine1,
      this.getAddressLine2,
      this.getUserId,
      this.getStaffName,
      this.getDepartment,
      this.getPanNo,
      this.getMobileNo,
      this.getSalutation,
      this.getWebPhotoPath,
      this.getMaritalStatus});

  Staff.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    getState = json['getState'];
    getCountry = json['getCountry'];
    getAadharNo = json['getAadharNo'];
    getSpouseName = json['getSpouseName'];
    getDesignationType = json['getDesignationType'];
    getDesignation = json['getDesignation'];
    getDOBTillDateInDays = json['getDOBTillDateInDays'];
    getDateOfBirth = json['getDateOfBirth'];
    getAddressLine3 = json['getAddressLine3'];
    getEmail = json['getEmail'];
    getGender = json['getGender'];
    getFatherName = json['getFatherName'];
    getStaffCode = json['getStaffCode'];
    getPin = json['getPin'];
    getCity = json['getCity'];
    getBloodGroup = json['getBloodGroup'];
    getAddressLine1 = json['getAddressLine1'];
    getAddressLine2 = json['getAddressLine2'];
    getUserId = json['getUserId'];
    getStaffName = json['getStaffName'];
    getDepartment = json['getDepartment'];
    getPanNo = json['getPanNo'];
    getMobileNo = json['getMobileNo'];
    getSalutation = json['getSalutation'];
    getWebPhotoPath = json['getWebPhotoPath'];
    getMaritalStatus = json['getMaritalStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['getState'] = this.getState;
    data['getCountry'] = this.getCountry;
    data['getAadharNo'] = this.getAadharNo;
    data['getSpouseName'] = this.getSpouseName;
    data['getDesignationType'] = this.getDesignationType;
    data['getDesignation'] = this.getDesignation;
    data['getDOBTillDateInDays'] = this.getDOBTillDateInDays;
    data['getDateOfBirth'] = this.getDateOfBirth;
    data['getAddressLine3'] = this.getAddressLine3;
    data['getEmail'] = this.getEmail;
    data['getGender'] = this.getGender;
    data['getFatherName'] = this.getFatherName;
    data['getStaffCode'] = this.getStaffCode;
    data['getPin'] = this.getPin;
    data['getCity'] = this.getCity;
    data['getBloodGroup'] = this.getBloodGroup;
    data['getAddressLine1'] = this.getAddressLine1;
    data['getAddressLine2'] = this.getAddressLine2;
    data['getUserId'] = this.getUserId;
    data['getStaffName'] = this.getStaffName;
    data['getDepartment'] = this.getDepartment;
    data['getPanNo'] = this.getPanNo;
    data['getMobileNo'] = this.getMobileNo;
    data['getSalutation'] = this.getSalutation;
    data['getWebPhotoPath'] = this.getWebPhotoPath;
    data['getMaritalStatus'] = this.getMaritalStatus;
    return data;
  }
}
