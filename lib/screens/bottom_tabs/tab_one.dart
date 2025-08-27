import 'package:flutter/material.dart';
import 'package:flutter_ui/main.dart';
import '../../home_tab/home_tab.dart';
import '../../home_tab/show_tabs.dart';

class BottomTab1 extends StatelessWidget {
  const BottomTab1({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // optional

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10), // <-- match container padding
              child: TabBar(
                physics: const BouncingScrollPhysics(),
                isScrollable: true,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: Colors.blue, // selected tab background
                  borderRadius: BorderRadius.circular(8),
                ),
                labelColor: Colors.white, // selected text/icon
                unselectedLabelColor: Colors.black, // unselected text/icon
                // labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                tabs:   [
                  Row(
                    children: [
                      SizedBox(width: context.responsive.fontSize(10 , tablet: 14 ,desktop: 18)),
                      Icon(Icons.home),
                      SizedBox(width: 10),
                      Tab(
                         text: "HOME",
                      ),
                      SizedBox(width: context.responsive.fontSize(10 , tablet: 14 ,desktop: 18)),
                    ],
                  ),
                  Row(
                    children: [
                      // SizedBox(width: context.responsive.fontSize(10 , tablet: 14 ,desktop: 18)),
                      Icon(Icons.tv_sharp),
                      SizedBox(width: 10),
                      Tab(
                         text: "SHOWS",
                      ),
                      // SizedBox(width: context.responsive.fontSize(10 , tablet: 14 ,desktop: 18)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            HomeTab(),
            ShowsPage(),
          ],
        ),
      ),
    );
  }
}

