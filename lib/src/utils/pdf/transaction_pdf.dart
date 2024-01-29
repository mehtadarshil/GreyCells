import 'dart:io';

import 'package:greycell_app/src/config/core_config.dart';
import 'package:greycell_app/src/models/payment/payment_message.dart';
import 'package:greycell_app/src/utils/directory/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TransactionPDF {
  late pw.Document _document;
  final String? transcationId;
  final String? transcationRefNo;
  final String? message;
  final PaymentMessage? paymentMessage;
  final String? gateway;

  TransactionPDF(
      {this.message,
      this.transcationId,
      this.gateway,
      this.paymentMessage,
      this.transcationRefNo}) {
    _document = pw.Document();
  }

  Future<String?> generatePDF() async {
    final _fileName = "${Core.APPNAME}_transaction_ID_$transcationId";
    final String _path =
        '${await PathProvider.getExternalDocumentPath(endDirectory: "Transactions")}/${_fileName}.pdf';

    try {
      // final PdfImage assetImage =
      //  await PdfImage.fromImage(
      //   _document.document,
      //   image: im.Image.fromBytes(width: Image.asset('assets/images/greycell_logo.jpg'), height: height, bytes: bytes),
      // );
      // final PdfImage doneImage = await pdfImageFromImageProvider(
      //   pdf: _document.document,
      //   image: AssetImage('assets/images/done.png'),
      // );
      final doneImage = pw.MemoryImage(
        File('assets/images/done.png').readAsBytesSync(),
      );
      _document.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Container(
              child: pw.ListView(
                children: <pw.Widget>[
                  pw.SizedBox(
                    height: 8,
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(shape: pw.BoxShape.circle),
                    child: pw.Image(doneImage, width: 150.0, height: 80.0),
                  ),
                  pw.SizedBox(
                    height: 8,
                  ),
                  pw.Text(
                    "Transaction Success",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontSize: 24.0, color: PdfColors.green),
                  ),
                  pw.SizedBox(
                    height: 18,
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: <pw.Widget>[
                      pw.Text(
                        'Rs.',
                        style: pw.TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      pw.SizedBox(
                        width: 5,
                      ),
                      pw.Text(
                        "${paymentMessage!}",
                        style: pw.TextStyle(
                            fontSize: 48.0, color: PdfColors.black),
                      )
                    ],
                  ),
                  pw.Container(
                    margin:
                        pw.EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
                    decoration: pw.BoxDecoration(color: PdfColors.green200),
                    padding:
                        pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: pw.Text(
                      "Payments may take up to 2 working days to be reflected in your GreyCells account.",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  pw.Container(
                    margin: pw.EdgeInsets.symmetric(horizontal: 8),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[
//                        pw.ListTile(
//                          dense: true,
//                          leading: CircleAvatar(
//                            backgroundColor: Colors.green,
//                            radius: 10,
//                            child: Icon(
//                              Icons.done,
//                              size: 16,
//                            ),
//                          ),
//                          title: Text("Paid"),
//                        ),
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: <pw.Widget>[
                            pw.Text("Transaction ID: "),
                            pw.SizedBox(width: 6),
                            pw.Text("${transcationId}"),
                          ],
                        ),
                        pw.SizedBox(height: 10),
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: <pw.Widget>[
                            pw.Text("Transaction Reference No: "),
                            pw.SizedBox(width: 6),
                            pw.Text("${transcationRefNo}"),
                          ],
                        ),
                        pw.SizedBox(height: 10),
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: <pw.Widget>[
                            pw.Text("Gateway: "),
                            pw.SizedBox(width: 6),
                            pw.Text("${gateway}"),
                          ],
                        ),
                        pw.SizedBox(height: 10),
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: <pw.Widget>[
                            pw.Text("Transaction Type: "),
                            pw.SizedBox(width: 6),
                            pw.Text("${paymentMessage!}"),
                          ],
                        ),
                        pw.SizedBox(height: 10),
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: <pw.Widget>[
                            pw.Text("User Name: "),
                            pw.SizedBox(width: 6),
                            pw.Text("${paymentMessage!}"),
                          ],
                        ),
                        pw.SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ); // Center
          }));

      // Save and Write
      final file = File(_path);

      file.writeAsBytesSync(await _document.save());
    } catch (e) {
      print("Error Caught In Generating PDF: ${e.toString()}");
      return null;
    }
    return _path;
  }
}
