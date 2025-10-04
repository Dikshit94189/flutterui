import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PermissionHelper {
  /// Request camera permission
  static Future<bool> requestCameraPermission() async {
    if (kIsWeb) {
      // Web browsers handle this automatically
      return true;
    }
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  /// Request storage/gallery permission
  static Future<bool> requestStoragePermission() async {
    if (kIsWeb) {
      // Web browsers handle file picker automatically
      return true;
    }

    // iOS
    var status = await Permission.photos.request();
    if (status.isGranted) return true;

    // Android
    status = await Permission.storage.request();
    return status.isGranted;
  }
}
