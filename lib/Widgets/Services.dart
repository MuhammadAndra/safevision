import 'package:flutter/material.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    Color usedColor = Theme.of(context).colorScheme.secondaryContainer;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        service('Live Camera', Icons.videocam_outlined, usedColor),
        service('Microphone', Icons.mic, usedColor),
        service('Add Person', Icons.add, usedColor),
        service('Stats', Icons.insert_chart_outlined, usedColor),
      ],
    );
  }

  service(String title, IconData icon, Color usedColor) {
    Color selectedColor = usedColor;
    String selectedTitle = title;
    IconData selectedIcon = icon;

    return Column(
      children: [
        IconButton.filled(
          padding: EdgeInsets.all(24),
          onPressed: () {},
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
          ),
        )
      ],
    );
  }
}
