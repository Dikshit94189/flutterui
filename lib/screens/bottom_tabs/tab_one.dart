import 'package:flutter/material.dart';
import 'package:flutter_ui/main.dart';
import '../../customs/search_sheet_view.dart';
import '../../home_tab/home_tab.dart';
import '../../home_tab/show_tabs.dart';

class BottomTab1 extends StatefulWidget {
  const BottomTab1({super.key});

  @override
  State<BottomTab1> createState() => _BottomTab1State();
}

class _BottomTab1State extends State<BottomTab1>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return DefaultTabController(
      length: 2,
      child: Column(
        children: [
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: SizedBox(
        height: context.responsive.height(35, tablet: 50, desktop: 60),
         child: Row(
           children: [
             /// 👇 Expanded so TabBar takes available space
             Expanded(
               child: TabBar(
                 controller: _tabController,
                 isScrollable: true,
                 physics: const BouncingScrollPhysics(),
                 dividerColor: Colors.transparent,
                 indicator: const BoxDecoration(), // disable default indicator
                 labelPadding: EdgeInsets.zero, // 👈 we handle spacing via margin
                 tabAlignment: TabAlignment.start,
                 tabs: [
                   // ---- First Tab
                   Container(
                     margin: EdgeInsets.symmetric( // 👈 external spacing (gap between tabs)
                       horizontal: context.responsive.width(4, tablet: 8, desktop: 12),
                     ),
                     padding: EdgeInsets.symmetric( // 👈 inner spacing
                       horizontal: context.responsive.width(10, tablet: 20, desktop: 30),
                       vertical: context.responsive.height(2, tablet: 4, desktop: 8),
                     ),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(8),
                       color: _selectedIndex == 0 ? Colors.blue : Colors.transparent,
                       border: Border.all(
                         color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                         width: 1.5,
                       ),
                     ),
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Icon(
                           Icons.home,
                           size: context.responsive.iconSize(28, tablet: 32, desktop: 36),
                           color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                         ),
                         SizedBox(
                           width: context.responsive.width(4, tablet: 6, desktop: 8),
                         ),
                         Text(
                           "HOME",
                           style: TextStyle(
                             fontSize: context.responsive.fontSize(10, tablet: 14, desktop: 20),
                             color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                           ),
                         ),
                       ],
                     ),
                   ),

                   // ---- Second Tab
                   Container(
                     margin: EdgeInsets.symmetric( // 👈 same external spacing
                       horizontal: context.responsive.width(4, tablet: 8, desktop: 12),
                     ),
                     padding: EdgeInsets.symmetric(
                       horizontal: context.responsive.width(10, tablet: 20, desktop: 30),
                       vertical: context.responsive.height(2, tablet: 4, desktop: 8),
                     ),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(8),
                       color: _selectedIndex == 1 ? Colors.blue : Colors.transparent,
                       border: Border.all(
                         color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                         width: 1.5,
                       ),
                     ),
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Icon(
                           Icons.tv_sharp,
                           size: context.responsive.iconSize(28, tablet: 32, desktop: 36),
                           color: _selectedIndex == 1 ? Colors.black : Colors.blue,
                         ),
                         SizedBox(
                           width: context.responsive.width(4, tablet: 6, desktop: 8),
                         ),
                         Text(
                           "SHOWS",
                           style: TextStyle(
                             fontSize: context.responsive.fontSize(10, tablet: 14, desktop: 20),
                             color: _selectedIndex == 1 ? Colors.black: Colors.blue,
                           ),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),

             /// 👇 Search icon at the end
             IconButton(
               icon: Icon(
                 Icons.search,
                 size: context.responsive.iconSize(25, tablet: 38, desktop: 45),
               ),
               onPressed: () {
                 Navigator.push(
                   context,
                   PageRouteBuilder(
                     pageBuilder: (context, animation, secondaryAnimation) => ExampleTabWithSheet(),
                     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                       const begin = Offset(1.0, 0.0); // slide from right
                       const end = Offset.zero;
                       const curve = Curves.ease;

                       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                       return SlideTransition(
                         position: animation.drive(tween),
                         child: child,
                       );
                     },
                   ),
                 );

                 // _openSearchSheet(context);
                 print("Search tapped!");
               },
             ),
           ],
         ),),
      ),
     Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                HomeTab(),
                ShowsPage(),
              ],
            ),
          ),],
      ),
         );
  }

  void _openSearchSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Search List",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // List of 1–10
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Item ${index + 1}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          // Just closes that item or handle logic
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
