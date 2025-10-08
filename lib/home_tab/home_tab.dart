import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/customs/button.dart';
import 'package:flutter_ui/main.dart';

// class HomeTab extends StatefulWidget {
//   const   HomeTab({super.key});
//
//   @override
//   State<HomeTab> createState() => _HomeTabState();
// }
//
// class _HomeTabState extends State<HomeTab> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child : Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 10),
//             // Responsive Container
//             Container(
//               height: context.responsive.boxHeight(0.2),
//               // width: context.responsive.boxWidth(0.8),
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               alignment: Alignment.center,
//               child: Text(
//                 "Responsive Container",
//                 style: TextStyle(
//                   fontSize: context.responsive.fontSize(
//                     14,
//                     tablet: 16,
//                     desktop: 18,
//                   ),
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Responsive Button
//             SizedBox(
//               width: context.responsive.buttonWidth(),
//               height: context.responsive.buttonHeight(),
//               child: ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.phone_android,
//                   size: context.responsive.iconSize(
//                     20,
//                     tablet: 24,
//                     desktop: 28,
//                   ),
//                 ),
//                 label: Text(
//                   "Click Me",
//                   style: TextStyle(
//                     fontSize: context.responsive.fontSize(
//                       12,
//                       tablet: 14,
//                       desktop: 16,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Example of Responsive Text
//             Text(
//               "This is responsive text!",
//               style: TextStyle(
//                 fontSize: context.responsive.fontSize(
//                   18,
//                   tablet: 20,
//                   desktop: 22,
//                 ),
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Another example: responsive icon
//             Icon(
//               Icons.computer,
//               size: context.responsive.iconSize(28, tablet: 32, desktop: 36),
//               color: Colors.green,
//             ),
//
//             Text(
//               // "CHECK",
//               context.responsive.isMobile
//                   ? "Mobile"
//                   : context.responsive.isTablet
//                   ? "tablet"
//                   : "Desktop",
//               style: TextStyle(
//                 color: Colors.red,
//                 fontSize: context.responsive.fontSize(
//                   14,
//                   tablet: 18,
//                   desktop: 22,
//                 ),
//               ),
//             ),
//
//             SizedBox(
//               height: context.responsive.height(120, tablet: 160, desktop: 200),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: 20,
//                       shrinkWrap: true,
//                       scrollDirection: Axis.horizontal,
//                       physics: BouncingScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return Container(
//                           decoration: BoxDecoration(
//                               color: Colors.blue,
//                               borderRadius: BorderRadius.circular(8)),
//                           padding: EdgeInsets.all(15),
//                           margin: EdgeInsets.all(15),
//                           height: context.responsive.height(
//                             100, // mobile
//                             tablet: 150,
//                             desktop: 200,
//                           ),
//                           width: context.responsive.width(
//                             80,
//                             tablet: 120,
//                             desktop: 150,
//                           ),
//                           child: Center(child: Text(
//                             context.responsive.isMobile ? "MOBILE" : context.responsive.isTablet ? "TAB" : "DESKTOP",
//                             style: TextStyle(fontSize: context.responsive.fontSize(12, tablet: 16 , desktop: 20)),
//                           )),
//                         );
//                         // return ListTile(title: Text(" INDEX $index"));
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             Text("data")
//
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 import 'package:cached_network_image/cached_network_image.dart';
import 'package:hive/hive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/calendar_utils.dart';
import '../utils/responsive.dart';
import '../view_model/home_views.dart';

