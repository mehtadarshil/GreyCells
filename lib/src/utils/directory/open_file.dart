import 'package:open_file/open_file.dart';

class GCOpenFile {
  static Future<bool> open(String path) async {
    try {
      final OpenResult _openResult = await OpenFile.open(path);
      print("Open result Type: ${_openResult.type}");
      print("Open result Message: ${_openResult.message}");
    } catch (e) {
      print("Opening File Error: ${e.toString()}");
      return false;
    }
    return true;
  }
}
