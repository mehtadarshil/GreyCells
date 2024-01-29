import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/themes/textstyle.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/payment/payment_message.dart';
import 'package:greycell_app/src/utils/directory/open_file.dart';
import 'package:greycell_app/src/utils/directory/permission.dart';
import 'package:greycell_app/src/utils/directory/share_file.dart';
import 'package:greycell_app/src/utils/pdf/transaction_pdf.dart';
import 'package:greycell_app/src/views/homeViews/home_views.dart';
import 'package:scoped_model/scoped_model.dart';

class TranscationSuccess extends StatefulWidget {
  final String? transcationId;
  final String? transcationRefNo;
  final String? message;
  final PaymentMessage? paymentMessage;
  final String? gateway;

  TranscationSuccess(
      {Key? key,
      this.gateway,
      this.transcationId,
      this.transcationRefNo,
      this.message,
      this.paymentMessage});

  @override
  _TranscationSuccessState createState() => _TranscationSuccessState();
}

class _TranscationSuccessState extends State<TranscationSuccess> {
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  bool isDownloading = false;

  Future<String?> _generatePdf() async {
    return await TransactionPDF(
      message: widget.message,
      gateway: widget.gateway![2],
      paymentMessage: widget.paymentMessage,
      transcationId: widget.transcationId,
      transcationRefNo: widget.transcationRefNo,
    ).generatePDF();
  }

  void _showSnack(String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "$message",
        style: TextStyle(color: Colors.white70),
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
    ));
  }

  void _onDownload() async {
    if (!await GCPermission.checkPermission()) {
      _showSnack("File storage permission required.", true);

      return;
    }
    setState(() {
      isDownloading = true;
    });
    final _result = await _generatePdf();
    if (!mounted) return;
    setState(() {
      isDownloading = false;
    });
    print("Result Path: $_result");
    if (_result != null) {
      // File Downloaded Successfully
      _showSnack("File saved in $_result", false);
      GCOpenFile.open(_result);
    } else {
      // Not
      _showSnack("Failed to save", true);
    }
  }

  void _onShare() async {
    if (!await GCPermission.checkPermission()) {
      _showSnack("File storage permission required.", true);

      return;
    }
    setState(() {
      isDownloading = true;
    });
    final _result = await _generatePdf();
    if (!mounted) return;
    setState(() {
      isDownloading = false;
    });
    if (_result != null) {
      // File Downloaded Successfully
      GCShareFile.share(_result,
          title: "Transaction_no_${widget.transcationId}");
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scafoldKey,
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0.0,
//          title: Text(
//            "Transaction Success",
//            style: TextStyle(color: Colors.black87),
//          ),
          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.share),
//              onPressed: () => _onShare(),
//              color: Colors.black87,
//            ),
            IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () => _onDownload(),
              color: Colors.black87,
            ),
            SizedBox(
              width: 8,
            )
          ],
          leading: ScopedModelDescendant(
            builder: (_, __, MainModel model) {
              return IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.black87,
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyHomeViews(
                                model: model,
                                index: 1,
                              )),
                      (route) => false));
            },
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.done,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Transaction Success",
                textAlign: TextAlign.center,
                style: CustomTextStyle(context)
                    .headline6!
                    .apply(color: Colors.green),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '₹',
                    style: CustomTextStyle.labelStyle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${widget.paymentMessage!}",
                    style: CustomTextStyle(context)
                        .headline4!
                        .apply(color: Colors.black87),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
                decoration: BoxDecoration(color: Colors.green[200]),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Text(
                  "Payments may take up to 2 working days to be reflected in your GreyCells account.",
                  textAlign: TextAlign.center,
                  style: CustomTextStyle(context)
                      .caption!
                      .apply(color: Colors.black87),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 10,
                        child: Icon(
                          Icons.done,
                          size: 16,
                        ),
                      ),
                      title: Text("Paid"),
                    ),
                    ListTile(
                      dense: true,
                      title: Text("${widget.transcationId}"),
                      subtitle: Text("Transaction ID"),
                    ),
                    ListTile(
                      dense: true,
                      title: Text("${widget.transcationRefNo}"),
                      subtitle: Text("Transaction Ref No"),
                    ),
                    ListTile(
                      dense: true,
                      title: Text("${widget.gateway}"),
                      subtitle: Text("Gateway"),
                    ),
                    ListTile(
                      dense: true,
                      title: Text("${widget.paymentMessage!}"),
                      subtitle: Text("Transaction Type"),
                    ),
                    ListTile(
                      dense: true,
                      title: Text("${widget.paymentMessage!}"),
                      subtitle: Text("User Name"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
