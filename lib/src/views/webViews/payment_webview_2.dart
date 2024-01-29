import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greycell_app/src/commons/actions/dialog_handler.dart';
import 'package:greycell_app/src/commons/widgets/loader.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/payment/payment_message.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewPlugin extends StatefulWidget {
  final PaymentMessage? message;
  final MainModel? model;
  final List? gateway;

  const PaymentWebViewPlugin({Key? key, this.message, this.model, this.gateway})
      : super(key: key);

  @override
  _PaymentWebViewPluginState createState() => _PaymentWebViewPluginState();
}

class _PaymentWebViewPluginState extends State<PaymentWebViewPlugin> {
  late WebViewController flutterWebViewPlugin;

  static final String _path = "assets/src/index.html";
  String _selectedUrl = "";
  String _title = "Payment Processing";

  bool _hasError = false;
  bool isLoading = true;
  bool onFinishedLoading = false;

  // Share The Screenshot or Receipt From Mobile Device
  bool hasShared = false;

  bool _hasSuccess = false;
  String? transcationNoRef = "";
  String? transcationId = "";
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

//   void _onUrlChanged(String url) {
//     if (mounted) {
//       print("Url Changed: ");
//       if (url == RestAPIs.WEB_VIEW_URL) {
//         _sendDataToServer();
//       } else if (url == widget.message!.postsubmiturl) {
//         setState(() {
//           isLoading = false;
//         });
// //          // Remove Dialog
// //          Navigator.of(context).pop();
//       } else if (url == widget.message!.furl || url == widget.message!.surl) {
//         setState(() {
//           onFinishedLoading = true;
//         });
//         print("i am here..............................");
//         print(url);
//         print(widget.message!.furl);
//         print(widget.message!.surl);
//         print("i am here..............................");
//         _onTransactionFinished();
//       }
//     }
//   }

//   void _onTransactionFinished() async {
//     try {
//       print("I am here.............................1");
//       final textContent =
//           await flutterWebViewPlugin.runJavaScriptReturningResult(
//               "window.document.getElementsByTagName('html')[0].textContent;");

//       final filterContent = textContent.toString().replaceAll(r'\', '');
//       print("HTML Replace textContent: $filterContent");
//       final jsonString = filterContent.substring(1, filterContent.length - 1);
//       print("HTML jsonString: $jsonString");
//       final jsonContent = jsonDecode(jsonString);

//       print("JSON: $jsonContent");
//       print("getTransactionId: ${jsonContent['getTransactionId']}");
//       if (jsonContent['isSuccess'] && jsonContent['getTransactionId'] != null) {
//         setState(() {
//           _title = "Transaction Success";
//           transcationNoRef = jsonContent['getTransactionRefNo'];
//           transcationId = jsonContent['getTransactionId'];
//           message = jsonContent['message'];
//           _hasSuccess = true;
//           onFinishedLoading = false;
//         });
//       } else {
//         setState(() {
//           _hasError = true;
//           _title = "Transaction Failed";
//           message = jsonContent['message'];
//           onFinishedLoading = false;
//         });
//       }
//     } catch (e) {
//       print("I am here.............................2");
//       print("Error Caught In Converting HTML Content To JSON");
//       setState(() {
//         _hasError = true;
//         _title = "Transaction Failed";
//         message = "Unable to make transaction";
//         onFinishedLoading = false;
//       });
//     }
//   }

//   void _onHTTPError() {
//     flutterWebViewPlugin..listen((WebViewHttpError error) {
//       if (mounted) {
//         print("HTTP Erro Detected: ${error.url} | ${error.code}");
// //        setState(() {
// //          _hasError = true;
// //        });
//       }
//     });
//   }

  @override
  void initState() {
    // print("get response ${widget.message?.getResponse}");
    // if (widget.message!.getResponse != null) {
    //   http
    //       .post(Uri.parse(widget.message!.getResponse!.url!),
    //           body: widget.message!.getResponse!.params!.toJson())
    //       .then((value) {
    //     flutterWebViewPlugin = WebViewController()
    //       ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //       ..setBackgroundColor(const Color(0x00000000))
    //       ..setNavigationDelegate(NavigationDelegate(
    //         onProgress: (progress) {
    //           if (progress == 100) {
    //             setState(() {
    //               isLoading = false;
    //             });
    //           }
    //         },
    //         onNavigationRequest: (request) {
    //           return NavigationDecision.navigate;
    //         },
    //       ))
    //       ..loadHtmlString(value.body);
    //     log(value.body);
    //   });
    // }

    // log("Loaded Url ${widget.message?.getResponse?.url ?? RestAPIs.WEB_VIEW_URL}");
    // super.initState();
  }

  @override
  void didChangeDependencies() {
//    DialogHandler.showMyLoader(context: context);
    super.didChangeDependencies();
  }

  void _sendDataToServer() {
    log("HTMl Response ${widget.message.toString()}");
    flutterWebViewPlugin
        .runJavaScriptReturningResult(
            "onLoadData(${widget.message.toString()})")
        .then((value) => print(value));
  }

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

  @override
  Widget build(BuildContext context) {
    return /*  onFinishedLoading
        ? Loader() // Hide Post JSON Data On Web View
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
                :  */
        SafeArea(
      top: true,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          isLoading
              ? SizedBox.shrink()
              : WebViewWidget(controller: flutterWebViewPlugin),
//                         WebviewScaffold(
//                           url: RestAPIs.WEB_VIEW_URL,

//                           javascriptChannels: jsChannels,
//                           mediaPlaybackRequiresUserGesture: false,
//                           withLocalStorage: true,
// //                          withLocalUrl: true,
//                           hidden: true,
//                           withZoom: true,
// //                        localUrlScope: "assets/src/template",
//                           initialChild: Container(
//                             child: const Center(
//                               child: Text('Waiting.....'),
//                             ),
//                           ),
//                         ),
          isLoading ? Loader() : Container(),
        ],
      ),
    );
  }
}
