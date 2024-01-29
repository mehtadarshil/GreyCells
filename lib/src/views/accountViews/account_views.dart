import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/themes/textstyle.dart';
import 'package:greycell_app/src/commons/widgets/not_found.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/payment/due_detail.dart';
import 'package:greycell_app/src/models/response/failure.dart';
import 'package:greycell_app/src/models/response/response.dart';
import 'package:greycell_app/src/views/accountViews/account_header.dart';
import 'package:greycell_app/src/views/accountViews/due_fee.dart';
import 'package:greycell_app/src/views/accountViews/pay_option.dart';
import 'package:greycell_app/src/views/observer/future_mania.dart';
import 'package:greycell_app/src/views/paymentViews/payment_screen.dart';
import 'package:greycell_app/src/views/receipt_views/receipt_list_view.dart';
import 'package:scoped_model/scoped_model.dart';

class MyAccountViews extends StatefulWidget {
  final MainModel model;

  MyAccountViews({required this.model});

  @override
  _MyAccountViewsState createState() => _MyAccountViewsState();
}

class _MyAccountViewsState extends State<MyAccountViews> {
  Future<ResponseMania?>? _futureResponse;
  double minValue = 8.0;

  void _onCreate() async {
    _futureResponse = widget.model.getAccountDueDetail();
  }

  @override
  void initState() {
    super.initState();
    _onCreate();
  }

  void _onPayOptionSelected(List selectedGateWay, DueDetail dueDetail) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PaymentScreen(
                  dueDetail: dueDetail,
                )));
  }

  Widget _buildFinalAmount(DueDetail dueDetail) {
    return ScopedModelDescendant(builder: (_, __, MainModel model) {
      return dueDetail.getPayAmtFrom == 'FA'
          ? Container(
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
                      "₹${dueDetail.getFromFaNetPay}",
                      style: CustomTextStyle(context).headline6,
                    ),
                  ),
                ],
              ),
            )
          : Container();
    });
  }

  Widget _buildBody(DueDetail dueDetail) {
    return ListView(
      children: <Widget>[
        MyAccountInfoHeader(
          dueDetail: dueDetail,
        ),
        MyPaymentDue(
          dueList: dueDetail.getFeeColVector,
        ),
        MyOnlinePayOption(
            dueDetail: dueDetail,
            onSelected: (List gateway) =>
                _onPayOptionSelected(gateway, dueDetail)),
        _buildFinalAmount(dueDetail),
        // MyPaymentFeeType(
        //   feeTypes: dueDetail.getFeeSchTypesVec,
        // ),

        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accounts"),
        actions: [
          ButtonBar(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReceiptListView(
                            mainModel: widget.model,
                          ),
                        ));
                  },
                  icon: Icon(Icons.receipt_long_rounded))
            ],
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: FutureMania(
        future: _futureResponse,
        onFailed: (context, Failure failed) {
          return Center(
              child: MyNotFound(
            title: "No Data Available",
            onRetry: _onCreate,
          ));
        },
        onError: (context, Failure failed) {
          return Center(
              child: MyNotFound(
            title: "${failed.responseMessage}",
            subtitle: "Check your internet connectivity",
          ));
        },
        onSuccess: (context, DueDetail dueDetail) {
          return _buildBody(dueDetail);
        },
      ),
    );
  }
}
