import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class MicrophoneButton extends StatefulWidget {
  const MicrophoneButton({super.key});

  @override
  State<MicrophoneButton> createState() => _MicrophoneButtonState();
}

class _MicrophoneButtonState extends State<MicrophoneButton> {
  double _scale = 2;
  bool _animate = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _scale = 1.5; // Shrink the button when pressed
          _animate = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _scale = 2; // Return to normal size when released
          _animate = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _scale = 2; // Reset if the press is canceled
          _animate = false;
        });
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        child: AvatarGlow(
          // startDelay: const Duration(milliseconds: 1000),
          glowColor: Colors.blue,
          glowShape: BoxShape.circle,
          animate: _animate,
          // animate: _animate,
          curve: Curves.fastOutSlowIn,
          child: Material(
            elevation: 0,
            shape: CircleBorder(),
            color: Colors.transparent,
            child: IconButton.filled(
              padding: EdgeInsets.all(24),
              onPressed: () {

              },
              icon: Icon(Icons.mic),
              color: Colors.black,
              style: IconButton.styleFrom(
                backgroundColor:
                Colors.blue[100], // Set your desired circle color here
              ),
            ),
          ),
        ),
      ),
    );
  }
}
