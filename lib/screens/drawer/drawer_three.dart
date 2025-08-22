import 'package:flutter/material.dart';

class DrawerPage3 extends StatelessWidget {
  const DrawerPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drawer Page 3")),
      body: const Center(
        child: Text("This is Drawer Page 3", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
