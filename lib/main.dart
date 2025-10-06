import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/utils/responsive.dart';
import 'package:flutter_ui/view_model/theme_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'home_main.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("LocalStorage");
  runApp(
      ProviderScope
        (child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData.light(
        useMaterial3: true,
        // colorScheme: ColorScheme.light(primary: Colors.blue ,
        // brightness: Brightness.light,
        // ),
      ),
      themeMode:themeMode ,
      home: HomePage(),
    );
  }
}

// extension ResponsiveExt on BuildContext {
//   Responsive get responsive => Responsive(this);
// }

extension ResponsiveExt on BuildContext {
  Responsive get responsive => Responsive(this);
}