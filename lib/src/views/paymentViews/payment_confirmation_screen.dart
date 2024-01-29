import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/actions/dialog_handler.dart';
import 'package:greycell_app/src/commons/themes/textstyle.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/payment/due_detail.dart';
import 'package:greycell_app/src/models/payment/payable_fee.dart';
import 'package:greycell_app/src/views/paymentViews/razorpay_payment_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final MainModel? model;
  final DueDetail? dueDetail;
  final double? totalFeeAmount;
  final double? totalPayAbleAmount;
  final List<PayableFee>? payableFees;

  PaymentConfirmationScreen(
      {Key? key,
      this.model,
      this.dueDetail,
      this.totalFeeAmount,
      this.totalPayAbleAmount,
      this.payableFees});

  List get _gateway =>
      model!.selectedGateway ?? dueDetail!.getOnlinePayOptionVector![0];

  Future<bool> _onBack(BuildContext context) async {
    await DialogHandler.onWillPopDialog(
        context: context,
        content: Container(
          child: Text("Are you sure, you want to go back?"),
        ),
        onSubmit: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });

    return false;
  }

  double get _getAmount {
    double _total = 0.0;
    payableFees!.forEach((element) {
      _total += element.netPayAbleAmount!;
    });
    return _total;
  }

  void _onMoreTap(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Total fee heads: ${payableFees!.length}",
                    style: CustomTextStyle(context)
                        .headline6!
                        .apply(color: Colors.black87),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: payableFees!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final PayableFee _fee = payableFees![index];
                        return ListTile(
                          dense: true,
                          leading: Icon(
                            Icons.category,
                            size: 18.0,
                          ),
                          subtitle:
                              Text("Payable amount: ₹${_fee.netPayAbleAmount}"),
                          title: Text(
                            "${_fee.headName}",
                            style: CustomTextStyle(context).subtitle1,
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        });
  }

  void _onConfirmToPay(BuildContext context, MainModel model) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => RazorPayPaymentScreen(
            model: model,
            amount: totalPayAbleAmount,
            dueDetail: dueDetail,
            payableFees: payableFees,
            selectedGateway: _gateway)));
  }

  Widget _buildGateWayInfo(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              "Gateway information",
              style: CustomTextStyle(context)
                  .subtitle1!
                  .apply(color: Colors.black87, fontWeightDelta: 1),
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${_gateway[1]}",
                    style: CustomTextStyle(context).button,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "${_gateway[2]}",
                    style: CustomTextStyle(context).bodyText1,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              "User information",
              style: CustomTextStyle(context)
                  .subtitle1!
                  .apply(color: Colors.black87, fontWeightDelta: 1),
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${model!.student!.fullName}",
                    style: CustomTextStyle(context).button,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "${model!.user!.getUserId}",
                    style: CustomTextStyle(context).bodyText2,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "${model!.student!.fullEmail}",
                    style: CustomTextStyle(context).bodyText2,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "${model!.student!.getMobileNo ?? model!.student!.getGuardianPhone}",
                    style: CustomTextStyle(context).bodyText2,
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    "${model!.student!.getAddress ?? model!.student!.getGuardianAddress}",
                    style: CustomTextStyle(context).bodyText2,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFinalAmount(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Final Payable Amount",
              style: CustomTextStyle(context).subtitle2,
            ),
            Flexible(
              child: Text(
                "₹${_getAmount}",
                style: CustomTextStyle(context).headline6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDueInfo(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              "Due information",
              style: CustomTextStyle(context)
                  .subtitle1!
                  .apply(color: Colors.black87, fontWeightDelta: 1),
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "${payableFees![0].headName}",
                        style: CustomTextStyle(context).button,
                      ),
                      payableFees!.length > 1
                          ? GestureDetector(
                              onTap: () => _onMoreTap(context),
                              child: Text(
                                "+${payableFees!.length - 1} more",
                                style: CustomTextStyle(context)
                                    .subtitle2!
                                    .apply(
                                        color:
                                            Theme.of(context).primaryColorDark),
                              ),
                            )
                          : Container()
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Financial year: ${dueDetail!.getFinYear}",
                    style: CustomTextStyle(context).bodyText2,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Policy: ${dueDetail!.getPolicyValue == "P" ? 'Partial' : 'Full'}",
                    style: CustomTextStyle(context).bodyText2,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "${dueDetail!.getPayAmtFrom == "FA" ? 'Full Payment' : 'FEE'}",
                    style: CustomTextStyle(context).bodyText2,
                  ),
//                  SizedBox(
//                    height: 18.0,
//                  ),
//                  Text(
//                    "${model.student.getAddress ?? model.student.getGuardianAddress}",
//                    style: CustomTextStyle(context).bodyText2,
//                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPaymentButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.blue, Theme.of(context).primaryColor])),
      child: ScopedModelDescendant(
        builder: (_, __, MainModel model) {
          return MaterialButton(
            padding: EdgeInsets.all(15.0),
            onPressed: () => _onConfirmToPay(context, model),
            child: Text(
              "Confirm to pay",
              style: CustomTextStyle(context)
                  .subtitle1!
                  .apply(color: Colors.white, fontWeightDelta: 1),
            ),
            textColor: Colors.white,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("object ${payableFees!.length}");
    return WillPopScope(
      onWillPop: () => _onBack(context),
      child: SafeArea(
        top: true,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black87,
                onPressed: () => _onBack(context)),
            title: Text(
              "Confirm payment",
              style: CustomTextStyle(context).headline6,
            ),
            backgroundColor: Colors.grey[200],
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    _buildFinalAmount(context),
                    _buildDueInfo(context),
                    _buildGateWayInfo(context),
                    _buildUserInfo(context),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildPaymentButton(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
