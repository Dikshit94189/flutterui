import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/main.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            // Responsive Container
            Container(
              height: context.responsive.boxHeight(0.2),
              // width: context.responsive.boxWidth(0.8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                "Responsive Container",
                style: TextStyle(
                  fontSize: context.responsive.fontSize(
                    14,
                    tablet: 16,
                    desktop: 18,
                  ),
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Responsive Button
            SizedBox(
              width: context.responsive.buttonWidth(),
              height: context.responsive.buttonHeight(),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.phone_android,
                  size: context.responsive.iconSize(
                    20,
                    tablet: 24,
                    desktop: 28,
                  ),
                ),
                label: Text(
                  "Click Me",
                  style: TextStyle(
                    fontSize: context.responsive.fontSize(
                      12,
                      tablet: 14,
                      desktop: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Example of Responsive Text
            Text(
              "This is responsive text!",
              style: TextStyle(
                fontSize: context.responsive.fontSize(
                  18,
                  tablet: 20,
                  desktop: 22,
                ),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Another example: responsive icon
            Icon(
              Icons.computer,
              size: context.responsive.iconSize(28, tablet: 32, desktop: 36),
              color: Colors.green,
            ),

            Text(
              // "CHECK",
              context.responsive.isMobile
                  ? "Mobile"
                  : context.responsive.isTablet
                  ? "tablet"
                  : "Desktop",
              style: TextStyle(
                color: Colors.red,
                fontSize: context.responsive.fontSize(
                  14,
                  tablet: 18,
                  desktop: 22,
                ),
              ),
            ),

            SizedBox(
              height: context.responsive.height(120, tablet: 160, desktop: 200),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 20,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.all(15),
                          height: context.responsive.height(
                            100, // mobile
                            tablet: 150,
                            desktop: 200,
                          ),
                          width: context.responsive.width(
                            80,
                            tablet: 120,
                            desktop: 150,
                          ),
                          child: Center(child: Text(
                            context.responsive.isMobile ? "MOBILE" : context.responsive.isTablet ? "TAB" : "DESKTOP",
                            style: TextStyle(fontSize: context.responsive.fontSize(12, tablet: 16 , desktop: 20)),
                          )),
                        );
                        // return ListTile(title: Text(" INDEX $index"));
                      },
                    ),
                  ),
                ],
              ),
            ),

            Text("data")

          ],
        ),
      ),
    );
  }
}
