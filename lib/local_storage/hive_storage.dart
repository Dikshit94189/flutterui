import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageHelper {
  static const String _boxName = "LocalStorage";
  static const String _nameKey = "nameSaveHere";
  static const String _imagePathKey = "imagePath";

  final Box _box;

  StorageHelper._internal(this._box);

  static Future<StorageHelper> getInstance() async {
    final box = await Hive.openBox(_boxName);
    return StorageHelper._internal(box);
  }

  /// Name setter
  Future<void> setName(String name) async {
    await _box.put(_nameKey, name);
  }

  /// Name getter
  String getName() {
    return _box.get(_nameKey, defaultValue: '') ?? '';
  }

  /// Listenable for UI updates
  ValueListenable<Box> listenable() {
    return _box.listenable(keys: [_nameKey, _imagePathKey]);
  }

  /// Save image file path locally (mobile)
  Future<String?> saveImageLocally(File imageFile) async {
    if (kIsWeb) return null; // Web handles differently
    final dir = await getApplicationDocumentsDirectory();
    final fileName = "profile_image_${DateTime.now().millisecondsSinceEpoch}.png";
    final savedImage = await imageFile.copy("${dir.path}/$fileName");
    await _box.put(_imagePathKey, savedImage.path);
    return savedImage.path;
  }

  /// Get saved image path
  String? getImagePath() {
    if (kIsWeb) return null;
    return _box.get(_imagePathKey, defaultValue: null);
  }
}