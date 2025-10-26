import 'package:flutter/material.dart';
import 'package:flutter_ui/main.dart';
import 'package:flutter_ui/models/tab_two%20data.dart';

class BottomTab2 extends StatelessWidget {
  BottomTab2({super.key});

  final List<DestinationData> featureDestinations = [
    // 1st object
    DestinationData(
      name: 'Santorini, Greece',
      image:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
    ),
    DestinationData(
      name: 'Kyoto, Japan',
      image: 'https://images.unsplash.com/photo-1549693578-d683be217e58?w=800',
    ),
    DestinationData(
      name: 'Bali, Indonesia',
      image:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
    ),
    DestinationData(
      name: 'Paris , France',
      image:
          'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=800',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Explore Beautiful Destinations',
                style: TextStyle(
                  fontSize: context.responsive.fontSize(12, tablet: 16 , desktop: 20),
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
            ),

            Text(
              'Discover the most amazing places around the world 🌍',
              style: TextStyle(
                fontSize: context.responsive.fontSize(10, tablet: 16 , desktop: 20),
                color: Colors.grey[700],
              ),
            ),

            Text(
              'Featured Destinations',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),





          ],
        ),
      ),
    );
  }
}
