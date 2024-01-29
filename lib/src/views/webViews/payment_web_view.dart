//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:greycell_app/src/config/apiauth_config.dart';
//import 'package:greycell_app/src/manager/main_model.dart';
//import 'package:greycell_app/src/models/payment/payment_message.dart';
//import 'package:webview_flutter/webview_flutter.dart';
//
//class PaymentWebView extends StatefulWidget {
//  final MainModel model;
//  final PaymentMessage payMessage;
//
//  PaymentWebView({this.model, this.payMessage}) : assert(payMessage != null);
//
//  @override
//  _PaymentWebViewState createState() => _PaymentWebViewState();
//}
//
//class _PaymentWebViewState extends State<PaymentWebView> {
//  WebViewController _webViewController;
//  final Completer<WebViewController> _controller =
//      Completer<WebViewController>();
//
//  JavascriptChannel _onWebLoad() {
//    return JavascriptChannel(
//        name: 'FlutterApp',
//        onMessageReceived: (JavascriptMessage message) {
//          print("JavaScript Message: $message");
//          print("Message: ${message.message}");
//          Scaffold.of(context).showSnackBar(
//            SnackBar(content: Text(message.message)),
//          );
//        });
//  }
//
//  JavascriptChannel _onResponse() {
//    return JavascriptChannel(
//        name: 'Response',
//        onMessageReceived: (JavascriptMessage message) {
//          print("JavaScript Message: $message");
//          print("Message: ${message.message}");
//          Scaffold.of(context).showSnackBar(
//            SnackBar(content: Text(message.message)),
//          );
//        });
//  }
//
//  void _sendDataToServer() {
//    _webViewController
//        .evaluateJavascript("onLoadData(${widget.payMessage.toString()})")
//        .then((value) => print(value));
//
////    _webViewController
////        .evaluateJavascript("onLoadData({'name': 'Mrutyunjaya'})");
//  }
//
//  void _onCreated() async {}
//
//  void _onUrlChange() {}
//
//  @override
//  void initState() {
//    super.initState();
//    _onCreated();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return WebView(
//      initialUrl: RestAPIs.WEB_VIEW_URL,
////        gestureNavigationEnabled: true,
//      javascriptMode: JavascriptMode.unrestricted,
//      javascriptChannels:
//          <JavascriptChannel>[_onWebLoad(), _onResponse()].toSet(),
//      onPageFinished: (String data) {
//        print("Page Finished: $data");
//        if (data == RestAPIs.WEB_VIEW_URL) {
//          _sendDataToServer();
//        } else if (data == widget.payMessage.curl) {
//          print("Transaction Cancelled");
//        } else if (data == widget.payMessage.furl) {
//          print("Transaction Failed");
//        } else if (data == RestAPIs.WEB_VIEW_RESPONSE_URL) {
//          print("Transaction Succeed");
//        }
//      },
//      onPageStarted: (String page) {
//        print("Page Started: $page");
//      },
//      onWebViewCreated: (WebViewController controller) {
//        _controller.complete(controller);
//        _webViewController = controller;
//        print("WebViewController Cretaed");
//      },
//    );
//  }
//}
