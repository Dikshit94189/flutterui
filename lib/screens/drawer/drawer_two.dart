import 'package:flutter/material.dart';

class DrawerPage2 extends StatelessWidget {
  const DrawerPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drawer Page 2")),
      body: const Center(
        child: Text("This is Drawer Page 2", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
