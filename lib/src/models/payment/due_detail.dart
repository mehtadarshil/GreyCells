import 'package:greycell_app/src/models/payment/payable_fee.dart';

class DueDetail {
  String? getPayAmtFrom;
  String? getStudName;
  String? getAcctLvlRcptReqd;
  String? getFinYear;
  String? getStdnId;
  String? getStudRegNo;
  List<List<dynamic>>? getOnlinePayOptionVector;
  List<List<dynamic>>? getFeeSchTypesVec;
  String? getPolicyValue;
  List<List<dynamic>>? getFeeColVector;
  String? getAllowFeeSchSel;
  List<PayableFee>? payableFeeDetails;
  String? getMerchantKey;
  String? getFromFaNetPay;

  DueDetail(
      {this.getPayAmtFrom,
      this.getStudName,
      this.getAcctLvlRcptReqd,
      this.getFinYear,
      this.getStdnId,
      this.getStudRegNo,
      this.getOnlinePayOptionVector,
      this.getFeeSchTypesVec,
      this.getPolicyValue,
      this.getFeeColVector,
      this.getAllowFeeSchSel,
      this.getMerchantKey,
      this.getFromFaNetPay});

  DueDetail.fromJson(Map<String, dynamic> json) {
    this.getPayAmtFrom = json['getPayAmtFrom'];
    this.getStudName = json['getStudName'];
    this.getAcctLvlRcptReqd = json['getAcctLvlRcptReqd'];
    this.getFinYear = json['getFinYear'];
    this.getStdnId = json['getStdnId'];
    this.getStudRegNo = json['getStudRegNo'];
    this.getMerchantKey = json['getMerchantKey'];
    this.getFromFaNetPay = json['getFromFaNetPay'];

    if (json['getOnlinePayOptionVector'] != null) {
      this.getOnlinePayOptionVector = <List<dynamic>>[];
      json['getOnlinePayOptionVector'].forEach((v) {
        this.getOnlinePayOptionVector!.add(v);
      });
    }
    if (json['getFeeSchTypesVec'] != null) {
      this.getFeeSchTypesVec = <List<dynamic>>[];
      json['getFeeSchTypesVec'].forEach((v) {
        this.getFeeSchTypesVec!.add(v);
      });
    }
    this.getPolicyValue = json['getPolicyValue'];
    if (json['getFeeColVector'] != null) {
      this.getFeeColVector = <List<dynamic>>[];
      json['getFeeColVector'].forEach((v) {
        this.getFeeColVector!.add(v);
      });
    }
    this.getAllowFeeSchSel = json['getAllowFeeSchSel'];
    print("json['getFeeStatusDetail']: ${json['getFeeStatusDetail']}");
    if (json['getFeeStatusDetail'] != null) {
      if (json['getFeeStatusDetail'] is String) {
        this.payableFeeDetails = _convertToList(json['getFeeStatusDetail']);
      } else {
        this.payableFeeDetails = <PayableFee>[];
        json['getFeeStatusDetail'].forEach((v) {
          this.payableFeeDetails!.add(v);
        });
      }
    } else {
      //
      if (this.getPayAmtFrom == 'FA') {
        this.payableFeeDetails = <PayableFee>[];
        payableFeeDetails!.add(PayableFee(
            id: 1,
            feeAmount: double.parse(this.getFromFaNetPay!),
            headName: "Financial account fee",
            netPayAbleAmount: double.parse(this.getFromFaNetPay!)));
      }
    }
  }

  /// Data Is Like: "Fee Head:Caution Money (Resident), Fee Amount:257000.00, Net Payable:257000.00; \nFee Head:Admission Fee, Fee Amount:82500.00, Net Payable:82500.00; \n

  List<PayableFee> _convertToList(String feeStatusDetail) {
    final _splitObjectList = feeStatusDetail.split('\n');
    final List<PayableFee> _items = <PayableFee>[];

    for (int i = 0; i < _splitObjectList.length; i++) {
      final String _object = _splitObjectList[i];
      final _splitObjectFieldList = _object.split(',');
      if (_splitObjectFieldList[0].isNotEmpty) {
        final String _headId = _splitObjectFieldList[0].split(':')[1];
        final String _headValue = _splitObjectFieldList[1].split(':')[1];
        final String _feeValue =
            _splitObjectFieldList[2].split(':')[1].trim().replaceAll(';', '');
        final String _netPayValue =
            _splitObjectFieldList[3].split(':')[1].trim().replaceAll(';', '');
        print("ksjdhksadcsan $_headValue $_feeValue $_netPayValue");
        final PayableFee _payAble = PayableFee(
            id: int.parse(_headId),
            feeAmount: double.parse(_feeValue),
            netPayAbleAmount: double.parse(_netPayValue),
            headName: _headValue);
        print("jsdsadsan  $i");
        _items.add(_payAble);
      } else {
        print("${_splitObjectFieldList.length} \n");
      }
    }
    return _items;
  }
}
