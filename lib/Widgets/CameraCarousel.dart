import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Entities/Camera.dart';

// Define Camera1 as a subclass of Camera
class Camera1 extends Camera {
  Camera1(String cameraName, String locationName, ImageProvider footage)
      : super(cameraName, locationName, footage);
}

class Cameracarousel extends StatefulWidget {
  const Cameracarousel({super.key});

  @override
  _CameracarouselState createState() => _CameracarouselState();
}

class _CameracarouselState extends State<Cameracarousel> {
  List<Camera> cameraList = [];
  List<dynamic> detections = []; // List untuk menyimpan bounding box dari API

  @override
  void initState() {
    super.initState();
    fetchCameraData(); // Fetch data saat inisialisasi
  }

  Future<void> fetchCameraData() async {
    final response = await http.get(Uri.parse('YOUR_API_ENDPOINT')); // Ganti dengan URL API Anda
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        detections = data['detections']; // Ambil bounding box dari JSON
        cameraList = [
          Camera1(
              'CAM1-BACK',
              'Backyard',
              NetworkImage(data['processed_image'])), // Tampilkan processed_image dari JSON
        ];
      });
    } else {
      print('Failed to fetch camera data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.15,
      child: CarouselSlider(
        items: cameraList
            .map((camera) => cameraFootage(
                  footage: camera.footage,
                  cameraName: camera.cameraName,
                  locationName: camera.locationName,
                  detections: detections, // Kirim detections ke widget
                ))
            .toList(),
        options: CarouselOptions(
          height: 220.0,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}

class cameraFootage extends StatelessWidget {
  const cameraFootage({
    super.key,
    required this.cameraName,
    required this.locationName,
    required this.footage,
    required this.detections, // Tambahkan parameter untuk bounding box
  });

  final ImageProvider footage;
  final String cameraName;
  final String locationName;
  final List<dynamic> detections;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                image: footage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ...detections.map((detection) {
            final bbox = detection['bbox'];
            final label = detection['label'];
            final confidence = (detection['confidence'] * 100).toStringAsFixed(2);
            
            return Positioned(
              left: bbox[0].toDouble(),
              top: bbox[1].toDouble(),
              child: Container(
                width: bbox[2].toDouble(),
                height: bbox[3].toDouble(),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: label == "Human" ? Colors.red : Colors.green,
                    width: 2,
                  ),
                ),
                child: Text(
                  "$label ($confidence%)",
                  style: TextStyle(color: Colors.white, backgroundColor: Colors.black54),
                ),
              ),
            );
          }).toList(),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  locationName,
                  style: TextStyle(
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 20.0,
                        color: Color.fromARGB(180, 0, 0, 0),
                      ),
                    ],
                    fontSize: 16,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Text(
                  cameraName,
                  style: TextStyle(
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 20.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                    fontSize: 11,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
