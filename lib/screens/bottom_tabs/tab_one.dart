import 'package:flutter/material.dart';
import 'package:flutter_ui/main.dart';
import '../../utils/responsive.dart';

class BottomTab1 extends StatelessWidget {
  const BottomTab1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Responsive UI",
          style: TextStyle(
            fontSize: context.responsive.fontSize(16, tablet: 18, desktop: 20),
          ),
        ),
      ),
      body: Padding(
        padding: context.responsive.padding(12, tablet: 16, desktop: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
              context.responsive.isMobile ? "Mobile" :
                  context.responsive.isTablet ? "tablet" : "Desktop"
              ,
              style: TextStyle(
                color: Colors.red,
                fontSize: context.responsive.fontSize(
                  14,
                  tablet: 18,
                  desktop: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
