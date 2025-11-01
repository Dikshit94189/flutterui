import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class DrawerPage4 extends StatelessWidget {
  const DrawerPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Profile Photo",
                style: TextStyle(color: Colors.red, fontSize: 22),
              ),
              const SizedBox(height: 20),

              /// ✅ AvatarGlow 1 (CORS-safe image)
              AvatarGlow(
                glowColor: Colors.tealAccent,
                glowShape: BoxShape.circle,
                duration: const Duration(seconds: 2),
                repeat: true,
                child: const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    // Using proxy to bypass CORS
                    'https://images.weserv.nl/?url=i.pravatar.cc/300',
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// ✅ AvatarGlow 2 (different image)
              AvatarGlow(
                glowColor: Colors.purpleAccent,
                glowShape: BoxShape.circle,
                duration: const Duration(seconds: 2),
                repeat: true,
                child: const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    // Van Heusen image via proxy (bypasses CORS)
                    'https://images.weserv.nl/?url=imagescdn.vanheusenindia.com/img/app/product/3/39946813-19334314.jpg',
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
