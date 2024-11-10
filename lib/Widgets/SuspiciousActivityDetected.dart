import 'package:flutter/material.dart';

class Suspiciousactivitydetected extends StatelessWidget {
  const Suspiciousactivitydetected({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.lightGreen[100],
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.grey.shade700,
          ),
          const SizedBox(width: 8.0),
          const Text(
            'No suspicious activity detected',
            style: TextStyle(
            ),
          ),
        ],
      ),
    );
  }
}
