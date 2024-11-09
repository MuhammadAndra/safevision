import 'package:flutter/material.dart';
import 'package:safevision/Widgets/BoundingBoxPainter.dart';

class cameraFootage extends StatelessWidget {
  cameraFootage({
    super.key,
    required this.cameraName,
    required this.locationName,
    required this.footage,
    required this.detections,
    required this.width
  });

  final ImageProvider? footage;
  final double width;
  final String cameraName;
  final String locationName;
  List<dynamic> detections = [];

  @override
  Widget build(BuildContext context) {
    final String placeholderImage = 'assets/placeholder-image.webp';
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Stack(children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300), // Durasi transisi fade
          child: footage == null
              ? Center(child: CircularProgressIndicator())
              : ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Stack(children: [
                    FadeInImage(
                      placeholder: AssetImage(placeholderImage),
                      image: footage!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 300),
                      // Durasi fade-in
                      fadeOutDuration:
                          Duration(milliseconds: 300), // Durasi fade-out
                    ),
                    Container(
                      width: width,
                      height: 6.2,
                      child: CustomPaint(
                        painter: BoundingBoxPainter(detections, 10, 15),
                        size: Size.fromHeight(
                            0.0001), // Allow CustomPaint to fill the parent
                      ),
                    ),
                  ]),
                ),
        ),
        // Container(
        //   width: double.infinity,
        //   height: 200,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(30.0),
        //     image: DecorationImage(
        //       image: footage,
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
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
