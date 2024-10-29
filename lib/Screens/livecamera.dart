import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:safevision/Entities/Camera.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';

class Livecamera extends StatelessWidget {
  Livecamera({super.key});
  final uri_backyard = Uri.parse('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4');

  @override
  Widget build(BuildContext context) {
    List<Camera> cameraList = [
      Camera('CAM1-BACK', 'Backyard', uri_backyard), // Ganti URL ini dengan URL video yang sesuai
      Camera('CAM2-DOOR', "Front Door", uri_backyard), // Ganti URL ini dengan URL video yang sesuai
      Camera('CAM3-DINE', 'Dining Garden', uri_backyard), // Ganti URL ini dengan URL video yang sesuai
    ];

    return Scaffold(
      appBar: Appbarwidget(
        title: 'Live Camera',
        subtitle: '${cameraList.length} Devices connected',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: cameraList
                .map((camera) => CameraFootage(
              videoUrl: camera.footage,
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

class CameraFootage extends StatefulWidget {
  const CameraFootage({
    super.key,
    required this.cameraName,
    required this.locationName,
    required this.videoUrl,
  });

  final Uri videoUrl;
  final String cameraName;
  final String locationName;

  @override
  _CameraFootageState createState() => _CameraFootageState();
}

class _CameraFootageState extends State<CameraFootage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Refresh UI setelah video diinisialisasi
        _controller.play(); // Mulai memutar video secara otomatis
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Pastikan untuk membebaskan controller
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
            child: _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : Center(child: CircularProgressIndicator()), // Loader saat video sedang diinisialisasi
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
                    fontSize: 24,
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
                    fontSize: 14,
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
