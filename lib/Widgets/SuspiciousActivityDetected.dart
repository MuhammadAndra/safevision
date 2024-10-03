import 'package:flutter/material.dart';

class Suspiciousactivitydetected extends StatelessWidget {
  const Suspiciousactivitydetected({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      // Padding inside the container
      decoration: BoxDecoration(
        color: Colors.lightGreen[100], // Light green background color
        borderRadius: BorderRadius.circular(40.0), // Rounded corners
      ),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.grey.shade700, // Icon color
          ),
          const SizedBox(width: 8.0), // Space between icon and text
          const Text(
            'No suspicious activity detected',
            style: TextStyle(
              // color: Colors.grey, // Text color
              // fontWeight: FontWeight.w500, // Text weight
            ),
          ),
        ],
      ),
    );
  }
}
