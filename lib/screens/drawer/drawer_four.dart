import 'package:avatar_glow/avatar_glow.dart' show AvatarGlow;
import 'package:flutter/material.dart';

class DrawerPage4 extends StatelessWidget {
  const DrawerPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [

          Column(
            children: [
              Text("Profile Photo" , style: TextStyle(color: Colors.red)),
              SizedBox(height: 10),
              AvatarGlow(
                glowColor: Colors.tealAccent,
                // endRadius: 120.0,
                duration  : const Duration(seconds: 2),
                repeat: true,
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    "https://i.pravatar.cc/300",
                  ),
                ),
              ),

            ],
          )


        ],
      ),
    );
  }
}
