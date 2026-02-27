import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class DrawerPage2 extends StatelessWidget {
  const DrawerPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Animated Text Class")),

         backgroundColor: Colors.black,
        body: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Hello there 👋',
                textStyle: const TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'Welcome to Flutter World 🚀',
                textStyle: const TextStyle(
                  fontSize: 32.0,
                  color: Colors.tealAccent,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'i am good',
                textStyle: const TextStyle(
                  fontSize: 32.0,
                  color: Colors.tealAccent,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 100),
              ),
            ],
            totalRepeatCount: 2,
          ),
        ),
      ),
    );
  }
}
