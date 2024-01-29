import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:greycell_app/src/commons/widgets/loader.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/payment/payment_message.dart';
import 'package:greycell_app/src/views/paymentViews/transaction_failed.dart';
import 'package:greycell_app/src/views/paymentViews/transcations_success.dart';

class PaymentWebViewInApp extends StatefulWidget {
  final PaymentMessage? message;
  final MainModel? model;
  final List? gateway;

  const PaymentWebViewInApp({Key? key, this.message, this.model, this.gateway})
      : super(key: key);

  @override
  _PaymentWebViewInAppState createState() => _PaymentWebViewInAppState();
}

class _PaymentWebViewInAppState extends State<PaymentWebViewInApp> {
  InAppWebViewController? webView;

  static final String _path = "assets/src/index.html";
  String _selectedUrl = "";
  String _title = "Payment Processing";

  bool _hasError = false;
  bool isLoading = true;

  // Share The Screenshot or Receipt From Mobile Device
  bool hasShared = false;

  bool _hasSuccess = false;
  String transcationNoRef = "";
  String transcationId = "";
  String? message = null;

  Future<void> _loadInitialFile() async {
    final content = await rootBundle.loadString(_path);
    if (mounted)
      setState(() {
        _selectedUrl = Uri.dataFromString(content,
                mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
            .toString();
        isLoading = false;
      });
  }

  void _onUrlChanged() {
//    webView.onUrlChanged.listen((String url) async {
//      if (mounted) {
//        print("Url Changed: ");
//        if (url == RestAPIs.WEB_VIEW_URL) {
//          _sendDataToServer();
//        } else if (url == widget.message.furl || url == widget.message.surl) {
//          print("Url: $url");
//
//          _onTransactionFinished();
//        }
//      }
//    });
  }

  void _onTransactionFinished() async {
//    try {
//      final textContent = await flutterWebViewPlugin.evalJavascript(
//          "window.document.getElementsByTagName('html')[0].textContent;");
//
////    print("HTML textContent: $textContent");
//      final filterContent = textContent.replaceAll(r'\', '');
////    print("HTML Replace textContent: $filterContent");
//      final jsonString = filterContent.substring(1, filterContent.length - 1);
////    print("HTML jsonString: $jsonString");
//      final jsonContent = jsonDecode(jsonString);
//
//      print("JSON: $jsonContent");
//      print("getTransactionId: ${jsonContent['getTransactionId']}");
//      if (jsonContent['isSuccess'] && jsonContent['getTransactionId'] != null) {
//        setState(() {
//          _title = "Transaction Success";
//          transcationNoRef = jsonContent['getTransactionRefNo'];
//          transcationId = jsonContent['getTransactionId'];
//          message = jsonContent['message'];
//          _hasSuccess = true;
//        });
//      } else {
//        setState(() {
//          _hasError = true;
//          _title = "Transaction Failed";
//          message = jsonContent['message'];
//        });
//      }
//    } catch (e) {
//      print("Error Caught In Converting HTML Content To JSON");
//      setState(() {
//        _hasError = true;
//        _title = "Transaction Failed";
//        message = "Unable to make transaction";
//      });
//    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadInitialFile();

    _onUrlChanged();
//    _onHTTPError();
//    _sendDataToServer();
  }

  void _sendDataToServer() {
    print(widget.message.toString());
//    flutterWebViewPlugin
//        .evalJavascript("onLoadData(${widget.message.toString()})")
//        .then((value) => print(value));
  }

//  final Set<JavascriptChannel> jsChannels = [
//    JavascriptChannel(
//        name: 'Print',
//        onMessageReceived: (JavascriptMessage message) {
//          print(message.message);
//        }),
//  ].toSet();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        isLoading
            ? Loader()
            : _hasError
                ? TransactionFailed(
                    message: message,
                  )
                : _hasSuccess
                    ? TranscationSuccess(
                        gateway: widget.gateway![2],
                        paymentMessage: widget.message,
                        transcationId: transcationId,
                        transcationRefNo: transcationNoRef,
                      )
                    : Scaffold(
                        appBar: AppBar(
                          title: Text("$_title"),
                        ),
                        body: InAppWebView(
                          initialFile: _path,
//                          onCreateWindow: (InAppWebViewController controller, CreateWindowRequest request) async{
//                            return true;
//                          },
                          initialOptions: InAppWebViewGroupOptions(
                              crossPlatform: InAppWebViewOptions(
                                useShouldOverrideUrlLoading: true,
                                javaScriptCanOpenWindowsAutomatically: true,
                              ),
                              android: AndroidInAppWebViewOptions(
                                  // on Android you need to set supportMultipleWindows to true,
                                  // otherwise the onCreateWindow event won't be called
                                  supportMultipleWindows: true)),

                          onLoadStart: (controller, url) {
                            print("onLoadStart $url");
//            setState(() {
//              this.url = url;
//            });
                          },
                          onLoadStop: (controller, url) async {
                            print("onLoadStop $url");
                          },
                          onProgressChanged: (InAppWebViewController controller,
                              int progress) {
                            print("On Progress Changed: $progress");
//
                          },
                          onConsoleMessage: (InAppWebViewController controller,
                              ConsoleMessage consoleMessage) {
                            print("console message: ${consoleMessage.message}");
                          },
                          onWebViewCreated:
                              (InAppWebViewController controller) {
                            webView = controller;
                            print("onWebViewCreated");
                            controller.addJavaScriptHandler(
                                handlerName: "onLoadData",
                                callback: (args) {
                                  // Here you receive all the arguments from the JavaScript side
                                  // that is a List<dynamic>
                                  print("From the JavaScript side:");
                                  print(args);
                                  return widget.message!.toJson();
                                });
                          },
                        ),
                      ),
      ],
    );
  }
}
