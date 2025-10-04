import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

class HiveStorage {
  static const String _boxName = "LocalStorage";
  static const String _nameKey = "nameSaveHere";

  final Box _box;

  HiveStorage._internal(this._box);

  static Future<HiveStorage> getInstance() async {
    final box = await Hive.openBox(_boxName);
    return HiveStorage._internal(box);
  }

  /// Setter for name
  Future<void> setName(String name) async {
    await _box.put(_nameKey, name);
  }

  /// Getter for name
  String getName() {
    return _box.get(_nameKey, defaultValue: '') ?? '';
  }

  /// Listenable for UI updates
  ValueListenable<Box> listenable() {
    return _box.listenable(keys: [_nameKey]);
  }
}
