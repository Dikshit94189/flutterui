import 'package:flutter/material.dart';

class ModeTracker extends StatefulWidget {
  const ModeTracker({super.key});

  @override
  State<ModeTracker> createState() => _ModeTrackerState();
}

class _ModeTrackerState extends State<ModeTracker> {
  String selectedMood = "Happy 😊";
  Color moodColor = Colors.orangeAccent;

  final List<Map<String, dynamic>> moods = [
    {"name": "Happy 😊", "color": Colors.orangeAccent},
    {"name": "Sad 😢", "color": Colors.blueAccent},
    {"name": "Excited 🤩", "color": Colors.pinkAccent},
    {"name": "Tired 😴", "color": Colors.teal},
    {"name": "Angry 😡", "color": Colors.redAccent},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: moodColor.withOpacity(0.15),
      appBar: AppBar(
        backgroundColor: moodColor,
        title: const Text(
          "Mood Tracker",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated card for selected mood
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                height: size.width * 0.5,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: moodColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: moodColor.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    selectedMood,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                "How are you feeling today?",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // Mood Buttons
              Wrap(
                spacing: 15,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: moods.map((mood) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMood = mood["name"];
                        moodColor = mood["color"];
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: selectedMood == mood["name"]
                            ? mood["color"].withOpacity(0.8)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: mood["color"], width: 2),
                      ),
                      child: Text(
                        mood["name"].split(" ").last, // show only emoji
                        style: TextStyle(
                          fontSize: 28,
                          color: selectedMood == mood["name"]
                              ? Colors.white
                              : mood["color"],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 40),

              // Save Mood Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'mood': selectedMood,
                    'color': moodColor,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: moodColor,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Save Mood",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
