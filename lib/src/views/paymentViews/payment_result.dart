import 'package:flutter/material.dart';
import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/services/tokenService/token_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PaymentResult extends StatefulWidget {
  const PaymentResult(
      {Key? key, required this.isSuccess, this.data, this.mainModel})
      : super(key: key);

  final bool isSuccess;
  final PaymentSuccessResponse? data;
  final MainModel? mainModel;

  @override
  State<PaymentResult> createState() => _PaymentResultState();
}

class _PaymentResultState extends State<PaymentResult> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Image.asset(widget.isSuccess
                  ? "assets/images/success.png"
                  : "assets/images/failed.png"),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.isSuccess ? "Payment Successfull" : "Payment Failed",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
            isLoading
                ? SizedBox(
                    height: 30, width: 30, child: CircularProgressIndicator())
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      if (!widget.isSuccess) {
                        widget.mainModel!.selectedPayableFees = [];
                        widget.mainModel!.totalPayableAmount = 0.0;
                        Navigator.pop(context);
                      }
                      if (widget.data != null) {
                        setState(() {
                          isLoading = true;
                        });
                        final DataFilter dataFilter = DataFilter();
                        var tokenResponse = await dataFilter.getToken(
                            serverUrl: RestAPIs.GREYCELL_TOKEN_URL,
                            apiCode: ApiAuth.ONLINE_PAY_RPT);
                        if (tokenResponse != null && widget.mainModel != null) {
                          var receiptData = await widget.mainModel!
                              .getReceiptDetails(
                                  tokens: tokenResponse, data: widget.data!);
                          if (receiptData != null) {
                            launchUrlString(receiptData.getReportFilePath ?? "",
                                mode: LaunchMode.externalApplication);
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: Text(
                      widget.isSuccess ? "View Receipt" : "Try agian",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                if (!widget.isSuccess) {
                  widget.mainModel!.selectedPayableFees = [];
                  widget.mainModel!.totalPayableAmount = 0.0;
                  Navigator.pop(context);
                }
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text(
                "Go to Dashboard",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
