import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/main.dart';
import 'package:flutter_ui/screens/bottom_tabs/tab_3.dart';
import 'package:flutter_ui/screens/bottom_tabs/tab_4.dart';
import 'package:flutter_ui/screens/bottom_tabs/tab_one.dart';
import 'package:flutter_ui/screens/bottom_tabs/tab_two.dart';
import 'package:flutter_ui/screens/drawer/drawer_four.dart';
import 'package:flutter_ui/screens/drawer/drawer_one.dart';
import 'package:flutter_ui/screens/drawer/drawer_three.dart';
import 'package:flutter_ui/screens/drawer/drawer_two.dart';

// class HomePage extends StatefulWidget {
//    HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//
//   final List<Widget> _bottomTabs = [
//      BottomTab1(),
//      BottomTab2(),
//      BottomTab3(),
//      BottomTab4(),
//   ];
//
//   void _onBottomNavTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   void _navigateToDrawerPage(Widget page) {
//     Navigator.push(
//       context,
//       CupertinoPageRoute(builder: (context) => page),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:  Text("App Base" ,
//           style: TextStyle(
//             fontFamily: "Raleway",
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: _bottomTabs[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onBottomNavTapped,
//         type: BottomNavigationBarType.fixed,
//         items:  [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Tab 1",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: "Tab 2",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: "Tab 3",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: "Tab 4",
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//               DrawerHeader(
//               decoration: BoxDecoration(color: Colors.blue),
//               child: Text("My Drawer", style: TextStyle(
//                   fontFamily: "Raleway",
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontSize: context.responsive.fontSize(16, tablet: 18, desktop: 20),
//               )),
//             ),
//             ListTile(
//               leading:   Icon(Icons.pages),
//               title:   Text("Drawer Page 1" , style: TextStyle(
//                 fontFamily: "Raleway",
//                 fontWeight: FontWeight.w700,
//               ),),
//               onTap: () => _navigateToDrawerPage( DrawerPage1()),
//             ),
//             ListTile(
//               leading:  Icon(Icons.account_circle),
//               title:  Text("Drawer Page 2" , style:TextStyle(
//                   fontFamily: "Raleway",
//                    fontWeight: FontWeight.w900
//               ),),
//               onTap: () => _navigateToDrawerPage( DrawerPage2()),
//             ),
//             ListTile(
//               leading:  Icon(Icons.settings),
//               title:  Text("Drawer Page 3" ,style: TextStyle(
//                   fontFamily: "Raleway",
//                    fontWeight: FontWeight.w900
//               )),
//               onTap: () => _navigateToDrawerPage( DrawerPage3()),
//             ),
//             ListTile(
//               leading:  Icon(Icons.info),
//               title:  Text("Drawer Page 4" , style: TextStyle(
//                   fontFamily: "Raleway",
//                    fontWeight: FontWeight.w900
//               )),
//               onTap: () => _navigateToDrawerPage( DrawerPage4()),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// // }

///  USE DRAWER FROM THIS PACKAGE  ->>>>    https://pub.dev/packages/flutter_slider_drawer/install

import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_ui/theme_helper/app_theme_helper.dart';
import 'package:flutter_ui/view_model/theme_provider.dart';
import 'package:hive/hive.dart';

import 'local_storage/hive_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();

  int _currentIndex = 0;
  String title = "App Base";

  String Name = "---";

  final List<Widget> _bottomTabs = [
    BottomTab1(),
    BottomTab2(),
    BottomTab3(),
    BottomTab4(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _navigateToDrawerPage(Widget page) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
    _sliderDrawerKey.currentState?.closeSlider();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final themeHelper = AppThemeHelper(ref);
        return Scaffold(
          body: SafeArea(
            child: SliderDrawer(
              key: _sliderDrawerKey,
              sliderOpenSize: MediaQuery.of(context).size.width * 0.45,
              animationDuration: 60,
              isDraggable: true,
              slideDirection: SlideDirection.leftToRight,
              sliderBoxShadow: SliderBoxShadow(blurRadius: 50),
              appBar: SliderAppBar(
                config: SliderAppBarConfig(
                  backgroundColor: themeHelper.appBarColor,
                  drawerIconColor: themeHelper.textColor,
                  title: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Raleway",
                      color: themeHelper.textColor,
                    ),
                  ),
                ),
              ),
              slider: _buildDrawerContent(ref),
              child: GestureDetector(
                onTap: () {
                  if (_sliderDrawerKey.currentState!.isDrawerOpen) {
                    _sliderDrawerKey.currentState!.closeSlider();
                  }
                },
                child: Scaffold(
                  body: _bottomTabs[_currentIndex],
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: _currentIndex,
                    onTap: _onBottomNavTapped,
                    type: BottomNavigationBarType.fixed,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.search_circle_fill),
                        label: "Search",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.waveform_path_ecg),
                        label: "Web View",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.profile_circled),
                        label: "Profile",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<String> _loadName() async {
    final helper = await StorageHelper.getInstance();
    return helper.getName();
  }

  Widget _buildDrawerContent(WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final storageHelper = StorageHelper.fromBox(Hive.box('LocalStorage'));

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : Colors.blue,
                ),
                child: ValueListenableBuilder(
                  valueListenable: storageHelper.listenable(),
                  builder: (context, box, _) {
                    final name = box.get(
                      'nameSaveHere',
                      defaultValue: "Dikshit",
                    );
                    return Text(name);
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dashboard),
                title: Text(
                  "DashBorad",
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onTap: () => _navigateToDrawerPage(const DrawerPage1()),
              ),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: Text(
                  "Help / Support",
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onTap: () => _navigateToDrawerPage(const DrawerPage2()),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(
                  "About",
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onTap: () => _navigateToDrawerPage(const DrawerPage3()),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(
                  "Logout",
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onTap: () => _navigateToDrawerPage(const DrawerPage4()),
              ),
              ListTile(
                leading: Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  color: isDark ? Colors.white : Colors.black,
                ),
                title: Text(
                  isDark ? "Light Mode" : "Dark Mode",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                onTap: () {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
//
// ///  USE DRAWER FROM THIS PACKAGE  ->>>>    https://pub.dev/packages/flutter_advanced_drawer
// class HomePage extends StatefulWidget {
//   HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final _advancedDrawerController = AdvancedDrawerController();
//
//   int _currentIndex = 0;
//   String title = "App Base";
//
//   final List<Widget> _bottomTabs = [
//     BottomTab1(),
//     BottomTab2(),
//     BottomTab3(),
//     BottomTab4(),
//   ];
//
//   void _onBottomNavTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   void _navigateToDrawerPage(Widget page) {
//     Navigator.push(
//       context,
//       CupertinoPageRoute(builder: (context) => page),
//     );
//     _advancedDrawerController.hideDrawer(); // close drawer after navigation
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AdvancedDrawer(
//       backdropColor: Colors.blueGrey.shade900,
//       controller: _advancedDrawerController,
//       animationCurve: Curves.easeInOut,
//       animationDuration: const Duration(milliseconds: 300),
//       animateChildDecoration: true,
//       rtlOpening: false,
//       childDecoration: const BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(16)),
//       ),
//       drawer: _buildDrawerContent(),
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           centerTitle: true,
//           title: Text(
//             title,
//             style: const TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w700,
//               fontFamily: "Raleway",
//               color: Colors.black,
//             ),
//           ),
//           leading: IconButton(
//             onPressed: () {
//               _advancedDrawerController.showDrawer();
//             },
//               icon: ValueListenableBuilder<AdvancedDrawerValue>(
//                 valueListenable: _advancedDrawerController,
//                 builder: (_, value, __) {
//                   return AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 250),
//                     child: Icon(
//                       value.visible ? CupertinoIcons.clear  : CupertinoIcons.line_horizontal_3,
//                       key: ValueKey<bool>(value.visible),
//                       color: Colors.black,
//                     ),
//                   );
//                 },
//               ),
//
//             // icon:   Icon(CupertinoIcons.decrease_indent),
//                     // value?.visible ? Icons.clear : Icons.menu,
//                     // key: ValueKey<bool>(value!.visible),
//                     // color: Colors.black,
//                   // );
//               // },
//
//           ),
//         ),
//         body: _bottomTabs[_currentIndex],
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _currentIndex,
//           onTap: _onBottomNavTapped,
//           type: BottomNavigationBarType.fixed,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Tab 1",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.search),
//               label: "Tab 2",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.notifications),
//               label: "Tab 3",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: "Tab 4",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDrawerContent() {
//     return SafeArea(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(color: Colors.blue),
//             child: Text(
//               "My Drawer",
//               style: TextStyle(
//                 fontFamily: "Raleway",
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.pages),
//             title: const Text(
//               "Drawer Page 1",
//               style: TextStyle(
//                 fontFamily: "Raleway",
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             onTap: () => _navigateToDrawerPage(const DrawerPage1()),
//           ),
//           ListTile(
//             leading: const Icon(Icons.account_circle),
//             title: const Text(
//               "Drawer Page 2",
//               style: TextStyle(
//                 fontFamily: "Raleway",
//                 fontWeight: FontWeight.w900,
//               ),
//             ),
//             onTap: () => _navigateToDrawerPage(const DrawerPage2()),
//           ),
//           ListTile(
//             leading: const Icon(Icons.settings),
//             title: const Text(
//               "Drawer Page 3",
//               style: TextStyle(
//                 fontFamily: "Raleway",
//                 fontWeight: FontWeight.w900,
//               ),
//             ),
//             onTap: () => _navigateToDrawerPage(const DrawerPage3()),
//           ),
//           ListTile(
//             leading: const Icon(Icons.info),
//             title: const Text(
//               "Drawer Page 4",
//               style: TextStyle(
//                 fontFamily: "Raleway",
//                 fontWeight: FontWeight.w900,
//               ),
//             ),
//             onTap: () => _navigateToDrawerPage(const DrawerPage4()),
//           ),
//         ],
//       ),
//     );
//   }
// }
