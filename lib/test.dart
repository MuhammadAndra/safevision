import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseImagePage extends StatefulWidget {
  @override
  _FirebaseImagePageState createState() => _FirebaseImagePageState();
}

class _FirebaseImagePageState extends State<FirebaseImagePage> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _base64Image; // Store the base64 string
  ImageProvider? _image; // To hold the current image
  User? _user;
  final String placeholderImage = 'assets/placeholder-image.webp'; // Path to your placeholder image
  List<dynamic> _detections = []; // List to store detection data

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _setupImageListener(_user); // Set up the image listener when the widget initializes
    _setupDetectionListener(_user); // Set up detection listener
  }

  void _setupImageListener(User? _user) {
    this._user = _user;
    DatabaseReference imageRef = _databaseReference.child('users/' + _user!.uid + '/Video/image');

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

  void _setupDetectionListener(User? _user) {
    this._user = _user;
    DatabaseReference detectionRef = _databaseReference.child('users/' + _user!.uid + '/Video/detection');

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
    print(_detections);
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Image with Detections'),
      ),
      body: Center(
        child: _base64Image == null
            ? CircularProgressIndicator() // Show loading spinner while the image is being fetched
            : Stack( // Use Stack to overlay bounding boxes
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300), // Duration of the fade transition
              child: _image == null
                  ? Image.asset(placeholderImage) // Show placeholder while loading
                  : FadeInImage(
                placeholder: AssetImage(placeholderImage),
                image: _image!,
                fit: BoxFit.fitHeight,
                fadeInDuration: Duration(milliseconds: 300), // Duration of the fade-in
                fadeOutDuration: Duration(milliseconds: 300), // Duration of the fade-out
              ),
            ),
            // Overlay bounding boxes on the image
            CustomPaint(
              painter: BoundingBoxPainter(_detections),
              size: Size.fromHeight(0.0001), // Allow CustomPaint to fill the parent
            ),
          ],
        ),
      ),
    );
  }
}

// CustomPainter to draw bounding boxes
class BoundingBoxPainter extends CustomPainter {
  final List<dynamic> detections;

  BoundingBoxPainter(this.detections);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (var detection in detections) {
      if (detection['bbox'] != null) {
        List<dynamic> bbox = detection['bbox'];
        // Ensure bbox has exactly 4 elements
        if (bbox.length == 4) {
          double x = bbox[0].toDouble();
          double y = bbox[1].toDouble();
          double width = bbox[2].toDouble();
          double height = bbox[3].toDouble();

          // Draw the bounding box
          paint.color = detection['label'] == 'Human' ? Colors.red : Colors.green;
          canvas.drawRect(Rect.fromLTWH(x, y, width, height), paint);

          // Draw the label and confidence text
          final label = detection['label'];
          final confidence = (detection['confidence'] * 100).toStringAsFixed(2);
          final text = '$label ($confidence%)';
          final textStyle = TextStyle(color: paint.color, fontSize: 16);
          final textSpan = TextSpan(text: text, style: textStyle);
          final textPainter = TextPainter(
            text: textSpan,
            textDirection: TextDirection.ltr,
          );
          textPainter.layout();
          // Draw the text above the bounding box
          textPainter.paint(canvas, Offset(x, y > 10 ? y - 20 : y));
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint whenever detections change
  }
}
