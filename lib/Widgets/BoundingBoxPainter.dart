import 'package:flutter/material.dart';

class BoundingBoxPainter extends CustomPainter {
  final List<dynamic> detections;
  final double imageWidth;
  final double imageHeight;

  BoundingBoxPainter(this.detections, this.imageWidth, this.imageHeight);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    double scaleX = size.width / imageWidth;
    double scaleY = size.height / imageHeight;

    for (var detection in detections) {
      if (detection['bbox'] != null) {
        List<dynamic> bbox = detection['bbox'];
        if (bbox.length == 4) {
          double x = bbox[0].toDouble() * scaleX;
          double y = bbox[1].toDouble() * scaleY;
          double width = bbox[2].toDouble() * scaleX;
          double height = bbox[3].toDouble() * scaleY;

          paint.color =
          detection['label'] == 'Human' ? Colors.red : Colors.green;
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
