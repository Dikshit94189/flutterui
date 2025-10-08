import 'package:flutter/material.dart';
import 'package:flutter_ui/main.dart';
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
                 print("Search tapped!");
               },
             ),
           ],
         ),
             ),
      ),


     Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                HomeTab(),
                ShowsPage(),
              ],
            ),
          ),




        ],
      ),
         );

    // return DefaultTabController(
    //   length: 2,
    //   child: Column(
    //     children: [
    //       SizedBox(
    //         height: context.responsive.height(35, tablet: 50, desktop: 60),
    //         child: TabBar(
    //           controller: _tabController,
    //           isScrollable: true,
    //           physics: const BouncingScrollPhysics(),
    //           dividerColor: Colors.transparent,
    //           indicator: const BoxDecoration(), // disable default indicator
    //           labelPadding:
    //           context.responsive.padding(2, desktop: 6, tablet: 4),
    //           tabAlignment: TabAlignment.start,
    //
    //           tabs: [
    //             // 👇 First Tab
    //             Container(
    //               padding: EdgeInsets.symmetric(
    //                 horizontal: context.responsive.width(10, tablet: 20, desktop: 30),
    //                 vertical: context.responsive.height(2, tablet: 4, desktop: 8),
    //               ),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(8),
    //                 color: _selectedIndex == 0
    //                     ? Colors.blue
    //                     : Colors.transparent,
    //                 border: Border.all(
    //                   color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
    //                   width: 1.5,
    //                 ),
    //               ),
    //               child: Row(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   Icon(Icons.home,
    //                       size: context.responsive.iconSize(10, tablet: 14 , desktop: 18),
    //                       color: _selectedIndex == 0
    //                           ? Colors.white
    //                           : Colors.grey
    //                   ),
    //                   SizedBox(
    //                       width: context.responsive
    //                           .fontSize(4, desktop: 8, tablet: 6)),
    //                   Text(
    //                     "HOME",
    //                     style: TextStyle(
    //                       fontSize: context.responsive.fontSize(10, tablet: 14 , desktop: 20),
    //                       color: _selectedIndex == 0
    //                           ? Colors.white
    //                           : Colors.grey,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //             // 👇 Second Tab
    //             Container(
    //               padding: EdgeInsets.symmetric(
    //                 horizontal: context.responsive.width(10, tablet: 20, desktop: 30),
    //                 vertical: context.responsive.height(2, tablet: 4, desktop: 8),
    //               ),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(8),
    //                 color: _selectedIndex == 1
    //                     ? Colors.blue
    //                     : Colors.transparent,
    //                 border: Border.all(
    //                   color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
    //                   width: 1.5,
    //                 ),
    //               ),
    //               child: Row(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   Icon(Icons.tv_sharp,
    //                       size: context.responsive.iconSize(10, tablet: 14 , desktop: 18),
    //                       color: _selectedIndex == 1
    //                           ? Colors.white
    //                           : Colors.grey),
    //                   SizedBox(
    //                       width: context.responsive
    //                           .fontSize(4, desktop: 8, tablet: 6)),
    //                   Text(
    //                     "SHOWS",
    //
    //                     style: TextStyle(
    //                       fontSize: context.responsive.fontSize(10, tablet: 14 , desktop: 20),
    //                       color: _selectedIndex == 1
    //                           ? Colors.white
    //                           : Colors.grey,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //
    //       Expanded(
    //         child: TabBarView(
    //           controller: _tabController,
    //           children: const [
    //             HomeTab(),
    //             ShowsPage(),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
