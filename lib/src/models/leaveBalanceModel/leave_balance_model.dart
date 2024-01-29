class LeaveBalance {
  List<LeaveDetail>? leaveDetail;

  LeaveBalance({this.leaveDetail});

  LeaveBalance.fromJson(Map<String, dynamic>? json) {
    this.leaveDetail = <LeaveDetail>[];
    if (this.leaveDetail != null) {
      json!['getLeaveStatusVector'].forEach((value) {
        this.leaveDetail!.add(LeaveDetail.fromJson(value));
      });
    }
  }
}

class LeaveDetail {
  String? leaveMasterPkid;
  String? leaveName;
  String? leaveCode;
  String? maxAnnualAllowed;
  String? openingBalance;
  String? balanceLeave;
  String? leaveYear;
  String? moreTimesToAvail;
  String? leavesToBeCredited;
  String? showLeaveFlag;
  String? leaveAdjustment;
  String? leaveAvailed;

  LeaveDetail(
      {this.leaveMasterPkid,
      this.leaveName,
      this.leaveCode,
      this.maxAnnualAllowed,
      this.openingBalance,
      this.balanceLeave,
      this.leaveYear,
      this.moreTimesToAvail,
      this.leavesToBeCredited,
      this.showLeaveFlag,
      this.leaveAdjustment,
      this.leaveAvailed});

  LeaveDetail.fromJson(List detail) {
    this.leaveMasterPkid = detail[0];
    this.leaveName = detail[1];
    this.leaveCode = detail[2];
    this.maxAnnualAllowed = detail[3];
    this.openingBalance = detail[4];
    this.balanceLeave = detail[6];
    this.leaveYear = detail[7];
    this.moreTimesToAvail = detail[8];
    this.leavesToBeCredited = detail[10];
    this.showLeaveFlag = detail[11];
    this.leaveAdjustment = detail[12];
    this.leaveAvailed = detail[13];
  }
}
