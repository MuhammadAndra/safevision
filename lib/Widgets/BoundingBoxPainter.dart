import 'package:flutter/material.dart';

class BoundingBoxPainter extends CustomPainter {
  final List<dynamic> detections;
  final double imageWidth; // Add the original image width
  final double imageHeight; // Add the original image height

  BoundingBoxPainter(this.detections, this.imageWidth, this.imageHeight);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Calculate scaling factors for width and height
    double scaleX = size.width / imageWidth;
    double scaleY = size.height / imageHeight;

    for (var detection in detections) {
      if (detection['bbox'] != null) {
        List<dynamic> bbox = detection['bbox'];
        // Ensure bbox has exactly 4 elements
        if (bbox.length == 4) {
          double x = bbox[0].toDouble() * scaleX;
          double y = bbox[1].toDouble() * scaleY;
          double width = bbox[2].toDouble() * scaleX;
          double height = bbox[3].toDouble() * scaleY;

          // Draw the bounding box
          paint.color =
          detection['label'] == 'Human' ? Colors.red : Colors.green;
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
