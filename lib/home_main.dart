import 'package:flutter/material.dart';
import 'package:flutter_ui/screens/bottom_tabs/tab_3.dart';
import 'package:flutter_ui/screens/bottom_tabs/tab_4.dart';
import 'package:flutter_ui/screens/bottom_tabs/tab_one.dart';
import 'package:flutter_ui/screens/bottom_tabs/tab_two.dart';
import 'package:flutter_ui/screens/drawer/drawer_four.dart';
import 'package:flutter_ui/screens/drawer/drawer_one.dart';
import 'package:flutter_ui/screens/drawer/drawer_three.dart';
import 'package:flutter_ui/screens/drawer/drawer_two.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _bottomTabs = [
    const BottomTab1(),
    const BottomTab2(),
    const BottomTab3(),
    const BottomTab4(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _navigateToDrawerPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: _bottomTabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Tab 1",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Tab 2",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Tab 3",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Tab 4",
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("My Drawer", style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.pages),
              title: const Text("Drawer Page 1"),
              onTap: () => _navigateToDrawerPage(const DrawerPage1()),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("Drawer Page 2"),
              onTap: () => _navigateToDrawerPage(const DrawerPage2()),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Drawer Page 3"),
              onTap: () => _navigateToDrawerPage(const DrawerPage3()),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("Drawer Page 4"),
              onTap: () => _navigateToDrawerPage(const DrawerPage4()),
            ),
          ],
        ),
      ),
    );
  }
}
