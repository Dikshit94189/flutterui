import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
class PermissionHelper {
  /// Request camera permission
  static Future<bool> requestCameraPermission() async {
    if (kIsWeb) {
      // On web, no runtime permission is needed → always return true
      return true;
    }
    // On Android/iOS, ask camera permission using permission_handler
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  /// Request storage/gallery permission
  static Future<bool> requestStoragePermission() async {
    if (kIsWeb) {
      // On web, file picker (gallery) is automatically handled by browser
      return true;
    }

    // On iOS: request photo library permission
    var status = await Permission.photos.request();
    if (status.isGranted) return true;

    // On Android: request storage permission
    status = await Permission.storage.request();
    return status.isGranted;
  }
}
