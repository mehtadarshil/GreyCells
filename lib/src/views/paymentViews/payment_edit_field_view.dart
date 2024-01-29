import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/themes/textstyle.dart';
import 'package:greycell_app/src/models/payment/payable_fee.dart';

class PaymentEditTextFiled {
  final PayableFee? fee;
  final TextEditingController? paymentEditController;
  final Key? key;

  PaymentEditTextFiled(
      {this.key, this.fee, this.paymentEditController, this.context});

  final BuildContext? context;

  Widget build() {
    return Container(
      height: 150.0,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Form(
              key: key,
              autovalidateMode: AutovalidateMode.always,
              child: TextFormField(
                controller: paymentEditController,
                autofocus: true,
                validator: (String? value) {
                  try {
                    final double _v = double.parse(value!);
                    if (_v > fee!.feeAmount!)
                      return "Please enter a valid amount";
                    else
                      return null;
                  } catch (e) {
                    return "Invalid input";
                  }
                },
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          Text(
            "NB: Amount can not be greater than net payable amount.",
            style: CustomTextStyle(context).caption,
          )
        ],
      ),
    );
  }
}
