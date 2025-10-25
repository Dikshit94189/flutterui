import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pedometer/pedometer.dart';

import '../permission_handler/permission_helper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../utils/responsive.dart';

class ShowsPage extends StatefulWidget {
  const ShowsPage({super.key});

  @override
  State<ShowsPage> createState() => _ShowsPageState();
}

class _ShowsPageState extends State<ShowsPage> {
  late Box stepsBox;
  Map<String, int> stepsData = {};
  int stepCount = 0;
  late Stream<StepCount> _stepCountStream;

  @override
  void initState() {
    super.initState();
    stepsBox = Hive.box("LocalStorage");
    _loadSteps();
    _initPedometer();
  }

  // Today's date as string
  String _todayDate() {
    final now = DateTime.now();
    return "${now.year}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}";
  }

  // Load steps from Hive
  void _loadSteps() {
    final keys = stepsBox.keys.cast<String>();
    final Map<String, int> tempData = {};
    for (var key in keys) {
      tempData[key] = (stepsBox.get(key) ?? 0) as int;
    }
    setState(() {
      stepsData = tempData;
      stepCount = stepsData[_todayDate()] ?? 0;
    });
  }

  // Save step count for today
  void _saveStep(String date, int count) {
    stepsBox.put(date, count);
    _loadSteps();
  }

  // Initialize pedometer
  void _initPedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount).onError((error) {
      print("Pedometer error: $error");
    });
  }

  // Called every time step count changes
  void _onStepCount(StepCount event) {
    String today = _todayDate();
    // Save the total steps for today
    setState(() {
      stepCount = event.steps;
      stepsData[today] = stepCount;
      _saveStep(today, stepCount);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> sortedDates = stepsData.keys.toList()..sort();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Step Tracker'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "Today's Steps: $stepCount",
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 30),
            const Text(
              "Steps per Day:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sortedDates.length,
                itemBuilder: (context, index) {
                  String date = sortedDates[index];
                  int steps = stepsData[date]!;
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          date.split('-').sublist(1).join('/'),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "$steps steps",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}