import 'package:flutter/cupertino.dart';

class Responsive {
  final BuildContext context;
  late double screenWidth;
  late double screenHeight;

  Responsive(this.context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
  }

  // Device Type Checks
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;

  /// Font size that adapts with ternary operator
  double fontSize(double mobile, {double? tablet, double? desktop}) {
    if (isMobile) return mobile;
    if (isTablet) return tablet ?? mobile * 1.2;
    return desktop ?? mobile * 1.5;
  }

  double height(double mobile , {double? tablet , double? desktop}){
    if (isTablet && tablet != null) return tablet;
    if (isDesktop && desktop != null) return desktop;
    return mobile;
  }

  double width(double mobile , {double? tablet , double? desktop}){
    if(isTablet && tablet != null) return tablet;
    if(isDesktop && desktop != null) return desktop;
    return mobile;
  }

  /// Padding based on device type
  EdgeInsets padding(double mobile, {double? tablet, double? desktop}) {
    if (isMobile) return EdgeInsets.all(mobile);
    if (isTablet) return EdgeInsets.all(tablet ?? mobile * 1.5);
    return EdgeInsets.all(desktop ?? mobile * 2);
  }

  /// heights size
  double heights(double mobile , {double? tablet , double? desktop}) {
    if (isMobile) return mobile;
    if (isTablet) return tablet ?? mobile * 1.5;
    return desktop ?? mobile * 2;
  }

  /// Icon size
  double iconSize(double mobile, {double? tablet, double? desktop}) {
    if (isMobile) return mobile;
    if (isTablet) return tablet ?? mobile * 1.3;
    return desktop ?? mobile * 1.6;
  }

  /// Responsive Box Dimensions (percentage based)
  double boxWidth(double percent) => screenWidth * percent;
  double boxHeight(double percent) => screenHeight * percent;

  /// Button width & height
  double buttonWidth({double percent = 0.6}) => screenWidth * percent;
  double buttonHeight({double percent = 0.07}) => screenHeight * percent;


  EdgeInsets symmetric(double mobileH, double mobileV, {double? tabletH, double? tabletV, double? desktopH, double? desktopV}) {
    if (isTablet) {
      return EdgeInsets.symmetric(
        horizontal: tabletH ?? mobileH * 1.5,
        vertical: tabletV ?? mobileV * 1.5,
      );
    }
    if (isDesktop) {
      return EdgeInsets.symmetric(
        horizontal: desktopH ?? mobileH * 2,
        vertical: desktopV ?? mobileV * 2,
      );
    }
    return EdgeInsets.symmetric(horizontal: mobileH, vertical: mobileV);
  }


}