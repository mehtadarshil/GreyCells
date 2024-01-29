import 'package:flutter/material.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/payment/due_detail.dart';
import 'package:greycell_app/src/views/paymentViews/payment_body.dart';
import 'package:scoped_model/scoped_model.dart';

class PaymentScreen extends StatelessWidget {
  final DueDetail? dueDetail;

  const PaymentScreen({this.dueDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: ScopedModelDescendant(
        builder: (_, __, MainModel model) {
          return PaymentBodyView(dueDetail: dueDetail, model: model);
        },
      ),
    );
  }
}
