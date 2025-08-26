import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/main.dart';
import 'package:flutter_ui/screens/bottom_tabs/tab_3.dart';
import 'package:flutter_ui/screens/bottom_tabs/tab_4.dart';
import 'package:flutter_ui/screens/bottom_tabs/tab_one.dart';
import 'package:flutter_ui/screens/bottom_tabs/tab_two.dart';
import 'package:flutter_ui/screens/drawer/drawer_four.dart';
import 'package:flutter_ui/screens/drawer/drawer_one.dart';
import 'package:flutter_ui/screens/drawer/drawer_three.dart';
import 'package:flutter_ui/screens/drawer/drawer_two.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

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
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("App Base" ,
          style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.w400
          ),
        ),
      ),
      body: _bottomTabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
        type: BottomNavigationBarType.fixed,
        items:  [
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
              DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("My Drawer", style: TextStyle(
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: context.responsive.fontSize(16, tablet: 18, desktop: 20),
              )),
            ),
            ListTile(
              leading:   Icon(Icons.pages),
              title:   Text("Drawer Page 1" , style: TextStyle(
                fontFamily: "Raleway",
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900
              ),),
              onTap: () => _navigateToDrawerPage( DrawerPage1()),
            ),
            ListTile(
              leading:  Icon(Icons.account_circle),
              title:  Text("Drawer Page 2" , style:TextStyle(
                  fontFamily: "Raleway",
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900
              ),),
              onTap: () => _navigateToDrawerPage( DrawerPage2()),
            ),
            ListTile(
              leading:  Icon(Icons.settings),
              title:  Text("Drawer Page 3" ,style: TextStyle(
                  fontFamily: "Raleway",
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900
              )),
              onTap: () => _navigateToDrawerPage( DrawerPage3()),
            ),
            ListTile(
              leading:  Icon(Icons.info),
              title:  Text("Drawer Page 4" , style: TextStyle(
                  fontFamily: "Raleway",
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900
              )),
              onTap: () => _navigateToDrawerPage( DrawerPage4()),
            ),
          ],
        ),
      ),
    );
  }
}
