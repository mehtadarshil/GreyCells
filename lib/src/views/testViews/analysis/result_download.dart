//import 'dart:io';
//
//import 'package:greycell_app/src/manager/main_model.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:pdf/pdf.dart';
//import 'package:pdf/widgets.dart';
//
//class ResultDownloader {
//  static final double minValue = 8.0;
//
//  static Future<bool> downloadAsPdf(MainModel model) async {
//    bool result = false;
//    try {
//      print("Model Is Working Here:  ${model.subjectMarkList}");
//      Directory tempDir = await getTemporaryDirectory();
//      String tempPath = tempDir.path;
//      print("Temporary Path: $tempDir");
//
//      final appDocDir =
//          await getExternalStorageDirectories(type: StorageDirectory.documents);
//
//      final Document pdf = Document();
//
//      await pdf.addPage(MultiPage(
//          pageFormat: PdfPageFormat.letter
//              .copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
//          crossAxisAlignment: CrossAxisAlignment.start,
//          header: (Context context) {
//            if (context.pageNumber == 1) {
//              return null;
//            }
//            return Container(
//                alignment: Alignment.centerRight,
//                margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
//                padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
//                decoration: const BoxDecoration(
//                    border: BoxBorder(
//                        bottom: true, width: 0.5, color: PdfColors.grey)),
//                child: Text('Portable Document Format',
//                    style: Theme.of(context)
//                        .defaultTextStyle
//                        .copyWith(color: PdfColors.grey)));
//          },
//          footer: (Context context) {
//            return Container(
//                alignment: Alignment.centerRight,
//                margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
//                child: Text(
//                    'Page ${context.pageNumber} of ${context.pagesCount}',
//                    style: Theme.of(context)
//                        .defaultTextStyle
//                        .copyWith(color: PdfColors.grey)));
//          },
//          build: (Context context) => <Widget>[
//                Header(
//                    level: 0,
//                    child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Text('Portable Document Format', textScaleFactor: 2),
//                          PdfLogo()
//                        ])),
//                Paragraph(
//                    text:
//                        'The Portable Document Format (PDF) is a file format developed by Adobe in the 1990s to present documents, including text formatting and images, in a manner independent of application software, hardware, and operating systems. Based on the PostScript language, each PDF file encapsulates a complete description of a fixed-layout flat document, including the text, fonts, vector graphics, raster images and other information needed to display it. PDF was standardized as an open format, ISO 32000, in 2008, and no longer requires any royalties for its implementation.'),
//                Header(level: 1, text: 'Technical foundations'),
//                Paragraph(text: 'The PDF combines three technologies:'),
//                Bullet(
//                    text:
//                        'A structured storage system to bundle these elements and any associated content into a single file, with data compression where appropriate.'),
//                Paragraph(
//                    text:
//                        'The PDF file format has changed several times, and continues to evolve, along with the release of new versions of Adobe Acrobat. There have been nine versions of PDF and the corresponding version of the software:'),
//                Table.fromTextArray(
//                    context: context,
//                    data: const <List<String>>[
//                      <String>['Date', 'PDF Version', 'Acrobat Version'],
//                      <String>['1993', 'PDF 1.0', 'Acrobat 1'],
//                      <String>['1994', 'PDF 1.1', 'Acrobat 2'],
//                      <String>['1996', 'PDF 1.2', 'Acrobat 3'],
//                      <String>['1999', 'PDF 1.3', 'Acrobat 4'],
//                      <String>['2001', 'PDF 1.4', 'Acrobat 5'],
//                      <String>['2003', 'PDF 1.5', 'Acrobat 6'],
//                      <String>['2005', 'PDF 1.6', 'Acrobat 7'],
//                      <String>['2006', 'PDF 1.7', 'Acrobat 8'],
//                      <String>['2008', 'PDF 1.7', 'Acrobat 9'],
//                      <String>['2009', 'PDF 1.7', 'Acrobat 9.1'],
//                      <String>['2010', 'PDF 1.7', 'Acrobat X'],
//                      <String>['2012', 'PDF 1.7', 'Acrobat XI'],
//                      <String>['2017', 'PDF 2.0', 'Acrobat DC'],
//                    ]),
//                Padding(padding: const EdgeInsets.all(10)),
//                Paragraph(
//                    text:
//                        'Text is available under the Creative Commons Attribution Share Alike License.')
//              ]));
//
//      appDocDir[0].createSync();
//
//      final File file =
//          File('/storage/emulated/0/GreyCells/${model.school.schoolName}.pdf');
//      file.writeAsBytesSync(pdf.save());
//
//      result = true;
//    } catch (e) {
//      print(e);
//      result = false;
//    }
//    return result;
//  }
//}
