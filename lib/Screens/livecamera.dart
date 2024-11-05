import 'package:flutter/material.dart';
import 'package:safevision/Entities/Camera.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:safevision/Widgets/CameraFootage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Livecamera extends StatefulWidget {
  const Livecamera({super.key});

  @override
  State<Livecamera> createState() => _LivecameraState();
}

class _LivecameraState extends State<Livecamera> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  List<dynamic> _detections = [];
  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  String? _base64Image; // Store the base64 string
  ImageProvider? _image; // To hold the current image

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _setupImageListener(); // Set up the image listener when the widget initializes
    _setupDetectionListener();
  }

  void _setupImageListener() {
    DatabaseReference imageRef = _databaseReference
        .child('users/' + _user!.uid + '/Video/image');

    // Listen for changes in the database reference
    imageRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as String?;
      if (data != null) {
        String newImageData = data.substring(23);
        // Update the image in a way that avoids flickering
        setState(() {
          _base64Image = newImageData; // Store the new base64 string
          _image = MemoryImage(
              base64Decode(newImageData)); // Update the image provider
        });
      }
    }).onError((error) {
      print('Failed to load image: $error');
    });
  }

  void _setupDetectionListener() {
    DatabaseReference detectionRef = _databaseReference
        .child('users/' + _user!.uid + '/Video/detection');

    // Listen for changes in the detection reference
    detectionRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      // Check if data is a List or Map
      if (data is List) {
        setState(() {
          _detections = data; // Update detections if it's a List
        });
      } else if (data is Map) {
        // If data is a Map, wrap it in a list
        setState(() {
          _detections = [data]; // Wrap the map in a list
        });
      } else {
        // Reset detections if data is neither List nor Map
        setState(() {
          _detections = [];
        });
      }
    }).onError((error) {
      print('Failed to load detection data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Camera> cameraList = [
      Camera('CAM1-BACK', 'Backyard', _image, _detections
          // NetworkImage(
          //     "https://www.redfin.com/blog/wp-content/uploads/2020/05/3_Backyard-Oasis-Ideas.jpg"),
          ),
      Camera(
          'CAM2-DOOR',
          "Front Door",
          NetworkImage(
              "https://www.thespruce.com/thmb/FcehVxm-Y0dfnttD-IhhVTm9Pwc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/298815228_170632415484129_1384064757048194521_n-5aa965d810fe43559536e0996cea381e.jpg"),
      [],
      ),
      Camera(
          'CAM3-DINE',
          'Dining Garden',
          NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSE1yBc50JXnLXGb7o7wrIPlP7olbDZmsGbkQ&s"),
        [],
      ),
    ];

    return Scaffold(
      appBar: Appbarwidget(
        title: 'Live Camera',
        subtitle: '${cameraList.length} Devices connected',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: cameraList
                .map((camera) => cameraFootage(
                      footage: camera.footage,
                      cameraName: camera.cameraName,
                      locationName: camera.locationName,
                      detections: camera.detections,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
