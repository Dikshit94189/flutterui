import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/theme_provider.dart';

class AppThemeHelper {
  final WidgetRef ref;

  AppThemeHelper(this.ref);

  /// Determines if dark mode is active
  bool get isDark => ref.watch(themeProvider) == ThemeMode.dark;

  /// Returns the app bar color based on theme mode
  Color get appBarColor => isDark ? Colors.blue : Colors.white;

  /// Returns text color based on theme mode
  Color get textColor => isDark ? Colors.white : Colors.black;

  /// Returns the background color (if needed)
  Color get backgroundColor => isDark ? Colors.black : Colors.white;

  /// Example: Return card color or container color
  Color get cardColor => isDark ? Colors.grey[850]! : Colors.white;
}
