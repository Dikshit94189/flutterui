import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  static Future<bool> requestStoragePermission() async {
    var status = await Permission.photos.request(); // iOS
    if (status.isGranted) return true;

    status = await Permission.storage.request(); // Android
    return status.isGranted;
  }
}
