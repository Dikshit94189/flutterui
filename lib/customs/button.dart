import 'package:flutter/material.dart';
import 'package:flutter_ui/main.dart';

class ZomatoButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ZomatoButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding:     EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.redAccent, // Zomato-like color
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style:   TextStyle(
            color: Colors.white,
            fontSize: context.responsive.fontSize(12, tablet: 16 , desktop: 20),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
