import 'package:flutter/cupertino.dart';

class Camera {
  String cameraName;
  String locationName;
  ImageProvider footage;

  Camera(this.cameraName, this.locationName, this.footage);
}