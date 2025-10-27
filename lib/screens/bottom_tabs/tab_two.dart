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

  final List<Map<String, String>> popularPlaces = const [
    {
      'title': 'Machu Picchu',
      'location': 'Peru',
      'image':
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
    },
    {
      'title': 'Great Wall',
      'location': 'China',
      'image':
      'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=800',
    },
    {
      'title': 'Eiffel Tower',
      'location': 'France',
      'image':
      'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=800',
    },
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
                  fontSize: context.responsive.fontSize(
                    12,
                    tablet: 16,
                    desktop: 20,
                  ),
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
            ),

            Text(
              'Discover the most amazing places around the world 🌍',
              style: TextStyle(
                fontSize: context.responsive.fontSize(
                  10,
                  tablet: 16,
                  desktop: 20,
                ),
                color: Colors.grey[700],
              ),
            ),

            Text(
              'Featured Destinations',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: context.responsive.height(150, tablet: 250, desktop: 360),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: featureDestinations.length,
                itemBuilder: (context, index) {
                  final place = featureDestinations[index];
                  return Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Image.network(
                        place.image,
                        width: context.responsive.height(150, tablet: 250, desktop: 360),
                        fit: BoxFit.cover,
                      ),
                      Container(
                        // width: isDesktop ? 300 : 240,
                        width: context.responsive.height(150, tablet: 250, desktop: 360),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                            ],
                            // begin: Alignment.bottomCenter,
                            // end: Alignment.topCenter,
                          ),
                        ),
                        child: Text(
                          place.name,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 40),

            // 🔹 POPULAR PLACES LIST
            Text(
              'Popular Places',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: popularPlaces.length,
              itemBuilder: (context, index) {
                final place = popularPlaces[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        // flex: isDesktop ? 2 : 3,
                        child: Image.network(
                          place['image']!,
                          // height: isDesktop ? 180 : 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                place['title']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                place['location']!,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'A must-visit destination with rich culture and breathtaking scenery.',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),



          ],
        ),
      ),
    );
  }
}
