import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/widgets/error_data.dart';
import 'package:greycell_app/src/commons/widgets/loader.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/payment/due_detail.dart';
import 'package:greycell_app/src/models/payment/payable_fee.dart';
import 'package:greycell_app/src/models/payment/payment_message.dart';
import 'package:greycell_app/src/models/response/failure.dart';
import 'package:greycell_app/src/models/response/response.dart';
import 'package:greycell_app/src/models/response/success.dart';
import 'package:greycell_app/src/views/observer/future_mania.dart';
import 'package:greycell_app/src/views/webViews/payment_webview_2.dart';
import 'package:scoped_model/scoped_model.dart';

class GenerateIdScreen extends StatefulWidget {
  final MainModel model;
  final List<PayableFee>? payableFees;
  final DueDetail? dueDetail;
  final double? amount;
  final List? selectedGateway;

  GenerateIdScreen(
      {required this.model,
      this.payableFees,
      this.dueDetail,
      this.amount,
      this.selectedGateway});

  @override
  _GenerateIdScreenState createState() => _GenerateIdScreenState();
}

class _GenerateIdScreenState extends State<GenerateIdScreen> {
  Future<ResponseMania?>? _futureResult;
  ResponseMania? _responseMania;
  Map<String, dynamic>? _dataSet;

  String _title = "Creating Transaction";

  void _onCreated() async {
    _futureResult = widget.model.getTransactionDetails(
        amount: widget.amount.toString(),
        gatewayCode: widget.selectedGateway![2],
        student: widget.model.student,
        payableFee: widget.payableFees!,
        dueDetail: widget.dueDetail!);
    _responseMania = await _futureResult;

    if (_responseMania is Success) {
      final Success<PaymentMessage> _data =
          _responseMania as Success<PaymentMessage>;

//    }
    }
  }

  String get getPayableFeeHeads {
    String _heads = "";

    widget.payableFees!.forEach((element) {
      _heads = _heads + "," + element.headName!;
    });
    return _heads.substring(1);
  }

  @override
  void initState() {
    super.initState();
    _onCreated();
  }

  Widget _onFailed(context, Failure f) => Center(
          child: MyErrorData(
        errorMsg: "Failed to initiate the transaction",
//        onRetry: _onCreated,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureMania(
        future: _futureResult,
        onWaiting: (context) => Center(
          child: CircularProgressIndicator(),
        ),
        onFailed: _onFailed,
        onError: _onFailed,
        onSuccess: (context, PaymentMessage payMessage) {
          return ScopedModelDescendant(
            builder: (_, __, MainModel model) {
              return model.isLoading
                  ? Loader()
                  : PaymentWebViewPlugin(
                      model: widget.model,
                      message: payMessage,
                      gateway: widget.selectedGateway,
                    );
            },
          );
        },
      ),
    );
  }
}
