import 'dart:math';

class PayableFee {
  String? headName;
  double? feeAmount;
  double? netPayAbleAmount;
  int? id;

  PayableFee({this.headName, this.feeAmount, this.netPayAbleAmount, this.id});

  PayableFee.fromJson(Map<String, dynamic> json) {
    headName = json['head_name'];
    feeAmount = json['fee_amount'];
    netPayAbleAmount = json['net_pay_able_amount'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['head_name'] = this.headName;
    data['fee_amount'] = this.feeAmount;
    data['id'] = this.id;
    data['net_pay_able_amount'] = this.netPayAbleAmount;
    return data;
  }
}

List<PayableFee> get getDummyFees {
  final List<PayableFee> _fees = <PayableFee>[];
  for (int i = 0; i < 20; i++) {
    PayableFee _fee = PayableFee(
        id: i + 1,
        headName: "Dummy Head Created $i",
        feeAmount: Random().nextInt(250000).toDouble(),
        netPayAbleAmount: Random().nextInt(205000).toDouble());
    _fees.add(_fee);
  }
  return _fees;
}
