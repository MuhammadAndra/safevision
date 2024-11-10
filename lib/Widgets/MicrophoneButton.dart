import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class MicrophoneButton extends StatefulWidget {
  const MicrophoneButton({super.key});

  @override
  State<MicrophoneButton> createState() => _MicrophoneButtonState();
}

class _MicrophoneButtonState extends State<MicrophoneButton> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  double _scale = 2;
  bool _animate = false;

  @override
  void initState() {
    _user = _auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _scale = 1.5;
          _animate = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _scale = 2;
          _animate = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _scale = 2;
          _animate = false;
        });
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        child: AvatarGlow(
          glowColor: Colors.blue,
          glowShape: BoxShape.circle,
          animate: _animate,
          curve: Curves.fastOutSlowIn,
          child: Material(
            elevation: 0,
            shape: CircleBorder(),
            color: Colors.transparent,
            child: IconButton.filled(
              padding: EdgeInsets.all(24),
              onPressed: () {
                recordToFirebase();
              },
              icon: Icon(Icons.mic),
              color: Colors.black,
              style: IconButton.styleFrom(
                backgroundColor:
                Colors.blue[100],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void recordToFirebase() {
    DatabaseReference databaseRef = _databaseReference.child('users/' + _user!.uid + '/Microphone');
    DateTime currentDate = DateTime.now();

    databaseRef.push().set({
      'sound': 'empty',
      'timestamp': currentDate.toString(),
    }).then((_) {
      print('Image added successfully!');
    }).catchError((error) {
      print('Failed to add image: $error');
    });
  }
}
