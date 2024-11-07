import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

import '../Entities/Camera.dart';

class Cameracarousel extends StatefulWidget {
  const Cameracarousel({super.key});

  @override
  State<Cameracarousel> createState() => _CameracarouselState();
}

class _CameracarouselState extends State<Cameracarousel> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  String? _base64Image; // Store the base64 string
  //ImageProvider? _image; // To hold the current image
  late ImageProvider _image;
  final String placeholderImage =
      'assets/placeholder.png'; // Path to your placeholder image

  @override
  void initState() {
    super.initState();
    _setupImageListener(); // Set up the image listener when the widget initializes
  }

  void _setupImageListener() {
    DatabaseReference imageRef = _databaseReference
        .child('users/2dK2t8Zyg5RJloifZrIX1b9AOXQ2/Video/image');

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

  @override
  Widget build(BuildContext context) {
    List<Camera> cameraList = [
      Camera(
        'CAM1-BACK',
        'Backyard',
        _image,
        // NetworkImage(
        //   "https://www.redfin.com/blog/wp-content/uploads/2020/05/3_Backyard-Oasis-Ideas.jpg",
        // ),
      ),
      Camera(
          'CAM2-DOOR',
          "Front Door",
          NetworkImage(
              "https://www.thespruce.com/thmb/FcehVxm-Y0dfnttD-IhhVTm9Pwc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/298815228_170632415484129_1384064757048194521_n-5aa965d810fe43559536e0996cea381e.jpg")),
      Camera(
          'CAM3-DINE',
          'Dining Garden',
          NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSE1yBc50JXnLXGb7o7wrIPlP7olbDZmsGbkQ&s")),
    ];

    return Transform.scale(
      scale: 1.15,
      child: CarouselSlider(
        items: cameraList
            .map((camera) => cameraFootage(
                  footage: camera.footage,
                  cameraName: camera.cameraName,
                  locationName: camera.locationName,
                ))
            .toList(),
        //1st Image of Slider
        // Container(
        //   // margin: EdgeInsets.all(1.0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(30.0),
        //     image: DecorationImage(
        //       image: NetworkImage("https://www.redfin.com/blog/wp-content/uploads/2020/05/3_Backyard-Oasis-Ideas.jpg"),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        //
        // //2nd Image of Slider
        // Container(
        //   // margin: EdgeInsets.all(6.0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(30.0),
        //     image: DecorationImage(
        //       image: NetworkImage("https://www.thespruce.com/thmb/FcehVxm-Y0dfnttD-IhhVTm9Pwc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/298815228_170632415484129_1384064757048194521_n-5aa965d810fe43559536e0996cea381e.jpg"),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        //
        // //3rd Image of Slider
        // Container(
        //   // margin: EdgeInsets.all(6.0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(30.0),
        //     image: DecorationImage(
        //       image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSE1yBc50JXnLXGb7o7wrIPlP7olbDZmsGbkQ&s"),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),

        //Slider Container properties
        options: CarouselOptions(
          height: 220.0,
          enlargeCenterPage: true,
          // enlargeFactor: 0.5,
          // autoPlay: true,
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
  const cameraFootage(
      {super.key,
      required this.cameraName,
      required this.locationName,
      required this.footage});

  final ImageProvider footage;
  final String cameraName;
  final String locationName;

  @override
  Widget build(BuildContext context) {
    final String placeholderImage = 'assets/placeholder.png';
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Stack(children: [
        // AnimatedSwitcher(
        //   duration: Duration(milliseconds: 300), // Durasi transisi fade
        //   child: footage == null
        //       ? ClipRRect(
        //           borderRadius: BorderRadius.circular(30.0),
        //           child: Image.asset(
        //             placeholderImage,
        //             width: double.infinity,
        //             height: 200,
        //             fit: BoxFit.cover,
        //           ),
        //         )
        //       : ClipRRect(
        //           borderRadius: BorderRadius.circular(30.0),
        //           child: FadeInImage(
        //             placeholder: AssetImage(placeholderImage),
        //             image: footage,
        //             width: double.infinity,
        //             height: 200,
        //             fit: BoxFit.cover,
        //             fadeInDuration:
        //                 Duration(milliseconds: 300), // Durasi fade-in
        //             fadeOutDuration:
        //                 Duration(milliseconds: 300), // Durasi fade-out
        //           ),
        //         ),
        // ),
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
                    color: Colors.white),
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
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
