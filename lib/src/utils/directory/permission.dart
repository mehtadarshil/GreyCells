import 'package:permission_handler/permission_handler.dart';

class GCPermission {
  static Future<bool> checkPermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
    } else {
      PermissionStatus _requestStatus = await Permission.storage.request();
      if (_requestStatus.isGranted)
        return true;
      else
        checkPermission();
    }

    return false;
  }
}
