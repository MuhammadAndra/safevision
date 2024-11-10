import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseImagePage extends StatefulWidget {
  @override
  _FirebaseImagePageState createState() => _FirebaseImagePageState();
}

class _FirebaseImagePageState extends State<FirebaseImagePage> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  String? _base64Image;
  ImageProvider? _image;
  final String placeholderImage = 'assets/placeholder.png';

  @override
  void initState() {
    super.initState();
    _setupImageListener();
  }

  void _setupImageListener() {
    DatabaseReference imageRef = _databaseReference.child('users/2dK2t8Zyg5RJloifZrIX1b9AOXQ2/Video/image');

    imageRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as String?;
      if (data != null) {
        String newImageData = data.substring(23);
        setState(() {
          _base64Image = newImageData;
          _image = MemoryImage(base64Decode(newImageData));
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
            ? CircularProgressIndicator()
            : AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _image == null
              ? Image.asset(placeholderImage)
              : FadeInImage(
            placeholder: AssetImage(placeholderImage),
            image: _image!,
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 300),
            fadeOutDuration: Duration(milliseconds: 300),
          ),
        ),
      ),
    );
  }
}