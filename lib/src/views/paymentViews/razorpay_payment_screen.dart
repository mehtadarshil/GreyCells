import 'package:flutter/material.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/payment/due_detail.dart';
import 'package:greycell_app/src/models/payment/payable_fee.dart';
import 'package:greycell_app/src/models/payment/payment_message.dart';
import 'package:greycell_app/src/models/response/success.dart';
import 'package:greycell_app/src/views/paymentViews/payment_result.dart';
import 'package:http/http.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayPaymentScreen extends StatefulWidget {
  const RazorPayPaymentScreen(
      {Key? key,
      required this.model,
      this.payableFees,
      this.dueDetail,
      this.amount,
      this.selectedGateway})
      : super(key: key);

  final MainModel model;
  final List<PayableFee>? payableFees;
  final DueDetail? dueDetail;
  final double? amount;
  final List? selectedGateway;

  @override
  State<RazorPayPaymentScreen> createState() => _RazorPayPaymentScreenState();
}

class _RazorPayPaymentScreenState extends State<RazorPayPaymentScreen> {
  final Razorpay _razorpay = Razorpay();
  PaymentMessage? paymentMessage;

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getOrderDetails();
    super.initState();
  }

  void getOrderDetails() async {
    var _responseMania = await widget.model.getTransactionDetails(
      amount: widget.amount.toString(),
      dueDetail: widget.dueDetail!,
      payableFee: widget.payableFees!,
      gatewayCode: widget.selectedGateway![2],
      student: widget.model.student,
    );

    if (_responseMania is Success) {
      final Success<PaymentMessage> _data =
          _responseMania as Success<PaymentMessage>;
      openRazorpayOrder(_data.success!);
      paymentMessage = _data.success;
    }
  }

  void openRazorpayOrder(PaymentMessage data) {
    var options = {
      'key': data.getMessageString!.key,
      'amount': widget.amount, //in the smallest currency sub-unit.
      'name': widget.dueDetail!.getStudName,
      'order_id': data.getMessageString!.orderId,
      'timeout': 120, // in seconds
    };
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    _razorpay.clear();
    if (paymentMessage != null) {
      Map<String, dynamic> additionalData = {
        'razorpay_order_id': response.orderId,
        'razorpay_signature': response.signature,
        'razorpay_payment_id': response.paymentId
        // Add more data as needed
      };
      print("additional data $additionalData");
      try {
        var callbackRes = await post(
            Uri.parse(paymentMessage!.getMessageString!.callbackUrl!),
            body: additionalData);
        print("callback ${callbackRes.body}");
      } catch (e) {}
    }
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentResult(
              isSuccess: true, data: response, mainModel: widget.model),
        ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _razorpay.clear();
    widget.model.selectedPayableFees = [];
    widget.model.totalPayableAmount = 0.0;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentResult(
            isSuccess: false,
            mainModel: widget.model,
          ),
        ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
