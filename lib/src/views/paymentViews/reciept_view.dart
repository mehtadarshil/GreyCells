import 'package:flutter/material.dart';
import 'package:greycell_app/src/models/payment/receipt_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReceiptView extends StatelessWidget {
  const ReceiptView({Key? key, required this.data}) : super(key: key);

  final ReceiptModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receipt"),
      ),
      body: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(data.getReportFilePath ?? ""))),
    );
  }
}
