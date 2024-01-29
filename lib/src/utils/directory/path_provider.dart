import 'dart:io';

import 'package:greycell_app/src/config/core_config.dart';
import 'package:path_provider/path_provider.dart';

class PathProvider {
  static Future<String> getExternalDocumentPath(
      {String endDirectory = "documents"}) async {
    final Directory _directory = (await getExternalStorageDirectory())!;
    final exPath =
        _directory.path.split('0')[0] + "0/${Core.APPNAME}/$endDirectory";
    print("Saved Path: $exPath");
    await Directory('$exPath').create(recursive: true);
    return exPath;
  }
}
