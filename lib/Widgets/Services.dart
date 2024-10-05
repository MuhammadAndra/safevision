import 'package:flutter/material.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    Color usedColor = Theme.of(context).colorScheme.surfaceContainerHigh;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        service(context, 'Live Camera', Icons.videocam_outlined, usedColor,
            "service/livecamera"),
        service(
            context, 'Microphone', Icons.mic, usedColor, "service/microphone"),
        service(
            context, 'Add Person', Icons.add, usedColor, "service/addperson"),
        service(context, 'Stats', Icons.insert_chart_outlined, usedColor,
            "service/stats"),
      ],
    );
  }

  service(BuildContext context, title, IconData icon, Color usedColor,
      String route) {
    Color selectedColor = usedColor;
    String selectedTitle = title;
    IconData selectedIcon = icon;

    return Column(
      children: [
        IconButton.filled(
          padding: EdgeInsets.all(24),
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          icon: Icon(selectedIcon),
          color: Colors.black,
          style: IconButton.styleFrom(
            backgroundColor:
                selectedColor, // Set your desired circle color here
          ),
        ),
        SizedBox(height: 10),
        Text(
          selectedTitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        )
      ],
    );
  }
}
