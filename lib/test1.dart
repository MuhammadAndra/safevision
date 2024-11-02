import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseImagePage extends StatefulWidget {
  @override
  _FirebaseImagePageState createState() => _FirebaseImagePageState();
}

class _FirebaseImagePageState extends State<FirebaseImagePage> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  String? _base64Image;  // Store the base64 string
  ImageProvider? _image; // To hold the current image
  final String placeholderImage = 'assets/placeholder.png'; // Path to your placeholder image

  @override
  void initState() {
    super.initState();
    _setupImageListener();  // Set up the image listener when the widget initializes
  }

  void _setupImageListener() {
    DatabaseReference imageRef = _databaseReference.child('users/2dK2t8Zyg5RJloifZrIX1b9AOXQ2/Video/image');

    // Listen for changes in the database reference
    imageRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as String?;
      if (data != null) {
        String newImageData = data.substring(23);
        // Update the image in a way that avoids flickering
        setState(() {
          _base64Image = newImageData; // Store the new base64 string
          _image = MemoryImage(base64Decode(newImageData)); // Update the image provider
        });
      }
    }).onError((error) {
      print('Failed to load image: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Image'),
      ),
      body: Center(
        child: _base64Image == null
            ? CircularProgressIndicator()  // Show loading spinner while the image is being fetched
            : AnimatedSwitcher(
          duration: Duration(milliseconds: 300), // Duration of the fade transition
          child: _image == null
              ? Image.asset(placeholderImage) // Show placeholder while loading
              : FadeInImage(
            placeholder: AssetImage(placeholderImage),
            image: _image!,
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 300), // Duration of the fade-in
            fadeOutDuration: Duration(milliseconds: 300), // Duration of the fade-out
          ),
        ),
      ),
    );
  }
}