// class HomeTab extends ConsumerWidget {
//   const HomeTab({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(imageViewModelProvider);
//
//     int _currentIndex = 0; // <-- put this in your State class if using StatefulWidget
//     final CarouselController _controller = CarouselController();
//
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 10),
//
//             /// 🔹 First Container – Show API Image (download_url)
//             state.when(
//               data: (images) {
//                 if (images.isEmpty) {
//                   return const Text("No images found");
//                 }
//
//                 return CarouselSlider(
//                   options: CarouselOptions(
//                     height: 200,
//                     enlargeCenterPage: true,
//                     autoPlay: true,
//                     aspectRatio: 16 / 9,
//                     autoPlayCurve: Curves.fastOutSlowIn,
//                     enableInfiniteScroll: true,
//                     autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                     viewportFraction: 0.9,
//                   ),
//                   items: images.map((image) {
//                     return ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: CachedNetworkImage(
//                         imageUrl: image.downloadUrl,
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                         placeholder: (context, url) =>
//                         const Center(child: CircularProgressIndicator()),
//                         errorWidget: (context, url, error) =>
//                         const Icon(Icons.error, color: Colors.red),
//                       ),
//                     );
//                   }).toList(),
//                 );
//               },
//               loading: () => const SizedBox(
//                 height: 200,
//                 child: Center(
//                   child: CircularProgressIndicator(strokeWidth: 2),
//                 ),
//               ),
//               error: (e, _) => SizedBox(
//                 height: 200,
//                 child: Center(
//                   child: Text("Error: $e"),
//                 ),
//               ),
//             )
// ,
//
//             const SizedBox(height: 20),
//
//
//             /// 🔹 Responsive Button Example
//             SizedBox(
//               width: 200,
//               height: 50,
//               child: ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.phone_android),
//                 label: const Text("Click Me"),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             /// 🔹 Example of Responsive Text
//             const Text(
//               "This is responsive text!",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             /// 🔹 Horizontal List Example
//             SizedBox(
//               height: 160,
//               child: ListView.builder(
//                 itemCount: state.hasValue ? state.value!.length : 0,
//                 scrollDirection: Axis.horizontal,
//                 physics: const BouncingScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   final image = state.value![index];
//                   return Container(
//                     margin: const EdgeInsets.all(8),
//                     width: 120,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.grey.shade200,
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: CachedNetworkImage(
//                         imageUrl: image.downloadUrl,
//                         fit: BoxFit.cover,
//                         placeholder: (context, url) => const Center(
//                           child: CircularProgressIndicator(strokeWidth: 2),
//                         ),
//                         errorWidget: (context, url, error) =>
//                         const Icon(Icons.error, color: Colors.red),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             const SizedBox(height: 20),
//             const Text("data"),
//           ],
//         ),
//       ),
//     );
//   }
// }

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;

  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;

  @override
  void initState() {
    _startAutoScroll();
    super.initState();
  }

  void _startAutoScroll() {
    const scrollSpeed = 1.0; // pixels per tick
    const interval = Duration(milliseconds: 30); // speed of scroll

    _autoScrollTimer = Timer.periodic(interval, (timer) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final current = _scrollController.offset + scrollSpeed;

        if (current >= maxScroll) {
          _scrollController.jumpTo(0); // loop back to start
        } else {
          _scrollController.jumpTo(current);
        }
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(imageViewModelProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>  [
            const SizedBox(height: 10),

            /// Carousel Slider with indicator
            state.when(
              data: (images) {
                if (images.isEmpty) return const Text("No images found");

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                CarouselSlider(
                items: images.map((image) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: image.downloadUrl,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                height: context.responsive.height(150, tablet: 200, desktop: 250),
                aspectRatio: context.responsive.width(16/9, tablet: 4/3, desktop: 16/7),
                enlargeCenterPage: true,
                autoPlay: true,
                onPageChanged: (index, reason) {
                setState(() {
                _currentIndex = index;
                });
                },
                ),
                carouselController: _controller, // Use carouselController in v5.x
                ),
                    const SizedBox(height: 12),

                    AnimatedSmoothIndicator(
                      activeIndex: _currentIndex,
                      count: images.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Colors.blue,
                        dotColor: Colors.grey.shade400,
                      ),
                      onDotClicked: (index) {
                        _controller.jumpToPage(index); // works now
                      },
                    ),
                  ],
                );
              },
              loading: () => const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SizedBox(
                height: 200,
                child: Center(child: Text("Error: $e")),
              ),
            ),

            const SizedBox(height: 20),
            // ...rest of your widgets


            /// 🔹 Responsive Button Example
        // wherever you build your button
        // (uses your Responsive class for the button’s size only)


              SizedBox(height: 20),

            Padding(
              padding: Responsive(context).symmetric(
                16,  // mobile horizontal
                12,  // mobile vertical
                tabletH: 24, // tablet horizontal
                tabletV: 20, // tablet vertical
                desktopH: 40, // desktop horizontal
                desktopV: 32, // desktop vertical
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Builder(
                          builder: (btnCtx) => SizedBox(
                            width: Responsive(btnCtx).boxWidth(0.5), // 50% width of screen
                            // width: Responsive(btnCtx).width(200, tablet: 250, desktop: 300),
                            height: Responsive(btnCtx).height(50, tablet: 60, desktop: 70),
                            child: ZomatoButton(
                              title:'Date Picker',
                              onTap: () async {
                                final selected = await showCalendarPicker(
                                  context: btnCtx, // IMPORTANT: pass the *button* context
                                  initialDateTime: DateTime.now(),
                                  minimumDateTime: DateTime(2020, 1, 1),
                                  maximumDateTime: DateTime(2030, 12, 31),
                                  mode: CupertinoCalendarMode.date, // use .dateTime to include time
                                  onDateTimeChanged: (dt) => debugPrint('Touched: $dt'),
                                  // selectableDayPredicate: (d) => d.isAfter(DateTime.now()), // example
                                );
                                if (selected != null) {
                                  debugPrint('Final date picked: $selected');
                                }
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: context.responsive.width(
                          12,       // mobile
                          tablet: 20,
                          desktop: 32,
                        ),
                      ),
                      Expanded(
                        child: Builder(
                          builder: (btnCtx) => SizedBox(
                            width: Responsive(btnCtx).boxWidth(0.5), // 50% width of screen
                            height: Responsive(btnCtx).height(50, tablet: 60, desktop: 70),
                            child: Container(
                               decoration: BoxDecoration(
                                color: Colors.redAccent, // Zomato-like color
                                borderRadius: BorderRadius.circular(12),
                              ),
                                child: DefaultTextStyle(
                                  style:   TextStyle(
                                    fontSize: context.responsive.fontSize(12, tablet: 16 , desktop: 20),
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 7.0,
                                        color: Colors.white,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: AnimatedTextKit(
                                      repeatForever: true,
                                      animatedTexts: [
                                        FlickerAnimatedText('Flicker Frenzy' ),
                                        FlickerAnimatedText('Night Vibes On'),
                                        FlickerAnimatedText("C'est La Vie !"),
                                      ],
                                      onTap: () {
                                        print("Tap Event");
                                      },
                                    ),
                                  ),
                                ),
                            )
                          ),
                        ),
                      )
                      ,

                    ],
                  ),

                  SizedBox(
                    height: Responsive(context).heights(
                      12,       // mobile
                      tablet: 20,
                      desktop: 32,
                    ),
                  ),



                ],
              ),
            ),

            Padding(
              padding: Responsive(context).symmetric(
                16,  // mobile horizontal
                12,  // mobile vertical
                tabletH: 24, // tablet horizontal
                tabletV: 20, // tablet vertical
                desktopH: 40, // desktop horizontal
                desktopV: 32, // desktop vertical
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  /// 🔹 Example of Responsive Text
                  const Text(
                    "HEy Folks  \n Developers",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🔹 Horizontal List Example
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.hasValue ? state.value!.length : 0,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final image = state.value![index];
                        return Container(
                          margin: const EdgeInsets.all(8),
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: image.downloadUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                        );
                      },
                    ),
                  ),


                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
