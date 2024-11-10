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
  String? _base64Image;
  ImageProvider? _image;
  User? _user;
  final String placeholderImage = 'assets/placeholder-image.webp';
  List<dynamic> _detections = [];

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _setupImageListener(_user);
    _setupDetectionListener(_user);
  }

  void _setupImageListener(User? _user) {
    this._user = _user;
    DatabaseReference imageRef = _databaseReference.child('users/' + _user!.uid + '/Video/image');

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

  void _setupDetectionListener(User? _user) {
    this._user = _user;
    DatabaseReference detectionRef = _databaseReference.child('users/' + _user!.uid + '/Video/detection');

    detectionRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      if (data is List) {
        setState(() {
          _detections = data;
        });
      } else if (data is Map) {
        setState(() {
          _detections = [data];
        });
      } else {
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
            ? CircularProgressIndicator()
            : Stack(
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _image == null
                  ? Image.asset(placeholderImage)
                  : FadeInImage(
                placeholder: AssetImage(placeholderImage),
                image: _image!,
                fit: BoxFit.fitHeight,
                fadeInDuration: Duration(milliseconds: 300),
                fadeOutDuration: Duration(milliseconds: 300),
              ),
            ),
            CustomPaint(
              painter: BoundingBoxPainter(_detections),
              size: Size.fromHeight(0.0001),
            ),
          ],
        ),
      ),
    );
  }
}

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
        if (bbox.length == 4) {
          double x = bbox[0].toDouble();
          double y = bbox[1].toDouble();
          double width = bbox[2].toDouble();
          double height = bbox[3].toDouble();

          paint.color = detection['label'] == 'Human' ? Colors.red : Colors.green;
          canvas.drawRect(Rect.fromLTWH(x, y, width, height), paint);

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
          textPainter.paint(canvas, Offset(x, y > 10 ? y - 20 : y));
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
