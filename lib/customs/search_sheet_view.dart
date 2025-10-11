import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExampleTabWithSheet extends StatefulWidget {
  const ExampleTabWithSheet({super.key});

  @override
  State<ExampleTabWithSheet> createState() => _ExampleTabWithSheetState();
}

class _ExampleTabWithSheetState extends State<ExampleTabWithSheet>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }



