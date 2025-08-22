import 'package:flutter/material.dart';

class DrawerPage1 extends StatelessWidget {
  const DrawerPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drawer Page 1")),
      body: const Center(
        child: Text("This is Drawer Page 1", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
