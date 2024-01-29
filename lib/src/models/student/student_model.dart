class Student {
  String? getAddress;
  String? getRegistrationNo;
  String? getMotherName;
  String? getMobileNo;
  String? getEmailDomainId;
  String? getFatherName;
  String? getStudentId;
  String? getLastName;
  String? getEmail;
  String? getFirstName;
  int? getGrdIntCurr;
  String? getCurrentAcademicSession;
  String? getGuardianPhone;
  String? getPersonalEmail;
  String? getGuardianAddress;
  String? getGuardianEmail;
  String? getGuardianMobile;
  String? getUserId;
  String? getDateOfBirth;
  String? getMiddleName;
  String? getWebPhotoPath;
  String? getPersonalEmailDomainId;
  String? getSemStartDate;
  String? getSemEndDate;

  Student(
      {this.getAddress,
      this.getRegistrationNo,
      this.getMotherName,
      this.getMobileNo,
      this.getEmailDomainId,
      this.getFatherName,
      this.getStudentId,
      this.getLastName,
      this.getEmail,
      this.getFirstName,
      this.getGrdIntCurr,
      this.getCurrentAcademicSession,
      this.getGuardianPhone,
      this.getPersonalEmail,
      this.getGuardianAddress,
      this.getGuardianEmail,
      this.getGuardianMobile,
      this.getUserId,
      this.getDateOfBirth,
      this.getMiddleName,
      this.getWebPhotoPath,
      this.getSemStartDate,
      this.getSemEndDate,
      this.getPersonalEmailDomainId});

  String get fullName =>
      this.getFirstName! +
      (this.getMiddleName!.trim().isNotEmpty
          ? (' ' + this.getMiddleName!)
          : "") +
      (this.getLastName!.trim().isNotEmpty ? (' ' + this.getLastName!) : "");

  String get fullEmail => this.getEmail! + '@' + this.getPersonalEmailDomainId!;

  Student.fromJson(Map<String, dynamic> json) {
    getAddress = json['getAddress'];
    getRegistrationNo = json['getRegistrationNo'];
    getMotherName = json['getMotherName'];
    getMobileNo = json['getMobileNo'];
    getEmailDomainId = json['getEmailDomainId'];
    getFatherName = json['getFatherName'];
    getStudentId = json['getStudentId'];
    getLastName = json['getLastName'];
    getEmail = json['getEmail'];
    getFirstName = json['getFirstName'];
    getGrdIntCurr = json['getGrdIntCurr'];
    getCurrentAcademicSession = json['getCurrentAcademicSession'];
    getGuardianPhone = json['getGuardianPhone'];
    getPersonalEmail = json['getPersonalEmail'];
    getGuardianAddress = json['getGuardianAddress'];
    getGuardianEmail = json['getGuardianEmail'];
    getGuardianMobile = json['getGuardianMobile'];
    getUserId = json['getUserId'];
    getDateOfBirth = json['getDateOfBirth'];
    getMiddleName = json['getMiddleName'];
    getWebPhotoPath = json['getWebPhotoPath'];
    getPersonalEmailDomainId = json['getPersonalEmailDomainId'];
    getSemStartDate = json['getSemStartDate'];
    getSemEndDate = json['getSemEndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getAddress'] = this.getAddress;
    data['getRegistrationNo'] = this.getRegistrationNo;
    data['getMotherName'] = this.getMotherName;
    data['getMobileNo'] = this.getMobileNo;
    data['getEmailDomainId'] = this.getEmailDomainId;
    data['getFatherName'] = this.getFatherName;
    data['getStudentId'] = this.getStudentId;
    data['getLastName'] = this.getLastName;
    data['getEmail'] = this.getEmail;
    data['getFirstName'] = this.getFirstName;
    data['getGrdIntCurr'] = this.getGrdIntCurr;
    data['getCurrentAcademicSession'] = this.getCurrentAcademicSession;
    data['getGuardianPhone'] = this.getGuardianPhone;
    data['getPersonalEmail'] = this.getPersonalEmail;
    data['getGuardianAddress'] = this.getGuardianAddress;
    data['getGuardianEmail'] = this.getGuardianEmail;
    data['getGuardianMobile'] = this.getGuardianMobile;
    data['getUserId'] = this.getUserId;
    data['getDateOfBirth'] = this.getDateOfBirth;
    data['getMiddleName'] = this.getMiddleName;
    data['getWebPhotoPath'] = this.getWebPhotoPath;
    data['getPersonalEmailDomainId'] = this.getPersonalEmailDomainId;
    data['getSemStartDate'] = this.getSemStartDate;
    data['getSemEndDate'] = this.getSemEndDate;
    return data;
  }
}
