import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import '../Entities/Camera.dart';

class Cameracarousel extends StatefulWidget {
  Cameracarousel({super.key});

  @override
  _CameracarouselState createState() => _CameracarouselState();
}

class _CameracarouselState extends State<Cameracarousel> {
  final uri_backyard = Uri.parse(
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4');

  // This keeps track of which video is currently being shown.
  int _currentIndex = 0;

  List<Camera> cameraList = [];

  @override
  void initState() {
    super.initState();
    cameraList = [
      Camera('CAM1-BACK', 'Backyard', Uri.parse('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4')),
      Camera('CAM2-DOOR', 'Front Door', Uri.parse('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4')),
      Camera('CAM3-DINE', 'Dining Garden', Uri.parse('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.15,
      child: CarouselSlider.builder(
        itemCount: cameraList.length,
        itemBuilder: (context, index, realIndex) {
          return CameraFootage(
            cameraName: cameraList[index].cameraName,
            locationName: cameraList[index].locationName,
            videoUrl: cameraList[index].footage.toString(),
            isActive: index == _currentIndex, // Pass whether this is the active item
          );
        },
        options: CarouselOptions(
          height: 220.0,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class CameraFootage extends StatefulWidget {
  const CameraFootage({
    super.key,
    required this.cameraName,
    required this.locationName,
    required this.videoUrl,
    required this.isActive, // To know if this item is currently active
  });

  final String videoUrl;
  final String cameraName;
  final String locationName;
  final bool isActive; // Whether this video is currently active

  @override
  _CameraFootageState createState() => _CameraFootageState();
}

class _CameraFootageState extends State<CameraFootage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        if (widget.isActive) {
          _controller.play(); // Play if this video is active
        }
      });
  }

  @override
  void didUpdateWidget(covariant CameraFootage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !_controller.value.isPlaying) {
      _controller.play(); // Start playing if it's now active
    } else if (!widget.isActive && _controller.value.isPlaying) {
      _controller.pause(); // Pause if it's no longer active
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: _controller.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
                  : Center(child: CircularProgressIndicator()), // Show loader while initializing
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.locationName,
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
                  widget.cameraName,
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
