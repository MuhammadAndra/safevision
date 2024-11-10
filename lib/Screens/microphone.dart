import 'package:flutter/material.dart';
import 'package:safevision/Widgets/ActivityChart.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:safevision/Widgets/CameraCarousel.dart';
import 'package:safevision/Widgets/ConnectedDevice.dart';
import 'package:safevision/Widgets/DropdownWidget.dart';
import 'package:safevision/Widgets/MicrophoneButton.dart';
import 'package:safevision/Widgets/SectionTitle.dart';
import 'package:safevision/Widgets/Services.dart';
import 'package:safevision/Widgets/SuspiciousActivityDetected.dart';
import 'package:m3_carousel/m3_carousel.dart';
import 'package:avatar_glow/avatar_glow.dart';

class Microphone extends StatefulWidget {
  const Microphone({super.key});

  @override
  State<Microphone> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Microphone> {
  int _counter = 0;
  double _scale = 2.0;

  List<String> list = <String>[
    'MIC-1',
    'MIC-2',
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarwidget(
          title: 'Microphone', subtitle: '1 Device Connected'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    SizedBox(height: 20),
                    Cameracarousel(),
                    SizedBox(height: 20),
                    DropdownWidget(list: list),
                    SizedBox(height: 20),
                    Text("Hold to speak")
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MicrophoneButton(),
                SizedBox(height: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
