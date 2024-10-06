import 'package:flutter/material.dart';
import 'package:safevision/Entities/Camera.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';

class Livecamera extends StatelessWidget {
  const Livecamera({super.key});

  @override
  Widget build(BuildContext context) {
    List<Camera> cameraList = [
      Camera(
          'CAM1-BACK',
          'Backyard',
          NetworkImage(
              "https://www.redfin.com/blog/wp-content/uploads/2020/05/3_Backyard-Oasis-Ideas.jpg")),
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

    // Camera cam1 = Camera('CAM1-BACK', 'Backyard', NetworkImage("https://www.redfin.com/blog/wp-content/uploads/2020/05/3_Backyard-Oasis-Ideas.jpg"));
    // Camera cam2 = Camera('CAM2-DOOR', "Front Door", NetworkImage("https://www.redfin.com/blog/wp-content/uploads/2020/05/3_Backyard-Oasis-Ideas.jpg"));
    // Camera cam3 = Camera('CAM3-DINE', 'Dining Room', NetworkImage("https://www.redfin.com/blog/wp-content/uploads/2020/05/3_Backyard-Oasis-Ideas.jpg"));

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
                    ))
                .toList(),

          ),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Stack(children: [
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
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Text(
                cameraName,
                style: TextStyle(shadows: <Shadow>[
                  Shadow(
                    offset: Offset(3.0, 3.0),
                    blurRadius: 20.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ], fontSize: 14,
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
