import 'package:flutter_share/flutter_share.dart';

class GCShareFile {
  static Future<void> share(String path,
      {String title = '', String subject = '', String text = ''}) async {
    await FlutterShare.shareFile(
      title: '$title',
      text: '$text',
      filePath: path,
    );
  }
}
