import 'package:flutter/material.dart';

class DrawerPage4 extends StatelessWidget {
  const DrawerPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drawer Page 4")),
      body: const Center(
        child: Text("This is Drawer Page 4", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
