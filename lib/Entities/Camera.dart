import 'package:flutter/cupertino.dart';

class Camera {
  String cameraName;
  String locationName;
  ImageProvider? footage;
  List<dynamic> detections;

  Camera(this.cameraName, this.locationName, this.footage, this.detections);
}