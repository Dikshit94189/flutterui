import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DrawerPage3 extends StatelessWidget {
  const DrawerPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text("Flutter Animate Demo ⚡")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Hello Flutter!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            )
                .animate()
                .fadeIn(duration: 800.ms)
                .scale(duration: 400.ms)
                .then(delay: 300.ms)
                .shake(),

            const SizedBox(height: 30),

            // ❤️ Heartbeat animation that repeats
            Animate(
              effects: [
                ScaleEffect(
                  duration: 700.ms,
                  curve: Curves.easeOutBack,
                ),
              ],
              onPlay: (controller) => controller.repeat(reverse: true),
              child: const Icon(Icons.favorite, size: 80, color: Colors.pink),
            ),
          ],
        ),
      ),
    );
  }
}
